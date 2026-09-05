import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calendar_system.dart';
import 'gregorian_calendar.dart';
import 'jalali_calendar.dart';

enum CalendarType { gregorian, jalali, auto }

class CalendarService extends ChangeNotifier {
  static const String _calendarTypeKey = 'calendar_type';
  static const String _primaryCalendarKey = 'primary_calendar';

  final CalendarSystem _gregorian = GregorianCalendar();
  final CalendarSystem _jalali = JalaliCalendar();

  CalendarType _calendarType = CalendarType.auto;
  CalendarType _primaryCalendar = CalendarType.gregorian;

  CalendarType get calendarType => _calendarType;
  CalendarType get primaryCalendar => _primaryCalendar;

  CalendarSystem get primary => _getCalendar(_primaryCalendar);
  CalendarSystem get secondary => _getCalendar(_primaryCalendar == CalendarType.gregorian ? CalendarType.jalali : CalendarType.gregorian);
  CalendarSystem get gregorian => _gregorian;
  CalendarSystem get jalali => _jalali;

  CalendarService() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _calendarType = CalendarType.values[prefs.getInt(_calendarTypeKey) ?? 0];
    _primaryCalendar = CalendarType.values[prefs.getInt(_primaryCalendarKey) ?? 0];
    notifyListeners();
  }

  Future<void> setCalendarType(CalendarType type) async {
    _calendarType = type;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_calendarTypeKey, type.index);
    notifyListeners();
  }

  Future<void> setPrimaryCalendar(CalendarType calendar) async {
    _primaryCalendar = calendar;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryCalendarKey, calendar.index);
    notifyListeners();
  }

  CalendarSystem _getCalendar(CalendarType type) {
    switch (type) {
      case CalendarType.gregorian:
        return _gregorian;
      case CalendarType.jalali:
        return _jalali;
      case CalendarType.auto:
        return _getAutoCalendar();
    }
  }

  CalendarSystem _getAutoCalendar() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    if (locale.languageCode == 'fa' || locale.countryCode == 'IR') {
      return _jalali;
    }
    return _gregorian;
  }

  DateTime normalizeToGregorian(DateTime date) {
    return primary.toGregorian(date);
  }

  DateTime denormalizeFromGregorian(DateTime date) {
    return primary.fromGregorian(date);
  }

  String formatFullDate(DateTime gregorianDate) {
    return primary.formatFullDate(primary.fromGregorian(gregorianDate));
  }

  String formatShortDate(DateTime gregorianDate) {
    return primary.formatShortDate(primary.fromGregorian(gregorianDate));
  }

  String formatMonthYear(DateTime gregorianDate) {
    return primary.formatMonthYear(primary.fromGregorian(gregorianDate));
  }

  String formatDayMonth(DateTime gregorianDate) {
    return primary.formatDayMonth(primary.fromGregorian(gregorianDate));
  }

  String formatWeekday(DateTime gregorianDate) {
    return primary.formatWeekday(primary.fromGregorian(gregorianDate));
  }

  String formatWithSecondary(DateTime gregorianDate) {
    final primaryStr = formatShortDate(gregorianDate);
    final secondaryStr = secondary.formatShortDate(secondary.fromGregorian(gregorianDate));
    return '$primaryStr / $secondaryStr';
  }

  List<DateTime> getWeekDays(DateTime weekStart) {
    return primary.getWeekDays(primary.fromGregorian(weekStart));
  }

  int getDaysInMonth(int year, int month) {
    return primary.getDaysInMonth(year, month);
  }

  bool isToday(DateTime gregorianDate) {
    return primary.isToday(primary.fromGregorian(gregorianDate));
  }

  bool isSameDay(DateTime a, DateTime b) {
    return primary.isSameDay(primary.fromGregorian(a), primary.fromGregorian(b));
  }

  DateTime now() {
    return primary.now();
  }

  DateTime today() {
    return startOfDay(now());
  }

  DateTime startOfDay(DateTime date) {
    return primary.startOfDay(primary.fromGregorian(date));
  }

  DateTime endOfDay(DateTime date) {
    return primary.endOfDay(primary.fromGregorian(date));
  }

  DateTime addDays(DateTime date, int days) {
    return primary.addDays(primary.fromGregorian(date), days);
  }

  DateTime addMonths(DateTime date, int months) {
    return primary.addMonths(primary.fromGregorian(date), months);
  }

  DateTime addYears(DateTime date, int years) {
    return primary.addYears(primary.fromGregorian(date), years);
  }

  List<String> get availableCalendars => CalendarType.values.map((e) => e.name).toList();
}

extension CalendarServiceExtensions on BuildContext {
  CalendarService get calendarService => CalendarService();
}
