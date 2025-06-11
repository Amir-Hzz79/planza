import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/data/models/goal_model.dart';

import '../database/tables.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals, Tasks, Tags, TaskTags])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.attachedDatabase);

  Stream<List<GoalModel>> watchAllGoalsWithTasksAndTags() {
    final query = select(goals).join([
      leftOuterJoin(tasks, tasks.goalId.equalsExp(goals.id)),
      leftOuterJoin(taskTags, taskTags.taskId.equalsExp(tasks.id)),
      leftOuterJoin(tags, tags.id.equalsExp(taskTags.tagId)),
    ]);

    return query.watch().map((rows) {
      final goalModels = <GoalModel>[];
      final goalMap = /* <Goal, List<TypedResultRow>> */ {};

      // 1. First, group all the returned rows by their parent goal entity.
      for (final row in rows) {
        final goalEntity = row.readTable(goals);
        goalMap.putIfAbsent(goalEntity, () => []).add(row);
      }

      // 2. Now, iterate over the grouped map to build each immutable GoalModel.
      goalMap.forEach((goalEntity, rowsForGoal) {
        final taskMap = <Task, List<Tag>>{};

        for (final rowData in rowsForGoal) {
          final taskEntity = rowData.readTableOrNull(tasks);
          if (taskEntity != null) {
            // For each task, group its associated tags.
            final tagEntity = rowData.readTableOrNull(tags);
            final tagsForTask = taskMap.putIfAbsent(taskEntity, () => []);
            if (tagEntity != null &&
                !tagsForTask.any((t) => t.id == tagEntity.id)) {
              tagsForTask.add(tagEntity);
            }
          }
        }

        // 3. Build the immutable list of TaskModels for this goal.
        final taskModels = taskMap.entries.map((entry) {
          final taskEntity = entry.key;
          final tagEntities = entry.value;
          final tagModels =
              tagEntities.map((t) => TagModel.fromEntity(t)).toList();
          return TaskModel.fromEntity(taskEntity, tags: tagModels);
        }).toList();

        // 4. Finally, build the immutable GoalModel with its new list of tasks.
        goalModels.add(GoalModel.fromEntity(goalEntity, tasks: taskModels));
      });

      return goalModels;
    });
  }

  Future<Goal> getGoalById(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingle();

  Future<void> insertGoalWithTasks(GoalModel goal) async {
    return await db.transaction(() async {
      // 1. Insert the goal and get its new, auto-generated ID.
      final newGoalId =
          await db.into(db.goals).insert(goal.toInsertCompanion());

      // 2. If there are tasks, prepare them for insertion using the new goal ID.
      if (goal.tasks.isNotEmpty) {
        final taskCompanions = goal.tasks.map((task) {
          return task.toCompanion().copyWith(
                goalId: Value(newGoalId),
              );
        }).toList();

        // 3. Insert all the new tasks in a batch for efficiency.
        await db.batch((b) {
          b.insertAll(db.tasks, taskCompanions);
        });
      }
    });
  }

  Future<bool> updateGoal(GoalModel goal) =>
      update(goals).replace(goal.toEntity());

  Future<void> updateGoalAndSyncTasks({
    required GoalModel updatedGoal,
  }) async {
    return await db.transaction(() async {
      // 1. Update the Goal itself.
      await db.update(db.goals).replace(updatedGoal.toEntity());

      // 2. Get the list of task IDs that currently exist in the database for this goal.
      final existingDbTasks = await (db.select(db.tasks)
            ..where((t) => t.goalId.equals(updatedGoal.id!)))
          .get();
      final existingDbTaskIds = existingDbTasks.map((t) => t.id).toSet();

      // 3. Get the list of task IDs from the final list submitted from the UI.
      final finalTaskIds =
          updatedGoal.tasks.map((t) => t.id).where((id) => id != null).toSet();

      // 4. Determine which tasks to DELETE.
      final tasksToDeleteIds = existingDbTaskIds.difference(finalTaskIds);
      if (tasksToDeleteIds.isNotEmpty) {
        await (db.delete(db.tasks)..where((t) => t.id.isIn(tasksToDeleteIds)))
            .go();
        await (db.delete(db.taskTags)
              ..where((tt) => tt.taskId.isIn(tasksToDeleteIds)))
            .go();
      }

      // 5. ADD or UPDATE the tasks from the final list.
      for (final task in updatedGoal.tasks) {
        final taskCompanion = task.toCompanion().copyWith(
              goalId: Value(updatedGoal.id!),
            );

        await db.into(db.tasks).insertOnConflictUpdate(taskCompanion);
      }
    });
  }

  Future<void> deleteGoalAndItsTasks(int goalId) async {
    return await db.transaction(() async {
      // 1. Delete all associated tasks.
      await (db.delete(db.tasks)..where((task) => task.goalId.equals(goalId)))
          .go();

      // 2. Now that no tasks point to this goal, we can safely delete it.
      await (db.delete(db.goals)..where((g) => g.id.equals(goalId))).go();
    });
  }

  Future<void> deleteGoal(int goalId) async {
    return await db.transaction(() async {
      // 1. Update all associated tasks to set their goalId to null.
      await (db.update(db.tasks)..where((t) => t.goalId.equals(goalId)))
          .write(const TasksCompanion(
        goalId: Value(null),
      ));

      // 2. Now that no tasks point to this goal, we can safely delete it.
      await (db.delete(db.goals)..where((g) => g.id.equals(goalId))).go();
    });
  }
}
