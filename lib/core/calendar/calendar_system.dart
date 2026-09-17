abstract class CalendarSystem {
  String get localeCode;
  String get displayName;

  DateTime toGregorian(DateTime local);
  DateTime fromGregorian(DateTime gregorian);

  String formatFullDate(DateTime date);
  String formatShortDate(DateTime date);
  String formatMonthYear(DateTime date);
  String formatDayMonth(DateTime date);
  String formatWeekday(DateTime date);

  List<DateTime> getWeekDays(DateTime weekStart);
  int getDaysInMonth(int year, int month);
  int getWeeksInMonth(int year, int month);
  DateTime getFirstDayOfWeek(DateTime date);
  DateTime getLastDayOfWeek(DateTime date);

  bool isToday(DateTime date);
  bool isSameDay(DateTime a, DateTime b);
  bool isBeforeToday(DateTime date);
  bool isAfterToday(DateTime date);

  DateTime addDays(DateTime date, int days);
  DateTime addMonths(DateTime date, int months);
  DateTime addYears(DateTime date, int years);

  DateTime startOfDay(DateTime date);
  DateTime endOfDay(DateTime date);
  DateTime startOfMonth(int year, int month);
  DateTime endOfMonth(int year, int month);
  DateTime startOfYear(int year);
  DateTime endOfYear(int year);
}

extension CalendarSystemExtensions on CalendarSystem {
  DateTime normalizeToGregorian(DateTime date) => toGregorian(date);
  DateTime denormalizeFromGregorian(DateTime date) => fromGregorian(date);

  String formatForDisplay(DateTime gregorianDate) =>
      formatFullDate(fromGregorian(gregorianDate));
  String formatShortForDisplay(DateTime gregorianDate) =>
      formatShortDate(fromGregorian(gregorianDate));

  int differenceInDays(DateTime a, DateTime b) {
    final ga = toGregorian(a);
    final gb = toGregorian(b);
    return ga.difference(gb).inDays;
  }

  DateTime now() => fromGregorian(DateTime.now());
}
