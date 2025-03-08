import '../database/database.dart' show Subtask;

class SubtaskModel {
  final int id;
  final int? taskId;
  final String title;
  final bool completed;

  SubtaskModel({
    required this.id,
    this.taskId,
    required this.title,
    required this.completed,
  });

  // Convert a Subtask entity to a SubtaskModel
  factory SubtaskModel.fromEntity(Subtask subtaskEntity) {
    return SubtaskModel(
      id: subtaskEntity.id,
      taskId: subtaskEntity.taskId,
      title: subtaskEntity.title,
      completed: subtaskEntity.completed,
    );
  }

  // Convert a SubtaskModel to a Subtask entity
  Subtask toEntity() {
    return Subtask(
      id: id,
      taskId: taskId,
      title: title,
      completed: completed,
    );
  }
}