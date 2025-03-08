import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.attachedDatabase);

  Future<List<Goal>> getAllGoals() => select(goals).get();
  Stream<List<Goal>> watchAllGoals() => select(goals).watch();
  Future<Goal> getGoalById(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingle();
  Future<int> insertGoal(Goal goal) => into(goals).insert(goal)
;
  Future<bool> updateGoal(Goal goal) => update(goals).replace(goal)
;
  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();
}