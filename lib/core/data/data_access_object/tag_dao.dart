import 'package:drift/drift.dart';
import 'package:planza/core/data/database.dart';

import '../tables/tables.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(super.attachedDatabase);

  Future<List<Tag>> getAllTags() => select(tags).get();
  Stream<List<Tag>> watchAllTags() => select(tags).watch();
  Future<Tag> getTagById(int id) =>
      (select(tags)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertTag(Tag tag) => into(tags).insert(tag);
  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);
  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();
}
