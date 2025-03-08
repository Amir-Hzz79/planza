import '../database/database.dart' show Tag;

class TagModel {
  final int id;
  final String name;

  TagModel({
    required this.id,
    required this.name,
  });

  // Convert a Tag entity to a TagModel
  factory TagModel.fromEntity(Tag tagEntity) {
    return TagModel(
      id: tagEntity.id,
      name: tagEntity.name,
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
