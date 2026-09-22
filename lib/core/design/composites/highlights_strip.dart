import 'package:flutter/material.dart';

import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/primitives/glassy_container.dart';

/// A horizontally scrollable highlights strip — the Telegram Stories analogue
/// for Planza's home dashboard.
///
/// Shows pinned goals, today's focus, streak/level glance, and recent hobby
/// sessions as compact glassy cards. Placed at the top of the Home page
/// before the scrollable content.
///
/// Usage:
/// ```dart
/// HighlightsStrip(
///   pinnedGoals: pinnedGoals,
///   todayFocus: todayFocus,
///   streakData: streakData,
///   recentHobbySession: recentHobbySession,
/// )
/// ```
class HighlightsStrip extends StatelessWidget {
  final List<GoalHighlight> pinnedGoals;
  final TodayFocus? todayFocus;
  final StreakGlance? streakData;
  final RecentHobbySession? recentHobbySession;

  const HighlightsStrip({
    super.key,
    required this.pinnedGoals,
    this.todayFocus,
    this.streakData,
    this.recentHobbySession,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final items = <Widget>[];

    // Pinned goals (Telegram pinned chats pattern)
    if (pinnedGoals.isNotEmpty) {
      items.addAll(pinnedGoals.map((goal) => _PinnedGoalCard(goal: goal)));
    }

    // Divider between sections
    if (pinnedGoals.isNotEmpty &&
        (todayFocus != null ||
            streakData != null ||
            recentHobbySession != null)) {
      items.add(const SizedBox(width: PlSpacing.sm));
    }

    // Today's focus
    if (todayFocus != null) {
      items.add(_TodayFocusCard(todayFocus: todayFocus!));
    }

    // Streak/level glance
    if (streakData != null) {
      if (todayFocus != null || pinnedGoals.isNotEmpty) {
        items.add(const SizedBox(width: PlSpacing.sm));
      }
      items.add(_StreakGlanceCard(streakData: streakData!));
    }

    // Recent hobby session
    if (recentHobbySession != null) {
      if (pinnedGoals.isNotEmpty || todayFocus != null || streakData != null) {
        items.add(const SizedBox(width: PlSpacing.sm));
      }
      items.add(_RecentSessionCard(session: recentHobbySession!));
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PlSpacing.md, vertical: PlSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items,
        ),
      ),
    );
  }
}

class GoalHighlight {
  final String name;
  final int progress;
  final int total;
  final String? dueDate;
  final Color color;
  final IconData icon;

  const GoalHighlight({
    required this.name,
    required this.progress,
    required this.total,
    this.dueDate,
    required this.color,
    required this.icon,
  });
}

class TodayFocus {
  final int tasksDue;
  final int tasksOverdue;
  final int sessionsToday;
  final String? subtitle;

  const TodayFocus({
    required this.tasksDue,
    required this.tasksOverdue,
    required this.sessionsToday,
    this.subtitle,
  });
}

class StreakGlance {
  final int streak;
  final int level;
  final int xp;
  final int xpNext;

  const StreakGlance({
    required this.streak,
    required this.level,
    required this.xp,
    required this.xpNext,
  });
}

class RecentHobbySession {
  final String hobbyName;
  final String duration;
  final DateTime date;
  final Color color;

  const RecentHobbySession({
    required this.hobbyName,
    required this.duration,
    required this.date,
    required this.color,
  });
}

// ── Pinned Goal Card ──────────────────────────────────────────────

class _PinnedGoalCard extends StatelessWidget {
  final GoalHighlight goal;

  const _PinnedGoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Padding(
      padding: const EdgeInsets.only(right: PlSpacing.sm),
      child: SizedBox(
        width: 140,
        child: GlassyCard(
          blur: 14,
          opacity: 0.55,
          border: Border.all(
            color: goal.color.withOpacity(0.3),
            width: 1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + color accent
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: goal.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      goal.icon,
                      size: 14,
                      color: goal.color,
                    ),
                  ),
                  SizedBox(width: PlSpacing.xs),
                  Expanded(
                    child: Text(
                      goal.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlSpacing.xs),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: goal.total > 0 ? goal.progress / goal.total : 0,
                  backgroundColor:
                      colors.surfaceContainerHighest.withOpacity(0.4),
                  valueColor: AlwaysStoppedAnimation(goal.color),
                  minHeight: 3,
                ),
              ),
              const SizedBox(height: PlSpacing.xs),
              // Due date
              if (goal.dueDate != null)
                Text(
                  goal.dueDate!,
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Today's Focus Card ───────────────────────────────────────────

class _TodayFocusCard extends StatelessWidget {
  final TodayFocus todayFocus;

  const _TodayFocusCard({required this.todayFocus});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Padding(
      padding: const EdgeInsets.only(right: PlSpacing.sm),
      child: SizedBox(
        width: 160,
        child: GlassyCard(
          blur: 12,
          opacity: 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.today,
                    size: 16,
                    color: todayFocus.tasksOverdue > 0
                        ? colors.error
                        : colors.primary,
                  ),
                  const SizedBox(width: PlSpacing.xs),
                  Expanded(
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlSpacing.xs),
              Text(
                '${todayFocus.tasksDue} tasks',
                style: TextStyle(
                  fontSize: 11,
                  color: colors.onSurfaceVariant,
                ),
              ),
              if (todayFocus.tasksOverdue > 0) ...[
                const SizedBox(height: 2),
                Text(
                  '${todayFocus.tasksOverdue} overdue',
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (todayFocus.sessionsToday > 0) ...[
                const SizedBox(height: PlSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      Icons.track_changes,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${todayFocus.sessionsToday} sessions',
                      style: TextStyle(
                        fontSize: 10,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
              if (todayFocus.subtitle != null) ...[
                const SizedBox(height: PlSpacing.xs),
                Text(
                  todayFocus.subtitle!,
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Streak Glance Card ───────────────────────────────────────────

class _StreakGlanceCard extends StatelessWidget {
  final StreakGlance streakData;

  const _StreakGlanceCard({required this.streakData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Padding(
      padding: const EdgeInsets.only(right: PlSpacing.sm),
      child: SizedBox(
        width: 130,
        child: GlassyCard(
          blur: 12,
          opacity: 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: PlSpacing.xs),
                  Expanded(
                    child: Text(
                      'Streak',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${streakData.streak} days',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: streakData.streak > 0
                      ? Colors.amber
                      : colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              // Level + XP
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      'Level ${streakData.level}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: streakData.xpNext > 0
                      ? (streakData.xp % streakData.xpNext) / streakData.xpNext
                      : 0,
                  backgroundColor:
                      colors.surfaceContainerHighest.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation(Colors.amber),
                  minHeight: 3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${streakData.xp} / ${streakData.xpNext} XP',
                style: TextStyle(
                  fontSize: 9,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Recent Hobby Session Card ────────────────────────────────────

class _RecentSessionCard extends StatelessWidget {
  final RecentHobbySession session;

  const _RecentSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Padding(
      padding: const EdgeInsets.only(right: PlSpacing.sm),
      child: SizedBox(
        width: 150,
        child: GlassyCard(
          blur: 12,
          opacity: 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Color accent bar
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: session.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: PlSpacing.xs),
              // Hobby name + duration
              Row(
                children: [
                  Text(
                    session.hobbyName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                session.duration,
                style: TextStyle(
                  fontSize: 11,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              // Date
              Text(
                _formatDate(session.date),
                style: TextStyle(
                  fontSize: 9,
                  color: colors.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inHours < 24) {
      if (diff.inHours == 0) return 'Today';
      if (diff.inHours < 2) return 'Earlier today';
      return '${diff.inHours}h ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    return '${date.day}/${date.month}';
  }
}
