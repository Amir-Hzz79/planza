import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/design/primitives/pl_app_bar.dart';
import 'package:planza/core/design/primitives/pl_button.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/core/data/models/user_settings_model.dart';
import 'package:planza/features/notifications/presentation/bloc/notification_settings_bloc.dart';
import 'package:planza/features/notifications/presentation/bloc/notification_settings_event.dart';
import 'package:planza/features/notifications/presentation/bloc/notification_settings_state.dart';
import 'package:planza/features/notifications/presentation/widgets/notification_settings_widgets.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationSettingsBloc>().add(LoadNotificationSettings());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlAppBar(
        title: 'Notification Settings',
        actions: [
          TextButton(
            onPressed: _showResetDialog,
            child: Text(
              'Reset',
              style: PlTypography.labelLarge.copyWith(color: colorScheme.error),
            ),
          ),
        ],
      ),
      body: BlocConsumer<NotificationSettingsBloc, NotificationSettingsState>(
        listener: (context, state) {
          if (state is NotificationSettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationSettingsLoading) {
            return _buildLoadingState();
          } else if (state is NotificationSettingsLoaded) {
            return _buildSettingsContent(state.settings);
          } else if (state is NotificationSettingsError) {
            return _buildErrorState(state.message);
          }
          return _buildLoadingState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView(
      padding: const EdgeInsets.all(PlSpacing.md),
      children: [
        _buildSkeletonCard(),
        const SizedBox(height: PlSpacing.md),
        _buildSkeletonCard(),
        const SizedBox(height: PlSpacing.md),
        _buildSkeletonCard(),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: PlSpacing.md),
            Text('Error Loading Settings', style: PlTypography.headlineSmall),
            const SizedBox(height: PlSpacing.sm),
            Text(message, style: PlTypography.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: PlSpacing.lg),
            PlButton(
              label: 'Retry',
              style: PlButtonStyle.filled,
              onPressed: () {
                context.read<NotificationSettingsBloc>().add(LoadNotificationSettings());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsContent(UserSettingsModel settings) {
    return ListView(
      padding: const EdgeInsets.all(PlSpacing.md),
      children: [
        _buildSectionHeader('Notifications'),
        const SizedBox(height: PlSpacing.sm),
        NotificationSwitchTile(
          title: 'Enable Notifications',
          subtitle: 'Receive task reminders and alerts',
          value: settings.notificationsEnabled,
          onChanged: (value) {
            context.read<NotificationSettingsBloc>().add(ToggleNotificationsEnabled(value));
          },
        ),
        const SizedBox(height: PlSpacing.md),

        _buildSectionHeader('Default Reminder'),
        const SizedBox(height: PlSpacing.sm),
        ReminderSelector(
          currentValue: settings.defaultReminderMinutes,
          onChanged: (minutes) {
            context.read<NotificationSettingsBloc>().add(UpdateDefaultReminder(minutes));
          },
        ),
        const SizedBox(height: PlSpacing.md),

        _buildSectionHeader('Snooze Options'),
        const SizedBox(height: PlSpacing.sm),
        NotificationSwitchTile(
          title: 'Enable Snooze',
          subtitle: 'Allow snoozing notifications',
          value: settings.snoozeEnabled,
          onChanged: (value) {
            context.read<NotificationSettingsBloc>().add(ToggleSnoozeEnabled(value));
          },
        ),
        const SizedBox(height: PlSpacing.sm),
        SnoozePresetsEditor(
          presets: settings.snoozePresets,
          onChanged: (presets) {
            context.read<NotificationSettingsBloc>().add(UpdateSnoozePresets(presets));
          },
        ),
        const SizedBox(height: PlSpacing.md),

        _buildSectionHeader('Quiet Hours'),
        const SizedBox(height: PlSpacing.sm),
        NotificationSwitchTile(
          title: 'Enable Quiet Hours',
          subtitle: 'Suppress notifications during specified hours',
          value: settings.quietHoursEnabled,
          onChanged: (value) {
            context.read<NotificationSettingsBloc>().add(ToggleQuietHours(value));
          },
        ),
        const SizedBox(height: PlSpacing.sm),
        QuietHoursEditor(
          start: settings.quietHoursStart,
          end: settings.quietHoursEnd,
          onStartChanged: (value) {
            context.read<NotificationSettingsBloc>().add(UpdateQuietHours(start: value, end: settings.quietHoursEnd));
          },
          onEndChanged: (value) {
            context.read<NotificationSettingsBloc>().add(UpdateQuietHours(start: settings.quietHoursStart, end: value));
          },
        ),
        const SizedBox(height: PlSpacing.md),

        _buildSectionHeader('Working Days'),
        const SizedBox(height: PlSpacing.sm),
        WorkingDaysEditor(
          workingDays: settings.workingDays,
          onChanged: (day, enabled) {
            context.read<NotificationSettingsBloc>().add(ToggleWorkingDays(day: day, enabled: enabled));
          },
        ),
        const SizedBox(height: PlSpacing.md),

        _buildSectionHeader('Per-Goal Overrides'),
        const SizedBox(height: PlSpacing.sm),
        NotificationSwitchTile(
          title: 'Allow Per-Goal Settings',
          subtitle: 'Override global settings for individual goals',
          value: settings.goalOverrideEnabled,
          onChanged: (value) {
            context.read<NotificationSettingsBloc>().add(ToggleGoalOverride(value));
          },
        ),
        const SizedBox(height: PlSpacing.lg),

        _buildSectionHeader('Test'),
        const SizedBox(height: PlSpacing.sm),
        PlCard(
          padding: const EdgeInsets.all(PlSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Test Notification', style: PlTypography.titleMedium),
              const SizedBox(height: PlSpacing.sm),
              Text(
                'Send a test notification to verify your settings work correctly.',
                style: PlTypography.bodyMedium.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: PlSpacing.md),
              SizedBox(
                width: double.infinity,
                child: PlButton(
                  label: 'Send Test Notification',
                  style: PlButtonStyle.outlined,
                  onPressed: () {
                    context.read<NotificationSettingsBloc>().add(TestNotification());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: PlTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Settings', style: PlTypography.headlineSmall),
        content: Text(
          'This will reset all notification settings to their default values. This action cannot be undone.',
          style: PlTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: PlTypography.labelLarge),
          ),
          PlButton(
            label: 'Reset',
            style: PlButtonStyle.destructive,
            onPressed: () {
              Navigator.pop(context);
              context.read<NotificationSettingsBloc>().add(ResetToDefaults());
            },
          ),
        ],
      ),
    );
  }
}