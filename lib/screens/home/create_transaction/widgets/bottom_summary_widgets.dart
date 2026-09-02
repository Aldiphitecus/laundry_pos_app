import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';
import 'package:laundry_pos_app/core/utils/qty_formatter.dart';
import 'package:laundry_pos_app/models/service_selected_model.dart';

class BottomSummaryWidgets extends StatefulWidget {
  final List<ServiceSelectedModel> services;
  final VoidCallback onCreateTransaction;

  const BottomSummaryWidgets({
    super.key,
    required this.services,
    required this.onCreateTransaction,
  });

  @override
  State<BottomSummaryWidgets> createState() => _BottomSummaryWidgetsState();
}

class _BottomSummaryWidgetsState extends State<BottomSummaryWidgets> {
  bool _isExpanded = false;
  int get _totalPrice => widget.services.fold(
    0,
    (sum, item) => sum + (item.qty * item.price).round(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 12, 17, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  Text(
                    'Lihat Detil Layanan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.grey[700],
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        ...widget.services.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        '${QtyFormatter.format(item.qty, item.unit)} ${item.unit} x ${CurrencyFormatter.format(item.price)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  CurrencyFormatter.format(
                                    (item.qty * item.price).round(),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    )
                  : const SizedBox(width: double.infinity),
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Bayar :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  CurrencyFormatter.format(_totalPrice),
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: widget.onCreateTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              label: const Text('Buat Transaksi'),
              icon: const Icon(Icons.arrow_right_alt_rounded, size: 25),
              iconAlignment: IconAlignment.end,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
