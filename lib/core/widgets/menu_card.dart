import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {
          print('You clicked!');
        },
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.miscellaneous_services,
                    size: 35.0,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Daftar Layanan',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
              Text(
                'Tambah, ubah, atau hapus layanan yang Anda tawarkan.',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
