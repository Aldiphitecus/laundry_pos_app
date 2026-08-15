import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/core/widgets/header_menu_widget.dart';
import 'package:laundry_pos_app/core/widgets/main_app_bar.dart';
import 'package:laundry_pos_app/core/widgets/menu_card.dart';
import 'package:laundry_pos_app/screens/master/services/service_list_screen.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Data Utama'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderMenuWidget(
              menuTitle: 'Data Utama',
              menuDescription:
                  'Kelola berbagai data penting yang mendukung operasional laundry Anda.',
              menuIcon: Icons.dashboard_customize_outlined,
            ),
            const SizedBox(height: 28),
            const Text(
              'MENU',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            MenuCard(
              menuTitle: 'Daftar Layanan',
              menuDescription:
                  'Tambah, ubah, atau hapus layanan yang Anda tawarkan.',
              menuIcon: Icons.miscellaneous_services,
              iconColor: AppColors.secondary,
              onMenuTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
