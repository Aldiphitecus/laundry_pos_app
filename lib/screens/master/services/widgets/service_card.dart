import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/action_button_widget.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String servicePrice;
  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.servicePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    servicePrice,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionButtonWidget(
                  buttonTitle: 'Ubah',
                  buttonIcon: Icons.edit_rounded,
                  buttonColor: Colors.orange,
                  buttonAction: () {},
                ),
                const SizedBox(width: 8),
                ActionButtonWidget(
                  buttonTitle: 'Hapus',
                  buttonIcon: Icons.delete_rounded,
                  buttonColor: Colors.red,
                  buttonAction: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
