import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class ServiceSelectionCard extends StatelessWidget {
  final String serviceName;
  final int servicePrice;
  final String serviceUnit;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceSelectionCard({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceUnit,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? AppColors.primary
              : Colors.grey.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    isSelected
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 30,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.withValues(alpha: 0.5),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                serviceName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '${CurrencyFormatter.format(servicePrice)}/$serviceUnit',
                style: const TextStyle(fontSize: 14, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
