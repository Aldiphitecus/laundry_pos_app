import 'package:flutter/material.dart';
import 'package:laundry_pos_app/core/constants/app_colors.dart';

class MenuCard extends StatelessWidget {
  final String menuTitle;
  final String menuDescription;
  final IconData menuIcon;
  final Color iconColor;
  final VoidCallback onMenuTap;

  const MenuCard({
    super.key,
    required this.menuTitle,
    required this.menuDescription,
    required this.menuIcon,
    required this.iconColor,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: onMenuTap,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(menuIcon, size: 35.0, color: iconColor),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                menuTitle,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              Text(
                menuDescription,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
