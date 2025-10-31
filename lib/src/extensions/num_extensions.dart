extension IntX on num {
  String toStringAndFill({int length = 2, String value = '0'}) => toString().padLeft(length, value);
}

extension DoubleX on double {
  double truncateToDecimals(int decimals) =>
      double.parse(toStringAsFixed(decimals));
}