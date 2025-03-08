import '../database/database.dart' show TaskTag;

class TaskTagModel {
  final int? taskId;
  final int? tagId;

  TaskTagModel({
    this.taskId,
    this.tagId,
  });

  // Convert a TaskTag entity to a TaskTagModel
  factory TaskTagModel.fromEntity(TaskTag taskTagEntity) {
    return TaskTagModel(
      taskId: taskTagEntity.taskId,
      tagId: taskTagEntity.tagId,
    );
  }

  // Convert a TaskTagModel to a TaskTag entity
  TaskTag toEntity() {
    return TaskTag(
      taskId: taskId,
      tagId: tagId,
    );
  }
}