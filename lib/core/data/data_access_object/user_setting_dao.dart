import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/data/models/user_settings_model.dart';

import '../database/tables.dart';

part 'user_setting_dao.g.dart';

@DriftAccessor(tables: [UserSettings, NotificationPrefs])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {
  UserSettingsDao(super.attachedDatabase);

  Future<UserSettingsModel> getUserSettings() async {
    final userSetting = await (select(userSettings)..where((u) => u.id.equals(1))).getSingleOrNull();
    final notificationPref = await (select(notificationPrefs)..where((n) => n.id.equals(1))).getSingleOrNull();

    return UserSettingsModel(
      id: userSetting?.id ?? 1,
      notificationsEnabled: userSetting?.notificationsEnabled ?? true,
      theme: userSetting?.theme,
      defaultReminderMinutes: notificationPref?.defaultReminderMinutes ?? 30,
      snoozeEnabled: notificationPref?.snoozeEnabled ?? true,
      snoozePresets: notificationPref?.snoozePresets != null
          ? _decodeIntList(notificationPref!.snoozePresets)
          : [10, 60, 1440],
      quietHoursEnabled: notificationPref?.quietHoursEnabled ?? false,
      quietHoursStart: notificationPref?.quietHoursStart ?? '22:00',
      quietHoursEnd: notificationPref?.quietHoursEnd ?? '08:00',
      workingDays: notificationPref?.workingDays != null
          ? _decodeIntList(notificationPref!.workingDays)
          : [1, 2, 3, 4, 5],
      goalOverrideEnabled: notificationPref?.goalOverrideEnabled ?? true,
    );
  }

  Future<int> insertUserSettings(UserSettingsModel settings) async {
    final userSetting = UserSettingsCompanion(
      notificationsEnabled: Value(settings.notificationsEnabled),
      theme: Value(settings.theme),
    );
    final userId = await into(userSettings).insert(userSetting);

    final notificationPref = NotificationPrefsCompanion(
      id: Value(userId),
      notificationsEnabled: Value(settings.notificationsEnabled),
      defaultReminderMinutes: Value(settings.defaultReminderMinutes),
      snoozeEnabled: Value(settings.snoozeEnabled),
      snoozePresets: Value(settings.snoozePresetsJson),
      quietHoursEnabled: Value(settings.quietHoursEnabled),
      quietHoursStart: Value(settings.quietHoursStart),
      quietHoursEnd: Value(settings.quietHoursEnd),
      workingDays: Value(settings.workingDaysJson),
      goalOverrideEnabled: Value(settings.goalOverrideEnabled),
      createdAt: Value(DateTime.now()),
    );
    await into(notificationPrefs).insert(notificationPref);

    return userId;
  }

  Future<bool> updateUserSettings(UserSettingsModel settings) async {
    final userSetting = UserSettingsCompanion(
      id: Value(settings.id),
      notificationsEnabled: Value(settings.notificationsEnabled),
      theme: Value(settings.theme),
    );
    await update(userSettings).replace(userSetting);

    final notificationPref = NotificationPrefsCompanion(
      id: Value(settings.id),
      notificationsEnabled: Value(settings.notificationsEnabled),
      defaultReminderMinutes: Value(settings.defaultReminderMinutes),
      snoozeEnabled: Value(settings.snoozeEnabled),
      snoozePresets: Value(settings.snoozePresetsJson),
      quietHoursEnabled: Value(settings.quietHoursEnabled),
      quietHoursStart: Value(settings.quietHoursStart),
      quietHoursEnd: Value(settings.quietHoursEnd),
      workingDays: Value(settings.workingDaysJson),
      goalOverrideEnabled: Value(settings.goalOverrideEnabled),
      updatedAt: Value(DateTime.now()),
    );
    await update(notificationPrefs).replace(notificationPref);

    return true;
  }

  Future<int> deleteUserSettings(int id) =>
      (delete(userSettings)..where((u) => u.id.equals(id))).go();

  static List<int> _decodeIntList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonString);
      return (decoded as List).map((e) => e as int).toList();
    } catch (_) {
      return [];
    }
  }
}
