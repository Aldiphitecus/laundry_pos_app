import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class CreateTransaction extends StatelessWidget {
  const CreateTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Transaksi Baru'),
      body: Center(child: const Text('Halaman untuk membuat transaksi baru')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('You clicked');
        },
        label: const Text(
          'Pilih Layanan',
          style: const TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
