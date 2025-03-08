import '../data_access_object/goal_task_dao.dart';
import '../models/goal_task_model.dart';

class GoalTaskRepository {
  final GoalTaskDao _goalTaskDao;

  GoalTaskRepository(this._goalTaskDao);

  Future<List<GoalTaskModel>> getAllGoalTasks() async {
    final goalTasks = await _goalTaskDao.getAllGoalTasks();
    return goalTasks.map((goalTask) => GoalTaskModel.fromEntity(goalTask)).toList();
  }

  Future<GoalTaskModel?> getGoalTaskById(int goalId, int taskId) async {
    final goalTask = await _goalTaskDao.getGoalTaskById(goalId, taskId);
    return GoalTaskModel.fromEntity(goalTask);
  }

  Future<int> addGoalTask(GoalTaskModel goalTask) async {
    return await _goalTaskDao.insertGoalTask(goalTask.toEntity());
  }

  Future<bool> updateGoalTask(GoalTaskModel goalTask) async {
    return await _goalTaskDao.updateGoalTask(goalTask.toEntity());
  }

  Future<int> deleteGoalTask(int goalId, int taskId) async {
    return await _goalTaskDao.deleteGoalTask(goalId, taskId);
  }
}