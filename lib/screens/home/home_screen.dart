import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/constants/filter_item.dart';
import 'package:laundry_pos_app/core/widgets/filter_chip_button.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Laundry POS'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // FILTER LISTS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FilterItems.filterItems.map((filter) {
                  return FilterChipButton(
                    filter: filter,
                    selected: filter.filterValue == 'today',
                    onSelected: (selected) {
                      print(filter.filterValue);
                    },
                  );
                }).toList(),
              ),
            ),

            // INFORMATION
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TOTAL TRANSACTION PRICE
                  Card(
                    color: AppColors.primary,
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PENJUALAN HARI INI',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 7.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rp 2.500.000',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 5.0,
                                      horizontal: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.trending_up,
                                          color: Colors.green,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text(
                                          '+12%',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // TOTAL TRANSACTION
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'JUMLAH TRANSAKSI',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          const Text(
                            '142',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // CHART
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CHART TRANSAKSI',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 9.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  // NEWEST ACTIVITY
                  const Text(
                    'Aktifitas Terbaru',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
