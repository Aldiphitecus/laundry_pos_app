import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/services/database_service.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/widgets/action_button_widget.dart';
import 'package:laundry_pos_app/models/service_model.dart';
import 'package:laundry_pos_app/screens/master/services/widgets/edit_service_form.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onChanged;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onChanged,
  });

  void _showEditModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditServiceForm(service: service),
    );
    onChanged();
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Hapus Layanan',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Yakin ingin menghapus "${service.name}"? Tindakan ini tidak bisa dibatalkan.',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal', style: TextStyle(fontSize: 17)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _handleDelete(context);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    final result = await DatabaseService.instance.deleteService(service.id!);
    if (!context.mounted) return;
    result.fold(
      (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
      (rowsAffected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Layanan berhasil dihapus')),
        );
        onChanged();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.name,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${CurrencyFormatter.format(service.price)} / ${service.unit}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ActionButtonWidget(
                            buttonTitle: 'Ubah',
                            buttonIcon: Icons.edit_rounded,
                            buttonColor: Colors.orange,
                            buttonAction: () => _showEditModal(context),
                          ),
                          const SizedBox(width: 8),
                          ActionButtonWidget(
                            buttonTitle: 'Hapus',
                            buttonIcon: Icons.delete_rounded,
                            buttonColor: Colors.red,
                            buttonAction: () =>
                                _showDeleteConfirmation(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
