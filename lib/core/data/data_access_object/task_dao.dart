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

  Future<int> insertTask(TaskModel task) async {
    return await transaction<int>(() async {
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

      return newTaskId;
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

  Future<void> updateTaskAndSyncTags(TaskModel task) async {
    return await db.transaction(() async {
      // 1. Update the main task row itself with all its new data
      await db.update(db.tasks).replace(task.toCompanion());

      // 2. Sync the tags using the "delete all, then insert all" pattern.
      await (db.delete(db.taskTags)..where((t) => t.taskId.equals(task.id!)))
          .go();

      if (task.tags.isNotEmpty) {
        final newTagLinks = task.tags.map(
          (tag) => TaskTagsCompanion.insert(
            taskId: Value(task.id!),
            tagId: Value(tag.id),
          ),
        );
        await db.batch((b) => b.insertAll(db.taskTags, newTagLinks));
      }
    });
  }

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
