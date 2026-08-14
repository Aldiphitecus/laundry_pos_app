import 'package:flutter/material.dart';

class TotalTransactionsWidget extends StatelessWidget {
  const TotalTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'JUMLAH TRANSAKSI',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 7.0),
            const Text(
              '142',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
