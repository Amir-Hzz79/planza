import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../locale/app_localizations.dart';

/// A helper class to handle all date formatting based on the app's current locale.
/// It correctly formats a universal `DateTime` object into either a
/// Gregorian or Shamsi (Jalali) string.
class AppDateFormatter {
  final BuildContext context;

  factory AppDateFormatter.of(BuildContext context) {
    return AppDateFormatter._(context);
  }

  AppDateFormatter._(this.context);

  Locale get _locale => Localizations.localeOf(context);
  Lang get _strings => Lang.of(context)!;

  bool get _isFarsi => _locale.languageCode == 'fa';

  /// Formats a date into a full, readable string like "June 28, 2025" or "۷ تیر ۱۴۰۴".
  String formatFullDate(DateTime? dt) {
    if (dt == null) return _strings.general_noDate;

    if (_isFarsi) {
      final jalaliDate = dt.toJalali();

      final f = jalaliDate.formatter;

      return '${f.wN}، ${f.d} ${f.mN} ${f.y}';
    } else {
      return DateFormat.yMMMMd(_locale.toString()).format(dt);
    }
  }

  /// Formats a date into a shorter version, e.g., "Jun 28" or "۷ تیر".
  String formatShortDate(DateTime? dt) {
    if (dt == null) return _strings.general_noDate;

    if (_isFarsi) {
      final jalaliDate = dt.toJalali();
      final f = jalaliDate.formatter;
      return '${f.d} ${f.mN}';
    } else {
      return DateFormat.MMMd().format(dt);
    }
  }

  /// Returns a relative string for a date, like "Today", "Tomorrow", or "Overdue".
  /// For other future dates, just show the formatted date.
  String formatRelativeDay(DateTime? dt) {
    if (dt == null) return _strings.general_noDate;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final checkDate = DateTime(dt.year, dt.month, dt.day);

    if (checkDate == today) return _strings.general_today;
    if (checkDate == tomorrow) return _strings.general_tomarrow;
    if (checkDate.isBefore(today)) return _strings.general_overdue;

    return formatShortDate(dt);
  }
}
