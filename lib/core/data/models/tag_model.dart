import '../database/database.dart' show Tag;
import 'task_model.dart';

class TagModel {
  int id;
  final String name;
  List<TaskModel> tasks;

  TagModel({
    required this.id,
    required this.name,
    required this.tasks,
  });

  // Convert a Tag entity to a TagModel
  factory TagModel.fromEntity(Tag tagEntity, List<TaskModel> tasks) {
    return TagModel(
      id: tagEntity.id,
      name: tagEntity.name,
      tasks : tasks,
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
