import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';
import 'package:laundry_pos_app/screens/home/home_screen.dart';
import 'package:laundry_pos_app/screens/master/master_screen.dart';
import 'package:laundry_pos_app/screens/setting/setting_screen.dart';
import 'package:laundry_pos_app/screens/transactions/transactions_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onNavigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onNavigateToTab: _onNavigateToTab),
      TransactionsScreen(),
      MasterScreen(),
      SettingScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onNavigateToTab,
          indicatorColor: AppColors.primary,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              );
            }
            return TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            );
          }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              selectedIcon: Icon(Icons.home_rounded, color: Colors.white),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_rounded),
              selectedIcon: Icon(Icons.history_rounded, color: Colors.white),
              label: 'Riwayat',
            ),
            NavigationDestination(
              icon: Icon(Icons.dataset_rounded),
              selectedIcon: Icon(Icons.dataset_rounded, color: Colors.white),
              label: 'Data Utama',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              selectedIcon: Icon(Icons.settings_rounded, color: Colors.white),
              label: 'Pengaturan',
            ),
          ],
        ),
      ),
    );
  }
}
