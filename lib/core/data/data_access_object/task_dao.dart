import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/task_model.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  Future<List<TaskModel>> getAllTasks() => select(tasks).get().then(
        (value) => value
            .map(
              (e) => TaskModel.fromEntity(e),
            )
            .toList(),
      );
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future<List<Task>> getAllTasksWhere(
          Expression<bool> Function(Tasks task) filter) =>
      (select(tasks)..where(filter)).get();
  Future<Task> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertTask(TaskModel task) => into(tasks).insert(task.toEntity());
  Future<bool> updateTask(Task task) => update(tasks).replace(task);
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
