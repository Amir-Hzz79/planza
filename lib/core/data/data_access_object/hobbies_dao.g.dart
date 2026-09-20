// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hobbies_dao.dart';

// ignore_for_file: type=lint
mixin _$HobbiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => attachedDatabase.goals;
  $HobbiesTable get hobbies => attachedDatabase.hobbies;
  HobbiesDaoManager get managers => HobbiesDaoManager(this);
}

class HobbiesDaoManager {
  final _$HobbiesDaoMixin _db;
  HobbiesDaoManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
  $$HobbiesTableTableManager get hobbies =>
      $$HobbiesTableTableManager(_db.attachedDatabase, _db.hobbies);
}
