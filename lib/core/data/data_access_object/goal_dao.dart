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

  Future<List<GoalModel>> getAllGoals() => select(goals).get().then(
        (value) => value
            .map(
              (e) => GoalModel.fromEntity(e),
            )
            .toList(),
      );

  Future<List<GoalModel>> getAllGoalsWithTasks() async {
    final query = select(goals).join(
      [
        leftOuterJoin(tasks, tasks.goalId.equalsExp(goals.id)),
      ],
    );

    final rows = await query.get();

    // Group rows by goal and collect associated tasks.
    final goalsMap = <Goal, List<Task>>{};

    for (final row in rows) {
      final Goal goal = row.readTable(goals);
      final Task? task = row.readTableOrNull(tasks);

      if (!goalsMap.containsKey(goal)) {
        goalsMap[goal] = [];
      }
      if (task != null) {
        goalsMap[goal]?.add(task);
      }
    }

    // Convert to a list of GoalModel.
    return goalsMap.entries.map(
      (entry) {
        final Goal goalEntity = entry.key;
        final List<Task> tasks = entry.value;

        return GoalModel.fromEntity(goalEntity, tasks: tasks);
      },
    ).toList();
  }

  Stream<List<GoalModel>> watchAllGoalsWithTasks() {
    // Renamed for clarity
    final query = select(goals).join([
      leftOuterJoin(tasks, tasks.goalId.equalsExp(goals.id)),
      leftOuterJoin(taskTags, taskTags.taskId.equalsExp(tasks.id)),
      leftOuterJoin(tags, tags.id.equalsExp(taskTags.tagId)),
    ]);

    return query.watch().map((rows) {
      final Map<int, GoalModel> goalMap = {};
      final Map<int, TaskModel> taskMap = {};

      for (final row in rows) {
        final goalEntity = row.readTable(goals);
        final taskEntity = row.readTableOrNull(tasks);
        final tagEntity = row.readTableOrNull(tags);

        // Get or create the GoalModel. This part is correct.
        final goalModel = goalMap.putIfAbsent(
          goalEntity.id,
          () => GoalModel.fromEntity(goalEntity, tasks: []),
        );

        if (taskEntity != null) {
          // Get or create the TaskModel
          final taskModel = taskMap.putIfAbsent(taskEntity.id, () {
            // When a task is first seen, create its model
            final newTask = TaskModel.fromEntity(taskEntity, tags: []);
            // and add it to its parent goal's list.
            goalModel.tasks.add(newTask);
            return newTask;
          });

          // --- FIX IS HERE ---
          // Check if a tag exists in this row AND that we haven't already added this tag to this task.
          if (tagEntity != null &&
              !taskModel.tags.any((t) => t.id == tagEntity.id)) {
            // Assuming you have a `fromSimpleEntity` factory on TagModel
            // or that fromEntity can be called with just one argument.
            taskModel.tags.add(TagModel.fromEntity(tagEntity));
          }
        }
      }
      return goalMap.values.toList();
    });
  }

  Stream<List<Goal>> watchAllGoals() => select(goals).watch();
  Future<List<Goal>> getAllGoalsWhere(
          Expression<bool> Function(Goals goal) filter) =>
      (select(goals)..where(filter)).get();
  Future<Goal> getGoalById(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingle();
  Future<int> insertGoal(GoalModel goal) =>
      into(goals).insert(goal.toInsertCompanion());
  Future<bool> updateGoal(Goal goal) => update(goals).replace(goal);
  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();
}
