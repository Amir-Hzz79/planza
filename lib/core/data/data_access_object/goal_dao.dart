import 'dart:ui' show Color;

import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/data/models/goal_model.dart';

import '../database/tables.dart';
import '../models/task_model.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals, GoalTasks, Tasks])
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
        leftOuterJoin(goalTasks, goalTasks.goalId.equalsExp(goals.id)),
        leftOuterJoin(tasks, tasks.id.equalsExp(goalTasks.taskId)),
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

        return GoalModel(
          id: goalEntity.id,
          name: goalEntity.name,
          description: goalEntity.description,
          deadline: goalEntity.deadline,
          completed: goalEntity.completed,
          color: Color(goalEntity.color), // Convert int to Color
          tasks: tasks.map((task) => TaskModel.fromEntity(task)).toList(),
        );
      },
    ).toList();
  }

  Stream<List<Goal>> watchAllGoals() => select(goals).watch();
  Future<List<Goal>> getAllGoalsWhere(
          Expression<bool> Function(Goals goal) filter) =>
      (select(goals)..where(filter)).get();
  Future<Goal> getGoalById(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingle();
  Future<int> insertGoal(Goal goal) => into(goals).insert(goal);
  Future<bool> updateGoal(Goal goal) => update(goals).replace(goal);
  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();
}
