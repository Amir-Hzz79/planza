import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'notification_prefs_dao.g.dart';

@DriftAccessor(tables: [NotificationPrefs])
class NotificationPrefsDao extends DatabaseAccessor<AppDatabase> with _$NotificationPrefsDaoMixin {
  NotificationPrefsDao(super.attachedDatabase);

  Future<NotificationPref?> getNotificationPrefs() async {
    return await (select(notificationPrefs)..where((n) => n.id.equals(1))).getSingleOrNull();
  }

  Future<int> insertNotificationPrefs(NotificationPrefsCompanion prefs) async {
    return await into(notificationPrefs).insert(prefs);
  }

  Future<bool> updateNotificationPrefs(NotificationPrefsCompanion prefs) =>
      update(notificationPrefs).replace(prefs);

  Future<int> deleteNotificationPrefs() => delete(notificationPrefs).go();
}