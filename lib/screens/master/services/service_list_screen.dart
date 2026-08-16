import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/services/database_service.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/models/service_model.dart';
import 'package:laundry_pos_app/screens/master/services/widgets/add_service_form.dart';
import 'package:laundry_pos_app/screens/master/services/widgets/service_card.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  late Future<Either<String, List<ServiceModel>>> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _servicesFuture = DatabaseService.instance.getAllServices();
  }

  void _refreshServices() {
    setState(() {
      _servicesFuture = DatabaseService.instance.getAllServices();
    });
  }

  void _showAddServiceModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddServiceForm(),
    );
    _refreshServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Daftar Layanan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          right: 10.0,
          bottom: 75.0,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 30),
                hintText: 'Cari layanan...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            FutureBuilder<Either<String, List<ServiceModel>>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final result = snapshot.data;
                if (result == null) return const SizedBox();

                return result.fold(
                  (error) => Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Gagal memuat data: $error',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  (services) {
                    if (services.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Belum ada layanan.\nTap tombol "+ Tambah Layanan" untuk menambahkan.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: services.map((service) {
                        return ServiceCard(
                          serviceName: service.name,
                          servicePrice:
                              '${CurrencyFormatter.format(service.price)} / ${service.unit}',
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddServiceModal(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Tambah Layanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
