import 'package:intl/intl.dart';

class DateFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('hh:mm a dd MMM yyyy').format(date);
  }
}
