import '../data_access_object/goal_dao.dart';
import '../models/goal_model.dart';

class GoalRepository {
  final GoalDao _goalDao;

  GoalRepository(this._goalDao);

  Future<List<GoalModel>> getAllGoals() async {
    return _goalDao.getAllGoals();
  }

  Future<GoalModel?> getGoalById(int id) async {
    final goal = await _goalDao.getGoalById(id);
    return GoalModel.fromEntity(goal);
  }

  Future<int> addGoal(GoalModel goal) async {
    return await _goalDao.insertGoal(goal.toEntity());
  }

  Future<bool> updateGoal(GoalModel goal) async {
    return await _goalDao.updateGoal(goal.toEntity());
  }

  Future<int> deleteGoal(int id) async {
    return await _goalDao.deleteGoal(id);
  }
}
