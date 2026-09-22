
import 'package:flutter/material.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/primitives/pl_text_field.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/core/design/primitives/pl_switch.dart';

class NotificationSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PlTypography.titleMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: PlSpacing.xs),
                  Text(subtitle!, style: PlTypography.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ],
            ),
          ),
          PlSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class ReminderSelector extends StatelessWidget {
  final int currentValue;
  final ValueChanged<int> onChanged;

  const ReminderSelector({
    super.key,
    required this.currentValue,
    required this.onChanged,
  });

  static const List<int> reminderOptions = [0, 5, 10, 15, 30, 60, 120, 1440];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: PlSpacing.sm,
      runSpacing: PlSpacing.sm,
      children: [
        ...reminderOptions.map((minutes) => FilterChip(
          label: Text(_formatDuration(minutes)),
          selected: currentValue == minutes,
          onSelected: (selected) {
            if (selected) onChanged(minutes);
          },
          labelStyle: PlTypography.labelMedium,
        )),
        // Custom option
        ActionChip(
          label: Text('Custom', style: PlTypography.labelMedium),
          onPressed: () => _showCustomDialog(context),
        ),
      ],
    );
  }

  String _formatDuration(int minutes) {
    if (minutes == 0) return 'At time';
    if (minutes < 60) return '${minutes}m';
    if (minutes == 60) return '1h';
    if (minutes < 1440) return '${minutes ~/ 60}h';
    return '1d';
  }

  void _showCustomDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom Reminder Time'),
        content: PlTextField(
          controller: controller,
          label: 'Minutes before due',
          hint: 'e.g., 45',
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final minutes = int.tryParse(controller.text);
              if (minutes != null && minutes > 0) {
                // Find the closest option or use as-is
                // For now, just notify
              }
              Navigator.pop(context);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }
}

class SnoozePresetsEditor extends StatefulWidget {
  final List<int> presets;
  final ValueChanged<List<int>> onChanged;

  const SnoozePresetsEditor({
    super.key,
    required this.presets,
    required this.onChanged,
  });

  @override
  State<SnoozePresetsEditor> createState() => _SnoozePresetsEditorState();
}

class _SnoozePresetsEditorState extends State<SnoozePresetsEditor> {
  late List<int> _presets;

  @override
  void initState() {
    super.initState();
    _presets = List<int>.from(widget.presets);
  }

  @override
  Widget build(BuildContext context) {
    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Snooze Presets', style: PlTypography.titleMedium),
          const SizedBox(height: PlSpacing.sm),
          Text(
            'Tap to edit presets. Separate with commas (minutes).',
            style: PlTypography.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: PlSpacing.sm),
          Wrap(
            spacing: PlSpacing.sm,
            runSpacing: PlSpacing.sm,
            children: _presets.map((minutes) => InputChip(
              label: Text(_formatDuration(minutes)),
              onDeleted: () {
                setState(() {
                  _presets.remove(minutes);
                  widget.onChanged(_presets);
                });
              },
            )).toList(),
          ),
          const SizedBox(height: PlSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => _showAddPresetDialog(context),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Preset'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) return '${minutes}m';
    if (minutes == 60) return '1h';
    if (minutes < 1440) return '${minutes ~/ 60}h';
    return '1d';
  }

  void _showAddPresetDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Snooze Preset'),
        content: PlTextField(
          controller: controller,
          label: 'Minutes',
          hint: 'e.g., 45',
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final minutes = int.tryParse(controller.text);
              if (minutes != null && minutes > 0) {
                setState(() {
                  _presets.add(minutes);
                  widget.onChanged(_presets);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class QuietHoursEditor extends StatelessWidget {
  final String start;
  final String end;
  final ValueChanged<String> onStartChanged;
  final ValueChanged<String> onEndChanged;

  const QuietHoursEditor({
    super.key,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start', style: PlTypography.labelLarge),
                const SizedBox(height: PlSpacing.xs),
                InkWell(
                  onTap: () => _pickTime(context, true),
                  child: Container(
                    padding: const EdgeInsets.all(PlSpacing.md),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(start, style: PlTypography.titleMedium),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: PlSpacing.md),
          const Text('to', style: PlTypography.titleMedium),
          const SizedBox(width: PlSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('End', style: PlTypography.labelLarge),
                const SizedBox(height: PlSpacing.xs),
                InkWell(
                  onTap: () => _pickTime(context, false),
                  child: Container(
                    padding: const EdgeInsets.all(PlSpacing.md),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(end, style: PlTypography.titleMedium),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final currentTime = isStart ? start : end;
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );

    if (picked != null) {
      final timeString = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      if (isStart) {
        onStartChanged(timeString);
      } else {
        onEndChanged(timeString);
      }
    }
  }
}

class WorkingDaysEditor extends StatelessWidget {
  final List<int> workingDays;
  final Function(int, bool) onChanged;

  const WorkingDaysEditor({
    super.key,
    required this.workingDays,
    required this.onChanged,
  });

  static const List<DayOption> dayOptions = [
    DayOption('Mon', 1),
    DayOption('Tue', 2),
    DayOption('Wed', 3),
    DayOption('Thu', 4),
    DayOption('Fri', 5),
    DayOption('Sat', 6),
    DayOption('Sun', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Wrap(
        spacing: PlSpacing.sm,
        runSpacing: PlSpacing.sm,
        children: dayOptions.map((day) {
          final isSelected = workingDays.contains(day.value);
          return FilterChip(
            label: Text(day.name),
            selected: isSelected,
            onSelected: (selected) => onChanged(day.value, selected),
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
            checkmarkColor: Theme.of(context).colorScheme.primary,
            labelStyle: PlTypography.labelMedium,
          );
        }).toList(),
      ),
    );
  }
}

class DayOption {
  final String name;
  final int value;

  const DayOption(this.name, this.value);
}