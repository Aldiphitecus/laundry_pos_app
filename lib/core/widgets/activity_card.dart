import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class ActivityCard extends StatelessWidget {
  final String notaCode;
  final String totalPrice;

  const ActivityCard({
    super.key,
    required this.notaCode,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 28.0,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                  children: [
                    Text(
                      '#$notaCode',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('2 menit yang lalu'),
                  ],
                ),
              ],
            ),
            Text(
              'Rp $totalPrice',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
