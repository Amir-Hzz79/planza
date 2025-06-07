import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks, Tags, TaskTags])
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
    // 1. Add joins for the many-to-many relationship with tags.
    // We use leftOuterJoin to ensure tasks without any tags are still included.
    final query = select(tasks).join([
      leftOuterJoin(goals, tasks.goalId.equalsExp(goals.id)),
      leftOuterJoin(taskTags, taskTags.taskId.equalsExp(tasks.id)),
      leftOuterJoin(tags, tags.id.equalsExp(taskTags.tagId)),
    ]);

    return query.watch().map((rows) {
      // 2. Use a Map to group tags by task. This prevents task duplication.
      final Map<int, TaskModel> taskMap = {};

      for (final row in rows) {
        final taskEntity = row.readTable(tasks);
        final goalEntity = row.readTableOrNull(goals);
        final tagEntity = row.readTableOrNull(tags);

        // 3. Check if we've already created a TaskModel for this task ID.
        // If not, create it and add it to the map.
        taskMap.putIfAbsent(
          taskEntity.id,
          () => TaskModel.fromEntity(taskEntity, goal: goalEntity),
        );

        // 4. If a tag exists in this row, add it to the corresponding task's tag list.
        if (tagEntity != null) {
          taskMap[taskEntity.id]?.tags.add(TagModel.fromEntity(tagEntity));
        }
      }

      // 5. Return the values of the map as a list.
      return taskMap.values.toList();
    });
  }

  Future<List<Task>> getAllTasksWhere(
          Expression<bool> Function(Tasks task) filter) =>
      (select(tasks)..where(filter)).get();

  Future<Task> getTaskById(int id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();

  Future<void> insertTask(TaskModel task) async {
    return await transaction(() async {
      // 1. Insert the task's companion and AWAIT the new auto-incremented ID.
      //    Unlike `batch.insert`, a normal insert returns the new ID.
      final newTaskId = await into(tasks).insert(task.toInsertCompanion());

      // 2. Check if there are any tags to insert.
      if (task.tags.isNotEmpty) {
        // 3. Create a list of TaskTagsCompanion objects using the NEW ID.
        final tagCompanions = task.tags.map(
          (tag) => TaskTagsCompanion.insert(
            taskId: Value(
                newTaskId), // Use the ID we just got back from the database!
            tagId: Value(tag.id),
          ),
        );

        // 4. (Optional but recommended) Use a batch for the tag insertions for efficiency.
        //    This is a powerful pattern: a transaction containing a batch.
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
            newTasks.map((task) => task.toInsertCompanion()).toList(),
          );
        },
      );

  Future<bool> updateTask(TaskModel task) =>
      update(tasks).replace(task.toEntity());

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
