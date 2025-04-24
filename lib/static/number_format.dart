import 'package:intl/intl.dart';

class NumberUtils {
  static String commaDecimal(num value, int decimal) {
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(value);
  }
}
