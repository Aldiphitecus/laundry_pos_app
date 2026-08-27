import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
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
    return Scaffold(
      appBar: MainAppBar(title: 'Transaksi Baru'),
      body: Center(child: const Text('Halaman untuk membuat transaksi baru')),
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
