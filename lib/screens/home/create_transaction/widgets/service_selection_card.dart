import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class ServiceSelectionCard extends StatelessWidget {
  final String serviceName;
  final int servicePrice;
  final String serviceUnit;

  const ServiceSelectionCard({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.primary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  size: 30,
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              serviceName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              '${CurrencyFormatter.format(servicePrice)}/$serviceUnit',
              style: const TextStyle(fontSize: 15, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
