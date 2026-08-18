import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/constants/filter_item.dart';
import 'package:laundry_pos_app/core/widgets/filter_chip_button.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/screens/home/widgets/activity_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/information_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/total_transactions_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/chart_widget.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int) onNavigateToTab;
  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _dataFilterBy = 'today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Laundry POS'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // FILTER LISTS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: FilterItems.filterItems.map((filter) {
                    return FilterChipButton(
                      filter: filter,
                      selected: filter.filterValue == _dataFilterBy,
                      onSelected: (selected) {
                        setState(() {
                          _dataFilterBy = filter.filterValue;
                        });
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
                    InformationWidget(),
                    // TOTAL TRANSACTION
                    TotalTransactionsWidget(),
                    // CHART
                    ChartWidget(),
                    // CREATE TRANSACTION BUTTON
                    ElevatedButton.icon(
                      onPressed: () {
                        print("You clicked");
                      },
                      label: const Text(
                        'Buat transaksi',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    // NEWEST ACTIVITY
                    ActivityWidget(onNavigateToTab: widget.onNavigateToTab),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
