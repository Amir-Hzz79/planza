import '../data_access_object/user_setting_dao.dart';
import '../models/user_settings_model.dart';

class UserSettingsRepository {
  final UserSettingsDao _userSettingsDao;

  UserSettingsRepository(this._userSettingsDao);

  Future<List<UserSettingsModel>> getUserSettings() async {
    final settings = await _userSettingsDao.getUserSettings();
    return settings
        .map(
          (setting) => UserSettingsModel.fromEntity(setting),
        )
        .toList();
  }

  Future<int> addUserSettings(UserSettingsModel settings) async {
    return await _userSettingsDao.insertUserSetting(settings.toEntity());
  }

  Future<bool> updateUserSettings(UserSettingsModel settings) async {
    return await _userSettingsDao.updateUserSetting(settings.toEntity());
  }

  Future<int> deleteUserSettings(int id) async {
    return await _userSettingsDao.deleteUserSetting(id);
  }
}
