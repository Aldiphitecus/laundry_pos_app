import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class CreateTransaction extends StatelessWidget {
  const CreateTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Buat Transaksi'),
      body: Center(child: const Text('Halaman buat transaksi')),
    );
  }
}
