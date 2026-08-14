import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/core/widgets/menu_card.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Data Utama'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Data Utama',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Kelola invetaris, kategori, dan data pelanggan Anda.',
                style: TextStyle(fontSize: 17.0),
              ),
              const SizedBox(height: 20.0),
              MenuCard(),
            ],
          ),
        ),
      ),
    );
  }
}
