import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../data_access_object/goal_task_dao.dart';
import '../data_access_object/tag_dao.dart';
import '../data_access_object/task_dao.dart';
import '../data_access_object/user_setting_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Tasks, Subtasks, Tags, TaskTags, Goals, GoalTasks, UserSettings],
  daos: [TaskDao, TagDao, GoalTaskDao, UserSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFolderPath = '${dbFolder.path}/database';
      final file = File('$dbFolderPath/planza_db.sqlite');

      // Ensure the directory exists
      if (!(await Directory(dbFolderPath).exists())) {
        await Directory(dbFolderPath).create(recursive: true);
      }

      return NativeDatabase(file);
    });
  }

  @override
  // TODO: implement migration
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(
              goals,
              GeneratedColumn(
                'color',
                'Goals',
                false,
                type: DriftSqlType.int,
              ),
            );
          }
        },
      );
}
