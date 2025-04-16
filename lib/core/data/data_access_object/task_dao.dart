import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/task_model.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  Future<List<TaskModel>> getAllTasks() => select(tasks)
      .join(
        [
          leftOuterJoin(goals, tasks.goalId.equalsExp(goals.id)),
        ],
      )
      .get()
      .then(
        (value) => value
            .map(
              (row) => TaskModel.fromEntity(
                row.readTable(tasks),
                goal: row.readTableOrNull(goals),
              ),
            )
            .toList(),
      );

  Stream<List<TaskModel>> watchAllTasks() {
    final query = select(tasks).join(
      [
        leftOuterJoin(goals, tasks.goalId.equalsExp(goals.id)),
      ],
    );

    return query.watch().map(
      (rows) {
        final List<TaskModel> tasksData = [];

        for (var row in rows) {
          final Task task = row.readTable(tasks);
          final Goal? goal = row.readTableOrNull(goals);

          tasksData.add(TaskModel.fromEntity(task, goal: goal));
        }

        return tasksData;
      },
    );
  }

  Future<List<Task>> getAllTasksWhere(
          Expression<bool> Function(Tasks task) filter) =>
      (select(tasks)..where(filter)).get();

  Future<Task> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();

  Future<int> insertTask(TaskModel task) async =>
      await into(tasks).insert(task.toInsertCompanion());

  Future<void> insertAllTasks(List<TaskModel> newTasks) async => await batch(
        (batch) {
          batch.insertAll(
            tasks,
            newTasks.map((task) => task.toInsertCompanion()).toList(),
          );
        },
      );

  Future<bool> updateTask(TaskModel task) =>
      update(tasks).replace(task.toEntity());

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
