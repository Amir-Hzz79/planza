import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'task_tag_dao.g.dart';

@DriftAccessor(tables: [TaskTags])
class TaskTagDao extends DatabaseAccessor<AppDatabase> with _$TaskTagDaoMixin {
  TaskTagDao(super.attachedDatabase);

  Future<List<TaskTag>> getAllTaskTags() => select(taskTags).get();
  Stream<List<TaskTag>> watchAllTaskTags() => select(taskTags).watch();
  Future<TaskTag> getTaskTagById(int taskId, int tagId) =>
      (select(taskTags)..where((tt) => tt.taskId.equals(taskId) & tt.tagId.equals(tagId))).getSingle();
  Future<int> insertTaskTag(TaskTag taskTag) => into(taskTags).insert(taskTag);
  Future<bool> updateTaskTag(TaskTag taskTag) => update(taskTags).replace(taskTag);
  Future<int> deleteTaskTag(int taskId, int tagId) =>
      (delete(taskTags)..where((tt) => tt.taskId.equals(taskId) & tt.tagId.equals(tagId))).go();
}