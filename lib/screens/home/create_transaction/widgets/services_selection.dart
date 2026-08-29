import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/services/database_service.dart';
import 'package:laundry_pos_app/models/service_model.dart';
import 'package:laundry_pos_app/models/service_selected_model.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/service_selection_card.dart';

class ServicesSelection extends StatefulWidget {
  final List<ServiceSelectedModel> initialSelected;

  const ServicesSelection({super.key, this.initialSelected = const []});

  @override
  State<ServicesSelection> createState() => _ServicesSelectionState();
}

class _ServicesSelectionState extends State<ServicesSelection> {
  late Future<Either<String, List<ServiceModel>>> _servicesFuture;
  late List<ServiceSelectedModel> _selectedServices;

  @override
  void initState() {
    super.initState();
    _servicesFuture = DatabaseService.instance.getAllServices();
    _selectedServices = List.from(widget.initialSelected);
  }

  void _toggleService(ServiceModel service) {
    setState(() {
      final index = _selectedServices.indexWhere(
        (item) => item.id == service.id,
      );
      if (index >= 0) {
        _selectedServices.removeAt(index);
      } else {
        _selectedServices.add(
          ServiceSelectedModel(
            id: service.id,
            name: service.name,
            price: service.price,
            unit: service.unit,
            qty: 1,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedServices.length;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 10,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pilih Layanan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          FutureBuilder<Either<String, List<ServiceModel>>>(
            future: _servicesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  heightFactor: 5,
                  child: CircularProgressIndicator(),
                );
              }

              final result = snapshot.data;
              if (result == null) return const SizedBox();

              return result.fold(
                (error) => Center(
                  heightFactor: 5,
                  child: Text('Gagal memuat data: $error'),
                ),
                (services) {
                  if (services.isEmpty) {
                    return const Center(
                      heightFactor: 5,
                      child: Text('Belum ada layanan.'),
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 118,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: services.map((service) {
                      final isSelected = _selectedServices.any(
                        (item) => item.id == service.id,
                      );

                      return ServiceSelectionCard(
                        serviceName: service.name,
                        servicePrice: service.price,
                        serviceUnit: service.unit,
                        isSelected: isSelected,
                        onTap: () => _toggleService(service),
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, _selectedServices);
                  },
                  child: Text(
                    selectedCount > 0
                        ? 'Selesai terpilih ($selectedCount)'
                        : 'Selesai',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
