import '../database/database.dart' show Task;

class TaskModel {
  final int id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final int? priority;
  final int? parentTaskId;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    this.priority,
    this.parentTaskId,
  });

  // Convert a Task entity to a TaskModel
  factory TaskModel.fromEntity(Task taskEntity) {
    return TaskModel(
      id: taskEntity.id,
      title: taskEntity.title,
      description: taskEntity.description,
      isCompleted: taskEntity.isCompleted,
      dueDate: taskEntity.dueDate,
      priority: taskEntity.priority,
      parentTaskId: taskEntity.parentTaskId,
    );
  }

  // Convert a TaskModel to a Task entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      priority: priority,
      parentTaskId: parentTaskId,
    );
  }
}