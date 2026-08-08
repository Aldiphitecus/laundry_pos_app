import 'package:laundry_pos_app/models/filter_item.dart';

class FilterItems {
  static const filterItems = [
    FilterItem(filterName: 'Today', filterValue: 'today'),
    FilterItem(filterName: 'Week', filterValue: 'week'),
    FilterItem(filterName: 'Month', filterValue: 'month'),
    FilterItem(filterName: 'Year', filterValue: 'year'),
    FilterItem(filterName: 'All', filterValue: 'all'),
  ];
}
