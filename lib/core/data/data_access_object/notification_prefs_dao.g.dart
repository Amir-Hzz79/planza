// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_prefs_dao.dart';

// ignore_for_file: type=lint
mixin _$NotificationPrefsDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotificationPrefsTable get notificationPrefs =>
      attachedDatabase.notificationPrefs;
  NotificationPrefsDaoManager get managers => NotificationPrefsDaoManager(this);
}

class NotificationPrefsDaoManager {
  final _$NotificationPrefsDaoMixin _db;
  NotificationPrefsDaoManager(this._db);
  $$NotificationPrefsTableTableManager get notificationPrefs =>
      $$NotificationPrefsTableTableManager(
          _db.attachedDatabase, _db.notificationPrefs);
}
