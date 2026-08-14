import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class TotalTransactionsWidget extends StatelessWidget {
  const TotalTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
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
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
