import '../../config/config.dart';

const _locale = 'en';

class AmountHelper {
  static String formatAmount(String s) => NumberFormat.decimalPattern(_locale).format(double.parse(s));
}
