import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Tags, Tasks, TaskTags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(super.attachedDatabase);

  Future<List<TagModel>> getAllTags() => select(tags).get().then(
        (tags) => tags
            .map(
              (tag) => TagModel.fromEntity(tag),
            )
            .toList(),
      );

  Stream<List<TagModel>> watchAllTagsWithTasks() {
    final query = select(tags).join([
      leftOuterJoin(taskTags, taskTags.tagId.equalsExp(tags.id)),
      leftOuterJoin(tasks, tasks.id.equalsExp(taskTags.taskId)),
    ]);

    return query.watch().map((rows) {
      final tagsMap = <Tag, List<Task>>{};

      for (final row in rows) {
        final Tag tag = row.readTable(tags);
        final Task? task = row.readTableOrNull(tasks);

        tagsMap.putIfAbsent(tag, () => []);
        if (task != null) {
          tagsMap[tag]!.add(task);
        }
      }

      return tagsMap.entries.map((entry) {
        final Tag tagEntity = entry.key;
        final List<Task> taskList = entry.value;

        return TagModel.fromEntity(tagEntity,
            tasks: taskList.map((task) => TaskModel.fromEntity(task)).toList());
      }).toList();
    });
  }

  Future<TagModel> getTagById(int id) =>
      (select(tags)..where((t) => t.id.equals(id))).getSingle().then(
            (value) => TagModel.fromEntity(value),
          );
  Future<int> insertTag(TagModel tag) => into(tags).insert(tag.toEntity());
  Future<bool> updateTag(TagModel tag) => update(tags).replace(tag.toEntity());
  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();
}
