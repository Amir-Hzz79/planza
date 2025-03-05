import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'data_access_object/goal_task_dao.dart';
import 'data_access_object/tag_dao.dart';
import 'data_access_object/task_dao.dart';
import 'data_access_object/user_setting_dao.dart';
import 'tables/tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Tasks, Subtasks, Tags, TaskTags, Goals, GoalTasks, UserSettings],
  daos: [TaskDao, TagDao, GoalTaskDao, UserSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File('${dbFolder.path}/my_database.sqlite');
      return NativeDatabase(file);
    });
  }
}
