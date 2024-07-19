import '../../config/config.dart';

class DateFormatUtils {
  static String convertDateTimeDisplay(String? date) {
    if (date == "") {
      return "";
    }
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormatter.parse(date!);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }
}
