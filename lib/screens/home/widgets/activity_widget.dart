import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/activity_card.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class ActivityWidget extends StatelessWidget {
  final void Function(int) onNavigateToTab;
  const ActivityWidget({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Aktifitas Terbaru',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),

            TextButton(
              onPressed: () => onNavigateToTab(1),
              child: const Text(
                'Lihat semua',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Column(
          children: [
            ActivityCard(notaCode: "LN-140626", totalPrice: 125000),
            ActivityCard(notaCode: "LN-140626", totalPrice: 125000),
            ActivityCard(notaCode: "LN-140626", totalPrice: 125000),
          ],
        ),
      ],
    );
  }
}
