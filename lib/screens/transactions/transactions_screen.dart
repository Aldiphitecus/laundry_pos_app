import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Riwayat Transaksi'),
      body: Center(child: const Text('Riwayat transaksi')),
    );
  }
}
