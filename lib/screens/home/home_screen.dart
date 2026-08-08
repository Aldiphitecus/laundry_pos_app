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

            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: [Text('Text')]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
