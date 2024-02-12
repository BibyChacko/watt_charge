import 'package:jiffy/jiffy.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime,
      {String pattern = "dd MMM yyyy"}) {
    return Jiffy.parseFromDateTime(dateTime).format(pattern: pattern);
  }
}
