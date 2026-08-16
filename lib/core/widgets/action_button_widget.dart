import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final String buttonTitle;
  final IconData buttonIcon;
  final Color buttonColor;
  final VoidCallback buttonAction;

  const ActionButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.buttonIcon,
    required this.buttonColor,
    required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: buttonAction,
      icon: Icon(buttonIcon),
      label: Text(buttonTitle, style: TextStyle(fontSize: 15)),
      style: OutlinedButton.styleFrom(
        foregroundColor: buttonColor,
        backgroundColor: buttonColor.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: buttonColor),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
