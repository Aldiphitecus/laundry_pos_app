import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CHART TRANSAKSI',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 9.0),
          ],
        ),
      ),
    );
  }
}
