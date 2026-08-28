import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/selected_service_card.dart';
import 'package:laundry_pos_app/screens/home/create_transaction/widgets/services_selection.dart';

class CreateTransaction extends StatelessWidget {
  const CreateTransaction({super.key});

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
    const dummySelectedServices = [
      {'name': 'Cuci Setrika', 'price': 5000, 'unit': 'kg', 'qty': 3},
      {'name': 'Cuci Kering', 'price': 4000, 'unit': 'kg', 'qty': 2},
      {'name': 'Setrika Saja', 'price': 6000, 'unit': 'kg', 'qty': 2},
    ];

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
                itemCount: dummySelectedServices.length,
                itemBuilder: (context, index) {
                  final item = dummySelectedServices[index];
                  return SelectedServiceCard(
                    serviceName: item['name'] as String,
                    servicePrice: item['price'] as int,
                    serviceUnit: item['unit'] as String,
                    qty: item['qty'] as int,
                    onIncrement: () {},
                    onDecrement: () {},
                    onRemove: () {},
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
