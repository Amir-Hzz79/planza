import '../database/database.dart' show GoalTask;

class GoalTaskModel {
  final int? goalId;
  final int? taskId;

  GoalTaskModel({
    this.goalId,
    this.taskId,
  });

  // Convert a GoalTask entity to a GoalTaskModel
  factory GoalTaskModel.fromEntity(GoalTask goalTaskEntity) {
    return GoalTaskModel(
      goalId: goalTaskEntity.goalId,
      taskId: goalTaskEntity.taskId,
    );
  }

  // Convert a GoalTaskModel to a GoalTask entity
  GoalTask toEntity() {
    return GoalTask(
      goalId: goalId,
      taskId: taskId,
    );
  }
}