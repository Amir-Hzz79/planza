import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks, Tags, TaskTags])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  Stream<List<TaskModel>> watchAllTasks() {
    final query = select(tasks).join([
      leftOuterJoin(goals, tasks.goalId.equalsExp(goals.id)),
      leftOuterJoin(taskTags, taskTags.taskId.equalsExp(tasks.id)),
      leftOuterJoin(tags, tags.id.equalsExp(taskTags.tagId)),
    ]);

    return query.watch().map((rows) {
      final Map<int, TaskModel> taskMap = {};

      for (final row in rows) {
        final taskEntity = row.readTable(tasks);
        final goalEntity = row.readTableOrNull(goals);
        final tagEntity = row.readTableOrNull(tags);

        taskMap.putIfAbsent(
          taskEntity.id,
          () => TaskModel.fromEntity(taskEntity, goal: goalEntity),
        );

        if (tagEntity != null) {
          taskMap[taskEntity.id]?.tags.add(TagModel.fromEntity(tagEntity));
        }
      }

      return taskMap.values.toList();
    });
  }

  Future<Task> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();

  Future<void> insertTask(TaskModel task) async {
    return await transaction(() async {
      final newTaskId = await into(tasks).insert(task.toCompanion());

      if (task.tags.isNotEmpty) {
        final tagCompanions = task.tags.map(
          (tag) => TaskTagsCompanion.insert(
            taskId: Value(newTaskId),
            tagId: Value(tag.id),
          ),
        );

        await batch((b) {
          b.insertAll(taskTags, tagCompanions);
        });
      }
    });
  }

  Future<void> insertAllTasks(List<TaskModel> newTasks) async => await batch(
        (batch) {
          batch.insertAll(
            tasks,
            newTasks.map((task) {
              var comp = task.toCompanion();
              return comp;
            }).toList(),
          );
        },
      );

  Future<bool> updateTask(TaskModel task) =>
      update(tasks).replace(task.toEntity());

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
