

import '../database/database.dart' show UserSetting;

class UserSettingsModel {
  final int id;
  final bool notificationsEnabled;
  final String? theme;

  UserSettingsModel({
    required this.id,
    required this.notificationsEnabled,
    this.theme,
  });

  // Convert a UserSettings entity to a UserSettingsModel
  factory UserSettingsModel.fromEntity(UserSetting userSettingsEntity) {
    return UserSettingsModel(
      id: userSettingsEntity.id,
      notificationsEnabled: userSettingsEntity.notificationsEnabled,
      theme: userSettingsEntity.theme,
    );
  }

  // Convert a UserSettingsModel to a UserSettings entity
  UserSetting toEntity() {
    return UserSetting(
      id: id,
      notificationsEnabled: notificationsEnabled,
      theme: theme,
    );
  }
}
