import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'goal_task_dao.g.dart';

@DriftAccessor(tables: [GoalTasks])
class GoalTaskDao extends DatabaseAccessor<AppDatabase>
    with _$GoalTaskDaoMixin {
  GoalTaskDao(super.attachedDatabase);

  Future<List<GoalTask>> getAllGoalTasks() => select(goalTasks).get();
  Stream<List<GoalTask>> watchAllGoalTasks() => select(goalTasks).watch();
  Future<GoalTask> getGoalTaskById(int goalId, int taskId) => (select(goalTasks)
        ..where((g) => g.goalId.equals(goalId) & g.taskId.equals(taskId)))
      .getSingle();
  Future<int> insertGoalTask(GoalTask goalTask) =>
      into(goalTasks).insert(goalTask);
  Future<bool> updateGoalTask(GoalTask goalTask) =>
      update(goalTasks).replace(goalTask);
  Future<int> deleteGoalTask(int goalId, int taskId) => (delete(goalTasks)
        ..where((g) => g.goalId.equals(goalId) & g.taskId.equals(taskId)))
      .go();
}
