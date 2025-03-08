import '../database/database.dart' show Goal;

class GoalModel {
  final int id;
  final String name;
  final String? description;
  final DateTime? deadline;
  final bool completed;

  GoalModel({
    required this.id,
    required this.name,
    this.description,
    this.deadline,
    required this.completed,
  });

  // Convert a Goal entity to a GoalModel
  factory GoalModel.fromEntity(Goal goalEntity) {
    return GoalModel(
      id: goalEntity.id,
      name: goalEntity.name,
      description: goalEntity.description,
      deadline: goalEntity.deadline,
      completed: goalEntity.completed,
    );
  }

  // Convert a GoalModel to a Goal entity
  Goal toEntity() {
    return Goal(
      id: id,
      name: name,
      description: description,
      deadline: deadline,
      completed: completed,
    );
  }
}