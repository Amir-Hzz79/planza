library notification_settings_event;

import 'package:equatable/equatable.dart';
import 'package:planza/core/data/models/user_settings_model.dart';

abstract class NotificationSettingsEvent extends Equatable {
  const NotificationSettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationSettings extends NotificationSettingsEvent {}

class ToggleNotificationsEnabled extends NotificationSettingsEvent {
  final bool enabled;

  const ToggleNotificationsEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateDefaultReminder extends NotificationSettingsEvent {
  final int minutes;

  const UpdateDefaultReminder(this.minutes);

  @override
  List<Object?> get props => [minutes];
}

class ToggleSnoozeEnabled extends NotificationSettingsEvent {
  final bool enabled;

  const ToggleSnoozeEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateSnoozePresets extends NotificationSettingsEvent {
  final List<int> presets;

  const UpdateSnoozePresets(this.presets);

  @override
  List<Object?> get props => [presets];
}

class ToggleQuietHours extends NotificationSettingsEvent {
  final bool enabled;

  const ToggleQuietHours(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateQuietHours extends NotificationSettingsEvent {
  final String start;
  final String end;

  const UpdateQuietHours({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}

class ToggleWorkingDays extends NotificationSettingsEvent {
  final int day;
  final bool enabled;

  const ToggleWorkingDays({required this.day, required this.enabled});

  @override
  List<Object?> get props => [day, enabled];
}

class ToggleGoalOverride extends NotificationSettingsEvent {
  final bool enabled;

  const ToggleGoalOverride(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ResetToDefaults extends NotificationSettingsEvent {}

class TestNotification extends NotificationSettingsEvent {}
