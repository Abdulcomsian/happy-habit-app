import 'package:intl/intl.dart';

extension DegreesToRadians on num {
  double get degree => this * (3.1415926535 / 180.0);
}

extension PriceFormatter on num {
  String formatPrice({String locale = 'en_US', int decimalDigits = 2}) {
    return NumberFormat.currency(
      locale: locale,
      symbol: '\$',  // No currency symbol, we will manually add $
      decimalDigits: decimalDigits,
    ).format(this);
  }
}