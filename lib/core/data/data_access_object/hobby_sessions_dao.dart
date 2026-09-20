import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/hobby_session_model.dart';

part 'hobby_sessions_dao.g.dart';

@DriftAccessor(tables: [HobbySessions])
class HobbySessionsDao extends DatabaseAccessor<AppDatabase> with _$HobbySessionsDaoMixin {
  HobbySessionsDao(super.attachedDatabase);

  Stream<List<HobbySessionModel>> watchSessionsForHobby(int hobbyId) {
    return (select(hobbySessions)..where((s) => s.hobbyId.equals(hobbyId))).watch().map(
      (rows) => rows.map((session) => HobbySessionModel.fromEntity(session)).toList(),
    );
  }

  Future<HobbySessionModel?> getSessionById(int id) async {
    final session = await (select(hobbySessions)..where((s) => s.id.equals(id))).getSingleOrNull();
    if (session == null) return null;
    return HobbySessionModel.fromEntity(session);
  }

  Future<int> insertSession(HobbySessionModel session) async {
    return await into(hobbySessions).insert(session.toInsertCompanion());
  }

  Future<bool> updateSession(HobbySessionModel session) =>
      update(hobbySessions).replace(session.toEntity());

  Future<int> deleteSession(int id) =>
      (delete(hobbySessions)..where((s) => s.id.equals(id))).go();

  Future<List<HobbySessionModel>> getSessionsForHobby(int hobbyId) async {
    final rows = await (select(hobbySessions)..where((s) => s.hobbyId.equals(hobbyId))).get();
    return rows.map((session) => HobbySessionModel.fromEntity(session)).toList();
  }

  Future<List<HobbySessionModel>> getSessionsInRange(DateTime start, DateTime end) async {
    final rows = await (select(hobbySessions)
          ..where((s) => s.startTime.isBetweenValues(start, end)))
        .get();
    return rows.map((session) => HobbySessionModel.fromEntity(session)).toList();
  }

  Future<Map<int, int>> getTotalDurationPerHobby(DateTime start, DateTime end) async {
    final rows = await (select(hobbySessions)
          ..where((s) => s.startTime.isBetweenValues(start, end) & s.endTime.isNotNull()))
        .get();

    final Map<int, int> result = {};
    for (final session in rows) {
      final duration = session.durationMinutes ?? 0;
      final hobbyId = session.hobbyId ?? 0;
      result[hobbyId] = (result[hobbyId] ?? 0) + duration;
    }
    return result;
  }

  Future<void> endSession(int sessionId, {int? mood, String? notes}) async {
    final session = await getSessionById(sessionId);
    if (session != null) {
      final endTime = DateTime.now();
      final duration = endTime.difference(session.startTime).inMinutes;
      
      final updated = session.copyWith(
        endTime: endTime,
        durationMinutes: duration,
        mood: mood,
        notes: notes,
      );
      
      await updateSession(updated);
    }
  }
}