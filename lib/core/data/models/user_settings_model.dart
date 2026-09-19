import 'dart:convert';

import '../database/database.dart' show UserSetting;

class UserSettingsModel {
  final int id;
  final bool notificationsEnabled;
  final String? theme;
  
  // Notification settings
  final int defaultReminderMinutes;
  final bool snoozeEnabled;
  final List<int> snoozePresets;
  final bool quietHoursEnabled;
  final String quietHoursStart;
  final String quietHoursEnd;
  final List<int> workingDays; // 1=Mon, 7=Sun
  final bool goalOverrideEnabled;

  UserSettingsModel({
    required this.id,
    required this.notificationsEnabled,
    this.theme,
    this.defaultReminderMinutes = 30,
    this.snoozeEnabled = true,
    List<int>? snoozePresets,
    this.quietHoursEnabled = false,
    this.quietHoursStart = '22:00',
    this.quietHoursEnd = '08:00',
    List<int>? workingDays,
    this.goalOverrideEnabled = true,
  })  : snoozePresets = snoozePresets ?? [10, 60, 1440],
        workingDays = workingDays ?? [1, 2, 3, 4, 5];

  factory UserSettingsModel.fromEntity(UserSetting userSettingsEntity) {
    return UserSettingsModel(
      id: userSettingsEntity.id,
      notificationsEnabled: userSettingsEntity.notificationsEnabled,
      theme: userSettingsEntity.theme,
    );
  }

  UserSetting toEntity() {
    return UserSetting(
      id: id,
      notificationsEnabled: notificationsEnabled,
      theme: theme,
    );
  }

  UserSettingsModel copyWith({
    int? id,
    bool? notificationsEnabled,
    String? theme,
    int? defaultReminderMinutes,
    bool? snoozeEnabled,
    List<int>? snoozePresets,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
    List<int>? workingDays,
    bool? goalOverrideEnabled,
  }) {
    return UserSettingsModel(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      theme: theme ?? this.theme,
      defaultReminderMinutes: defaultReminderMinutes ?? this.defaultReminderMinutes,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      snoozePresets: snoozePresets ?? this.snoozePresets,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      workingDays: workingDays ?? this.workingDays,
      goalOverrideEnabled: goalOverrideEnabled ?? this.goalOverrideEnabled,
    );
  }

  String get snoozePresetsJson => jsonEncode(snoozePresets);
  String get workingDaysJson => jsonEncode(workingDays);

  static UserSettingsModel get defaultSettings => UserSettingsModel(
    id: 1,
    notificationsEnabled: true,
    theme: 'system',
  );
}