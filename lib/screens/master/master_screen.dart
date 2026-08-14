import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Master Data'),
      body: Center(child: Text('Master data')),
    );
  }
}
