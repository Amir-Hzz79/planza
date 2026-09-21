import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/data/models/hobby_session_model.dart';

/// Computed statistics for a hobby
class HobbyStats {
  final int totalSessions;
  final int totalMinutes;
  final int currentStreak;
  final int longestStreak;
  final double averageMood;
  final int sessionsThisWeek;
  final int minutesThisWeek;

  const HobbyStats({
    this.totalSessions = 0,
    this.totalMinutes = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.averageMood = 0,
    this.sessionsThisWeek = 0,
    this.minutesThisWeek = 0,
  });

  factory HobbyStats.compute(HobbyModel hobby, List<HobbySessionModel> sessions) {
    if (sessions.isEmpty) {
      return const HobbyStats();
    }

    final now = DateTime.now();
    final weekStart = DateTime(now.year, now.month, now.day);
    final weekEnd = weekStart.add(const Duration(days: 7));

    int totalMin = 0;
    int moodSum = 0;
    int moodCount = 0;
    int thisWeekSessions = 0;
    int thisWeekMinutes = 0;
    final sessionDates = <DateTime>[];

    for (final s in sessions) {
      final dur = s.durationMinutes ?? 0;
      totalMin += dur;

      if (s.mood != null) {
        moodSum += s.mood!;
        moodCount++;
      }

      final date = DateTime(s.startTime.year, s.startTime.month, s.startTime.day);
      sessionDates.add(date);

      if (s.startTime.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          s.startTime.isBefore(weekEnd)) {
        thisWeekSessions++;
        thisWeekMinutes += dur;
      }
    }

    // Sort dates descending for streak calculation
    sessionDates.sort((a, b) => b.compareTo(a));

    int currentStreak = 0;
    int longestStreak = 0;
    if (sessionDates.isNotEmpty) {
      var expected = sessionDates[0];
      var streak = 1;
      longestStreak = 1;

      for (var i = 1; i < sessionDates.length; i++) {
        final diff = expected.difference(sessionDates[i]).inDays;
        if (diff == 1) {
          streak++;
          if (streak > longestStreak) longestStreak = streak;
        } else if (diff > 1) {
          streak = 1;
        }
        expected = sessionDates[i];
      }
      currentStreak = streak;
    }

    // Recalculate longest streak more accurately
    if (sessionDates.length > 1) {
      final sorted = List<DateTime>.from(sessionDates)..sort();
      int maxStreak = 1;
      int curStreak = 1;
      for (var i = 1; i < sorted.length; i++) {
        if (sorted[i].difference(sorted[i - 1]).inDays == 1) {
          curStreak++;
          if (curStreak > maxStreak) maxStreak = curStreak;
        } else {
          curStreak = 1;
        }
      }
      longestStreak = maxStreak;
    }

    return HobbyStats(
      totalSessions: sessions.length,
      totalMinutes: totalMin,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      averageMood: moodCount > 0 ? moodSum / moodCount : 0,
      sessionsThisWeek: thisWeekSessions,
      minutesThisWeek: thisWeekMinutes,
    );
  }

  String get totalTimeDisplay {
    if (totalMinutes < 60) return '$totalMinutes min';
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    return m == 0 ? '$h h' : '$h h $m min';
  }

  String get weeklyTimeDisplay {
    if (minutesThisWeek < 60) return '$minutesThisWeek min';
    final h = minutesThisWeek ~/ 60;
    final m = minutesThisWeek % 60;
    return m == 0 ? '$h h' : '$h h $m min';
  }
}
