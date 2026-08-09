import 'package:laundry_pos_app/models/filter_item.dart';

class FilterItems {
  static const filterItems = [
    FilterItem(filterName: 'Hari ini', filterValue: 'today'),
    FilterItem(filterName: 'Minggu ini', filterValue: 'week'),
    FilterItem(filterName: 'Bulan ini', filterValue: 'month'),
    FilterItem(filterName: 'Tahun ini', filterValue: 'year'),
    FilterItem(filterName: 'Semua', filterValue: 'all'),
  ];
}
