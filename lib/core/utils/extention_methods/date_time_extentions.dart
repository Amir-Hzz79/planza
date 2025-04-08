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

  /// Compares a date to current date and checks if the first is before today, based only on the date component (Ignore time).
  bool isBeforeToday() {
    final now = DateTime.now();
    return DateTime(year, month, day).isBefore(
      DateTime(now.year, now.month, now.day),
    );
  }

  /// Compares a date to current date and checks if the first is after today, based only on the date component (Ignore time).
  bool isAfterToday() {
    final now = DateTime.now();
    return DateTime(year, month, day).isAfter(
      DateTime(now.year, now.month, now.day),
    );
  }

  bool isToday() => sameDay(DateTime.now());
}
