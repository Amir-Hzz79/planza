import 'package:intl/intl.dart';

extension DateTimeExtentions on DateTime {
  String formatShortDate() {
    return DateFormat('yyyy/MM/dd').format(this);
  }

  bool sameDay(DateTime anotherDateTime) {
    return year == anotherDateTime.year &&
        month == anotherDateTime.month &&
        day == anotherDateTime.day;
  }

  bool sameMonth(DateTime anotherDateTime) {
    return year == anotherDateTime.year && month == anotherDateTime.month;
  }

  bool sameYear(DateTime anotherDateTime) {
    return year == anotherDateTime.year;
  }
}
