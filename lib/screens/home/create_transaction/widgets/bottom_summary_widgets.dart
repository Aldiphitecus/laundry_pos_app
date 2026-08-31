import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/utils/currency_formatter.dart';

class ServiceDetailItem {
  final String name;
  final int qty;
  final int price;
  final String unit;

  const ServiceDetailItem({
    required this.name,
    required this.qty,
    required this.price,
    required this.unit,
  });

  int get total => qty * price;
}

class BottomSummaryWidgets extends StatefulWidget {
  const BottomSummaryWidgets({super.key});

  @override
  State<BottomSummaryWidgets> createState() => _BottomSummaryWidgetsState();
}

class _BottomSummaryWidgetsState extends State<BottomSummaryWidgets> {
  bool _isExpanded = false;

  final List<ServiceDetailItem> _services = const [
    ServiceDetailItem(
      name: 'Cuci Kering (kg)',
      qty: 3,
      price: 7000,
      unit: 'kg',
    ),
    ServiceDetailItem(name: 'Setrika (kg)', qty: 3, price: 5000, unit: 'item'),
    ServiceDetailItem(
      name: 'Express 6 Jam',
      qty: 1,
      price: 15000,
      unit: 'pasang',
    ),
  ];

  int get _totalPrice => _services.fold(0, (sum, item) => sum + item.total);

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
                    'Lihat Detil',
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
                        ..._services.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        '${item.qty} ${item.unit} x ${CurrencyFormatter.format(item.price)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  CurrencyFormatter.format(item.total),
                                  style: TextStyle(
                                    fontSize: 13,
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
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () {},
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
