import 'package:planza/core/data/models/hobby_model.dart';

/// Recurrence engine for hobby scheduling
class RecurrenceEngine {
  /// Check if a hobby is due on a specific date
  static bool isDueOnDate(HobbyModel hobby, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(date.year, date.month, date.day);
    
    // Don't check future dates
    if (checkDate.isAfter(today)) return false;
    
    // Check if hobby is active
    if (!hobby.isActive) return false;
    
    // Check if hobby has started (created before or on check date)
    final hobbyStart = DateTime(
      hobby.createdAt.year,
      hobby.createdAt.month,
      hobby.createdAt.day,
    );
    if (checkDate.isBefore(hobbyStart)) return false;
    
    switch (hobby.frequency) {
      case 'daily':
        return true;
      case 'weekly':
        return _isWeeklyDue(hobby, checkDate);
      case 'custom':
        return _isCustomDue(hobby, checkDate);
      default:
        return false;
    }
  }
  
  /// Check if hobby is due today
  static bool isDueToday(HobbyModel hobby) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return isDueOnDate(hobby, today);
  }
  
  /// Check weekly recurrence
  static bool _isWeeklyDue(HobbyModel hobby, DateTime date) {
    if (hobby.customFrequencyJson == null || hobby.customFrequencyJson!.isEmpty) {
      return false;
    }
    
    try {
      final days = hobby.customFrequencyJson!.split(',').map(int.parse).toSet();
      return days.contains(date.weekday); // 1=Monday, 7=Sunday
    } catch (_) {
      return false;
    }
  }
  
  /// Check custom recurrence pattern
  static bool _isCustomDue(HobbyModel hobby, DateTime date) {
    if (hobby.customFrequencyJson == null || hobby.customFrequencyJson!.isEmpty) {
      return false;
    }
    
    try {
      // Support simple patterns: "every_n_days", "every_n_weeks", "monthly_day_N"
      final pattern = hobby.customFrequencyJson!.toLowerCase();
      
      if (pattern.startsWith('every_') && pattern.contains('_days')) {
        final days = int.tryParse(pattern.replaceAll('every_', '').replaceAll('_days', '')) ?? 1;
        final hobbyStart = DateTime(
          hobby.createdAt.year,
          hobby.createdAt.month,
          hobby.createdAt.day,
        );
        final diff = DateTime(date.year, date.month, date.day).difference(hobbyStart).inDays;
        return diff % days == 0;
      }
      
      if (pattern.startsWith('every_') && pattern.contains('_weeks')) {
        final weeks = int.tryParse(pattern.replaceAll('every_', '').replaceAll('_weeks', '')) ?? 1;
        final hobbyStart = DateTime(
          hobby.createdAt.year,
          hobby.createdAt.month,
          hobby.createdAt.day,
        );
        final diffWeeks = DateTime(date.year, date.month, date.day).difference(hobbyStart).inDays ~/ 7;
        return diffWeeks % weeks == 0;
      }
      
      if (pattern.startsWith('monthly_day_')) {
        final day = int.tryParse(pattern.replaceAll('monthly_day_', '')) ?? 1;
        return date.day == day;
      }
      
      return false;
    } catch (_) {
      return false;
    }
  }
  
  /// Get all due dates in a range
  static List<DateTime> getDueDatesInRange(
    HobbyModel hobby,
    DateTime start,
    DateTime end,
  ) {
    final dueDates = <DateTime>[];
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    
    if (startDate.isAfter(endDate)) return [];
    
    var current = startDate;
    while (!current.isAfter(endDate)) {
      if (isDueOnDate(hobby, current)) {
        dueDates.add(DateTime(current.year, current.month, current.day));
      }
      current = current.add(const Duration(days: 1));
    }
    
    return dueDates;
  }
  
  /// Get next due date after a given date
  static DateTime? getNextDueDate(HobbyModel hobby, DateTime after) {
    var current = DateTime(after.year, after.month, after.day).add(const Duration(days: 1));
    
    // Look ahead up to 365 days
    for (int i = 0; i < 365; i++) {
      if (isDueOnDate(hobby, current)) {
        return DateTime(current.year, current.month, current.day);
      }
      current = current.add(const Duration(days: 1));
    }
    return null;
  }
  
  /// Parse frequency string to human readable
  static String frequencyToString(String frequency, String? customJson) {
    switch (frequency) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'custom':
        if (customJson == null || customJson.isEmpty) return 'Custom';
        final pattern = customJson.toLowerCase();
        if (pattern.startsWith('every_') && pattern.contains('_days')) {
          final days = customJson.replaceAll('every_', '').replaceAll('_days', '');
          return 'Every $days days';
        }
        if (pattern.startsWith('every_') && pattern.contains('_weeks')) {
          final weeks = customJson.replaceAll('every_', '').replaceAll('_weeks', '');
          return 'Every $weeks weeks';
        }
        if (pattern.startsWith('monthly_day_')) {
          final day = customJson.replaceAll('monthly_day_', '');
          return 'Monthly on day $day';
        }
        return 'Custom';
      default:
        return frequency.capitalize();
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}