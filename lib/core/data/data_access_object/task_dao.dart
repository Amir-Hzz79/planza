import 'package:drift/drift.dart';
import 'package:planza/core/data/database.dart';

import '../tables/tables.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future<Task> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertTask(Task task) => into(tasks).insert(task);
  Future<bool> updateTask(Task task) => update(tasks).replace(task);
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
