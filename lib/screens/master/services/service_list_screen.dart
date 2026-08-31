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
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _servicesFuture = DatabaseService.instance.getAllServices();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  void _refreshServices() {
    setState(() {
      _servicesFuture = DatabaseService.instance.getAllServices();
    });
  }

  List<ServiceModel> _filterServices(List<ServiceModel> services) {
    if (_searchQuery.isEmpty) return services;
    return services
        .where((service) => service.name.toLowerCase().contains(_searchQuery))
        .toList();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 30),
                hintText: 'Cari layanan...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
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
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: FutureBuilder<Either<String, List<ServiceModel>>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final result = snapshot.data;
                if (result == null) return const SizedBox();

                return result.fold(
                  (error) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Gagal memuat data: $error',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  (services) {
                    if (services.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Belum ada layanan.\nTap tombol "+ Tambah Layanan" untuk menambahkan.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    final filteredServices = _filterServices(services);

                    if (filteredServices.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Layanan "$_searchQuery" tidak ditemukan.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 95),
                      itemCount: filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        return ServiceCard(
                          service: service,
                          onChanged: _refreshServices,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddServiceModal(context),
        backgroundColor: AppColors.tertiary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Tambah Layanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
