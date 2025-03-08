import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'user_setting_dao.g.dart';

@DriftAccessor(tables: [UserSettings])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {
  UserSettingsDao(super.attachedDatabase);

  Future<List<UserSetting>> getUserSettings() => select(userSettings).get();
  Future<UserSetting> getUserSetting(int id) =>
      (select(userSettings)..where((u) => u.id.equals(id))).getSingle();
  Future<int> insertUserSetting(UserSetting userSetting) =>
      into(userSettings).insert(userSetting);
  Future<bool> updateUserSetting(UserSetting userSetting) =>
      update(userSettings).replace(userSetting);
  Future<int> deleteUserSetting(int id) =>
      (delete(userSettings)..where((u) => u.id.equals(id))).go();
}
