import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';

part 'subtask_dao.g.dart';

@DriftAccessor(tables: [Subtasks])
class SubtaskDao extends DatabaseAccessor<AppDatabase> with _$SubtaskDaoMixin {
  SubtaskDao(super.attachedDatabase);

  Future<List<Subtask>> getAllSubtasks() => select(subtasks).get();
  Stream<List<Subtask>> watchAllSubtasks() => select(subtasks).watch();
  Future<Subtask> getSubtaskById(int id) =>
      (select(subtasks)..where((st) => st.id.equals(id))).getSingle();
  Future<int> insertSubtask(Subtask subtask) => into(subtasks).insert(subtask);
  Future<bool> updateSubtask(Subtask subtask) => update(subtasks).replace(subtask);
  Future<int> deleteSubtask(int id) =>
      (delete(subtasks)..where((st) => st.id.equals(id))).go();
}