import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

import '../primitives/pl_chip.dart';

class DateChip extends StatelessWidget {
  final DateTime date;
  final DateChipStyle style;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? customColor;

  const DateChip({
    super.key,
    required this.date,
    this.style = DateChipStyle.standard,
    this.isSelected = false,
    this.onTap,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final chipDate = DateTime(date.year, date.month, date.day);
    final isToday = chipDate == today;
    final isPast = chipDate.isBefore(today);
    final isFuture = chipDate.isAfter(today);

    Color bgColor;
    Color fgColor;
    Border? border;

    if (customColor != null) {
      bgColor = customColor!.withOpacity(0.15);
      fgColor = customColor!;
    } else if (isSelected) {
      bgColor = colors.primaryContainer;
      fgColor = colors.primaryDark;
    } else if (isToday) {
      bgColor = colors.primary.withOpacity(0.15);
      fgColor = colors.primary;
    } else {
      switch (style) {
        case DateChipStyle.standard:
          bgColor = colors.surfaceVariant;
          fgColor = colors.onSurfaceVariant;
          break;
        case DateChipStyle.outlined:
          bgColor = Colors.transparent;
          fgColor = colors.onSurfaceVariant;
          border = Border.all(color: colors.outline, width: 1);
          break;
        case DateChipStyle.filled:
          bgColor = colors.primaryContainer;
          fgColor = colors.primaryDark;
          break;
        case DateChipStyle.full:
        case DateChipStyle.calendar:
          bgColor = colors.surfaceVariant;
          fgColor = colors.onSurfaceVariant;
          break;
      }
    }

    final chip = DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: PlBorderRadius.radiusFull,
        border: border,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (style == DateChipStyle.calendar)
              Icon(Icons.calendar_today, size: 14, color: fgColor),
            if (style != DateChipStyle.calendar) ...[
              Text(
                '${date.day}',
                style: PlTypography.titleMedium.copyWith(
                  color: fgColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (style == DateChipStyle.full)
                Text(
                  ' ${_monthShort(date.month)}',
                  style: PlTypography.bodySmall
                      .copyWith(color: fgColor.withOpacity(0.8)),
                ),
            ],
          ],
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: PlBorderRadius.radiusFull,
        child: chip,
      );
    }

    return chip;
  }

  String _monthShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

class DateRangeChip extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final Color? color;
  final VoidCallback? onTap;

  const DateRangeChip({
    super.key,
    required this.start,
    required this.end,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final chipColor = color ?? colors.primary;

    return PlChip(
      label: '${_formatDate(start)} - ${_formatDate(end)}',
      icon: Icons.date_range,
      style: PlChipStyle.filled,
      color: chipColor.withOpacity(0.15),
      labelColor: chipColor,
      onTap: onTap,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

enum DateChipStyle { standard, outlined, filled, full, calendar }
