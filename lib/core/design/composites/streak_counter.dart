import 'package:flutter/material.dart';
import '../../primitives/index.dart';
import '../../tokens/index.dart';

class StreakCounter extends StatelessWidget {
  final int currentStreak;
  final int? longestStreak;
  final double size;
  final bool showLabel;
  final bool animated;

  const StreakCounter({
    super.key,
    required this.currentStreak,
    this.longestStreak,
    this.size = 64,
    this.showLabel = true,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final streakColor = _getStreakColor(currentStreak, colors);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: animated ? PlMotion.medium : PlMotion.instant,
              curve: PlMotion.standard,
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    streakColor.withOpacity(0.2),
                    streakColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: streakColor.withOpacity(0.3),
                    blurRadius: size * 0.15,
                    offset: Offset(0, size * 0.05),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$currentStreak',
                  style: PlTypography.numberLarge.copyWith(
                    color: streakColor,
                    fontSize: size * 0.35,
                  ),
                ),
              ),
            ),
            if (currentStreak >= 7)
              Positioned(
                top: size * 0.05,
                right: size * 0.05,
                child: Icon(
                  Icons.local_fire_department,
                  color: streakColor,
                  size: size * 0.25,
                ),
              ),
          ],
        ),
        if (showLabel) ...[
          SizedBox(height: PlSpacing.sm),
          Text(
            currentStreak == 1 ? 'Day' : 'Days',
            style: PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
          ),
          if (longestStreak != null && longestStreak! > currentStreak) ...[
            SizedBox(height: PlSpacing.xs),
            Text(
              'Best: $longestStreak days',
              style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ],
      ],
    );
  }

  Color _getStreakColor(int streak, dynamic colors) {
    if (streak == 0) return colors.outline;
    if (streak < 3) return colors.warning;
    if (streak < 7) return colors.primary;
    if (streak < 14) return colors.success;
    if (streak < 30) return colors.tertiary;
    return colors.secondary;
  }
}

class StreakCalendar extends StatelessWidget {
  final List<DateTime> completedDates;
  final int weeksToShow;
  final double cellSize;

  const StreakCalendar({
    super.key,
    required this.completedDates,
    this.weeksToShow = 8,
    this.cellSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: weeksToShow * 7));
    final completedSet = completedDates
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(7, (i) {
            final day = DateTime(now.year, now.month, now.day)
                .subtract(Duration(days: now.weekday - 1 - i));
            return SizedBox(
              width: cellSize + 2,
              child: Center(
                child: Text(
                  _weekdayShort(day.weekday),
                  style: PlTypography.overline.copyWith(color: colors.onSurfaceVariant),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: PlSpacing.xs),
        ...List.generate(weeksToShow, (week) {
          final weekStart = startDate.add(Duration(days: week * 7));
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: List.generate(7, (day) {
                final date = weekStart.add(Duration(days: day));
                final isCompleted = completedSet.contains(DateTime(date.year, date.month, date.day));
                final isFuture = date.isAfter(now);
                final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

                return Container(
                  width: cellSize,
                  height: cellSize,
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFuture
                        ? colors.surfaceVariant.withOpacity(0.3)
                        : isCompleted
                            ? _getStreakColor(_getConsecutiveDays(completedSet, date), colors)
                            : colors.surfaceVariant,
                    border: isToday && !isFuture
                        ? Border.all(color: colors.primary, width: 2)
                        : null,
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  String _weekdayShort(int weekday) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[(weekday - 1) % 7];
  }

  Color _getStreakColor(int streak, dynamic colors) {
    if (streak == 0) return colors.surfaceVariant;
    if (streak < 3) return colors.warning;
    if (streak < 7) return colors.primary;
    if (streak < 14) return colors.success;
    if (streak < 30) return colors.tertiary;
    return colors.secondary;
  }

  int _getConsecutiveDays(Set<DateTime> completed, DateTime date) {
    int count = 0;
    var current = date;
    while (completed.contains(DateTime(current.year, current.month, current.day))) {
      count++;
      current = current.subtract(const Duration(days: 1));
    }
    return count;
  }
}
