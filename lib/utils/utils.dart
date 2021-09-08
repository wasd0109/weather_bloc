class Utils {
  static String doubleToStringForDisplay(double? d) {
    if (d == null) return "Error";
    return d.toStringAsFixed(1).replaceFirst(RegExp(r'\.?0*$'), '');
  }
}
