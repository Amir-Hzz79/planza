import '../database/database.dart' show Tag;
import 'task_model.dart';

class TagModel {
  final int id;
  final String name;
  final List<TaskModel> tasks;

  TagModel(
    this.tasks, {
    required this.id,
    required this.name,
  });

  // Convert a Tag entity to a TagModel
  factory TagModel.fromEntity(Tag tagEntity, List<TaskModel> tasks) {
    return TagModel(
      id: tagEntity.id,
      name: tagEntity.name,
      tasks = tasks,
    );
  }

  // Convert a TagModel to a Tag entity
  Tag toEntity() {
    return Tag(
      id: id,
      name: name,
    );
  }
}
