import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Pengaturan'),
      body: Center(child: Text('Pengaturan')),
    );
  }
}
