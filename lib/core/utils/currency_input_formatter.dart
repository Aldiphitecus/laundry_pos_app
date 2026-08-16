import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final number = int.parse(digitsOnly);
    final formatter = NumberFormat.decimalPattern('id_ID').format(number);
    return TextEditingValue(
      text: formatter,
      selection: TextSelection.collapsed(offset: formatter.length),
    );
  }
}
