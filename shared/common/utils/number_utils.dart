import 'package:easy_localization/easy_localization.dart';

class NumberUtils {
  static double roundDouble({
    required double value,
    required int places,
  }) {
    double mod = 10.0 * places;
    return ((value * mod).round().toDouble() / mod);
  }

  static double roundPrice(double price) {
    return roundDouble(value: price, places: 2);
  }

  static double roundPercentage(double percentage) {
    return roundDouble(value: percentage, places: 2);
  }

  static String getFormattedPrice(double price) {
    // apply fixed 2 decimal places
    // apply thousand separator
    return NumberFormat('#,##0.00').format(price);
  }
}
