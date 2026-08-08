import 'package:flutter/material.dart';
import 'package:laundry_pos_app/models/filter_item.dart';

class FilterChipButton extends StatelessWidget {
  final FilterItem filter;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const FilterChipButton({
    super.key,
    required this.filter,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(filter.filterName),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}
