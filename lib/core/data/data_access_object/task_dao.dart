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
                goal: row.readTable(goals),
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
          final Goal goal = row.readTable(goals);
          final t = TaskModel.fromEntity(task, goal: goal);
          tasksData.add(t);
          print('{title:${t.title},goalId:${t.goal?.id}}');
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

  Future<bool> updateTask(Task task) => update(tasks).replace(task);

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
