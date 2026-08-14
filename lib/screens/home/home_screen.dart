import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/constants/filter_item.dart';
import 'package:laundry_pos_app/core/widgets/activity_card.dart';
import 'package:laundry_pos_app/core/widgets/filter_chip_button.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/screens/home/widgets/activity_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/information_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/total_transactions_widget.dart';
import 'package:laundry_pos_app/screens/home/widgets/chart_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Laundry POS'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
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
                    InformationWidget(),
                    // TOTAL TRANSACTION
                    TotalTransactionsWidget(),
                    // CHART
                    ChartWidget(),
                    const SizedBox(height: 18.0),
                    // NEWEST ACTIVITY
                    ActivityWidget(),
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
