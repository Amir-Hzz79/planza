import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/hobby_model.dart';

part 'hobbies_dao.g.dart';

@DriftAccessor(tables: [Hobbies])
class HobbiesDao extends DatabaseAccessor<AppDatabase> with _$HobbiesDaoMixin {
  HobbiesDao(super.attachedDatabase);

  Stream<List<HobbyModel>> watchAllHobbies() {
    return select(hobbies).watch().map((rows) {
      return rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList();
    });
  }

  Stream<List<HobbyModel>> watchActiveHobbies() {
    return (select(hobbies)..where((h) => h.isActive.equals(true))).watch().map(
      (rows) => rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList(),
    );
  }

  Stream<List<HobbyModel>> watchHobbiesByCategory(String category) {
    return (select(hobbies)..where((h) => h.category.equals(category))).watch().map(
      (rows) => rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList(),
    );
  }

  Stream<List<HobbyModel>> watchHobbiesByGoal(int goalId) {
    return (select(hobbies)..where((h) => h.goalId.equals(goalId))).watch().map(
      (rows) => rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList(),
    );
  }

  Future<HobbyModel?> getHobbyById(int id) async {
    final hobby = await (select(hobbies)..where((h) => h.id.equals(id))).getSingleOrNull();
    if (hobby == null) return null;
    return HobbyModel.fromEntity(hobby);
  }

  Future<int> insertHobby(HobbyModel hobby) async {
    return await into(hobbies).insert(hobby.toInsertCompanion());
  }

  Future<bool> updateHobby(HobbyModel hobby) =>
      update(hobbies).replace(hobby.toEntity());

  Future<int> deleteHobby(int id) =>
      (delete(hobbies)..where((h) => h.id.equals(id))).go();

  Future<List<HobbyModel>> getAllHobbies() async {
    final rows = await select(hobbies).get();
    return rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList();
  }

  Future<List<HobbyModel>> getActiveHobbies() async {
    final rows = await (select(hobbies)..where((h) => h.isActive.equals(true))).get();
    return rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList();
  }

  Future<List<HobbyModel>> getHobbiesByCategory(String category) async {
    final rows = await (select(hobbies)..where((h) => h.category.equals(category))).get();
    return rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList();
  }

  Future<List<HobbyModel>> getHobbiesByGoal(int goalId) async {
    final rows = await (select(hobbies)..where((h) => h.goalId.equals(goalId))).get();
    return rows.map((hobby) => HobbyModel.fromEntity(hobby)).toList();
  }
}