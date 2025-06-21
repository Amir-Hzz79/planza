import 'package:equatable/equatable.dart';

import '../database/database.dart' show Tag;
import 'task_model.dart';

class TagModel extends Equatable {
  @override
  List<Object?> get props => [id, name];

  final int id;
  final String name;
  final List<TaskModel>? tasks;

  const TagModel({
    required this.id,
    required this.name,
    this.tasks,
  });

  factory TagModel.fromEntity(Tag tagEntity, {List<TaskModel>? tasks}) {
    return TagModel(
      id: tagEntity.id,
      name: tagEntity.name,
      tasks: tasks,
    );
  }

  Tag toEntity() {
    return Tag(
      id: id,
      name: name,
    );
  }
}
