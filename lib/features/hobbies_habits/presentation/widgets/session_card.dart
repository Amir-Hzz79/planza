import 'package:flutter/material.dart';
import 'package:planza/core/data/models/hobby_session_model.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class SessionCard extends StatelessWidget {
  final HobbySessionModel session;
  final VoidCallback? onTap;

  const SessionCard({
    super.key,
    required this.session,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PlCard(
      onTap: onTap,
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: PlSpacing.borderRadiusMd,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      session.startTime.day.toString(),
                      style: PlTypography.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      _monthShort(session.startTime.month),
                      style: PlTypography.labelSmall.copyWith(
                        color: colorScheme.onPrimaryContainer
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: PlSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(session.startTime),
                      style: PlTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (session.endTime != null) ...[
                      const SizedBox(height: PlSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: PlSpacing.xs),
                          Text(
                            _formatDuration(session),
                            style: PlTypography.bodySmall.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (session.mood != null) _buildMoodIndicator(context, session.mood!),
            ],
          ),
          if (session.notes != null && session.notes!.isNotEmpty) ...[
            const SizedBox(height: PlSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(PlSpacing.sm),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: PlSpacing.borderRadiusSm,
              ),
              child: Text(
                session.notes!,
                style: PlTypography.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String _monthShort(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatDuration(HobbySessionModel session) {
    if (session.durationMinutes == null) return '—';
    final mins = session.durationMinutes!;
    if (mins < 60) return '$mins min';
    final hours = mins ~/ 60;
    final remaining = mins % 60;
    if (remaining == 0) return '$hours h';
    return '${hours}h ${remaining}m';
  }

  Widget _buildMoodIndicator(BuildContext context, int mood) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final moodColors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.lightGreen,
      Colors.green,
    ];

    final moodLabels = ['Terrible', 'Bad', 'Okay', 'Good', 'Great'];
    const moodEmojis = ['😭', '😞', '😐', '😊', '😍'];

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
      decoration: BoxDecoration(
        color: moodColors[mood - 1].withValues(alpha: 0.15),
        borderRadius: PlSpacing.borderRadiusFull,
        border: Border.all(color: moodColors[mood - 1].withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            moodEmojis[mood - 1],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: PlSpacing.xs),
          Text(
            moodLabels[mood - 1],
            style: PlTypography.labelSmall.copyWith(
              color: moodColors[mood - 1],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
