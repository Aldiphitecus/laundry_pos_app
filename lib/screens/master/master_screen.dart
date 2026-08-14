import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/core/widgets/menu_card.dart';
import 'package:laundry_pos_app/screens/master/services/service_list_screen.dart';

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
              MenuCard(
                menuTitle: 'Daftar Layanan',
                menuDescription:
                    'Tambah, ubah, atau hapus layanan yang Anda tawarkan.',
                menuIcon: Icons.miscellaneous_services,
                iconColor: AppColors.primary,
                onMenuTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
