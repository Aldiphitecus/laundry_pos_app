class QtyFormatter {
  static String format(double qty, String unit) {
    if (unit.toLowerCase() != 'kg') {
      return qty.round().toString();
    }

    if (qty == qty.roundToDouble()) {
      return qty.toInt().toString();
    }

    String text = qty.toStringAsFixed(3);
    text = text.replaceFirst(RegExp(r'0+$'), '');
    text = text.replaceFirst(RegExp(r'\.$'), '');
    return text;
  }
}
