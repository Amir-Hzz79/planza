// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hobby_sessions_dao.dart';

// ignore_for_file: type=lint
mixin _$HobbySessionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => attachedDatabase.goals;
  $HobbiesTable get hobbies => attachedDatabase.hobbies;
  $HobbySessionsTable get hobbySessions => attachedDatabase.hobbySessions;
  HobbySessionsDaoManager get managers => HobbySessionsDaoManager(this);
}

class HobbySessionsDaoManager {
  final _$HobbySessionsDaoMixin _db;
  HobbySessionsDaoManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
  $$HobbiesTableTableManager get hobbies =>
      $$HobbiesTableTableManager(_db.attachedDatabase, _db.hobbies);
  $$HobbySessionsTableTableManager get hobbySessions =>
      $$HobbySessionsTableTableManager(_db.attachedDatabase, _db.hobbySessions);
}
