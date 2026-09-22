# Notifications

Local notification system: task reminders with timezone support, rich actions, presets, quiet hours, working days, per-goal overrides.

## What It Does

- Schedule task reminders at configurable lead times
- Rich notification actions: Complete, Snooze 10m, Snooze 1h
- Notification channels with high priority
- Preset reminder times: 10m, 1h, 1d, custom
- Quiet hours: suppress notifications during a time window
- Working days: only remind on selected days
- Per-goal notification override: individual goals can have custom reminder settings
- Global notification on/off toggle
- Test notification button (send a sample notification now)

## Key Files

```
lib/core/services/
└── notification_service.dart         # Service interface/implementation (placeholder — uses flutter_local_notifications)

lib/core/data/
├── models/
│   └── user_settings_model.dart      # Global settings including notification prefs
├── data_access_object/
│   └── user_setting_dao.dart         # CRUD for user settings

lib/features/notifications/
├── presentation/
│   ├── bloc/
│   │   ├── notification_settings_bloc.dart   # Load, toggle, update presets/quiet hours/working days, per-goal override, test
│   │   ├── notification_settings_event.dart
│   │   └── notification_settings_state.dart  # Initial, Loading, Loaded (settings), Error
│   ├── pages/
│   │   └── notification_settings_page.dart   # Settings UI
│   └── widgets/
│       ├── notification_settings_widgets.dart
│       └── index.dart
```

## BLoC: NotificationSettingsBloc

Events: `LoadNotificationSettings`, `ToggleNotificationsEnabled`, `UpdateDefaultReminder`, `ToggleSnoozeEnabled`, `UpdateSnoozePresets`, `ToggleQuietHours`, `UpdateQuietHours`, `ToggleWorkingDays`, `ToggleGoalOverride`, `ResetToDefaults`, `TestNotification`

Wired to UserSettingsDao (persistence) and NotificationService (scheduling). Settings stored in UserSettingsModel via user_setting_dao.

## Notification Service

`NotificationService` is a custom implementation (replacing flutter_local_notifications plugin after it was removed as problematic). It's a placeholder in the current codebase — the real scheduling uses flutter_local_notifications under the hood via the service abstraction.

## Settings Model

UserSettingsModel carries notification-related fields:
- notificationsEnabled (global on/off)
- defaultReminder (preset time)
- snoozeEnabled, snoozePresets
- quietHours (start/end), quietHoursEnabled
- workingDays (day bitmask)
- per-goal overrides via GoalNotificationOverride table

## Integration Points

- GoalNotificationOverride table: per-goal reminder settings
- Task reminders: scheduled when a task has a due date + reminder lead time
- UserStats/Profile: celebrations may trigger notifications (future)
