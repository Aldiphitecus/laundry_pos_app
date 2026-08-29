import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/models/service_selected_model.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/selected_service_card.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/services_selection.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final List<ServiceSelectedModel> _selectedServices = [
    ServiceSelectedModel(
      id: 1,
      name: 'Cuci Setrika',
      price: 5000,
      unit: 'kg',
      qty: 1,
    ),
    ServiceSelectedModel(
      id: 2,
      name: 'Cuci Kering',
      price: 4000,
      unit: 'kg',
      qty: 2,
    ),
    ServiceSelectedModel(
      id: 3,
      name: 'Cuci Kering Selimut',
      price: 6000,
      unit: 'item',
      qty: 1,
    ),
    ServiceSelectedModel(
      id: 4,
      name: 'Cuci Kering Sepatu',
      price: 8000,
      unit: 'pasang',
      qty: 1,
    ),
  ];

  void _showServicesModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ServicesSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Transaksi Baru'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Layanan Dipilih',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 73),
                itemCount: _selectedServices.length,
                itemBuilder: (context, index) {
                  final item = _selectedServices[index];
                  return SelectedServiceCard(
                    serviceName: item.name,
                    servicePrice: item.price,
                    serviceUnit: item.unit,
                    qty: item.qty,
                    onQtyChanged: (newQty) {},
                    onRemove: () {
                      setState(() {
                        _selectedServices.removeWhere((s) => s.id == item.id);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServicesModal(context),
        label: const Text(
          'Pilih Layanan',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
