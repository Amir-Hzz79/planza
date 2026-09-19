import 'package:drift/drift.dart';

class Subtasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId =>
      integer().customConstraint('REFERENCES tasks(id)').nullable()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
}

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  IntColumn get color => integer()();
  IntColumn get icon => integer()();
  IntColumn get parentGoalId =>
      integer().nullable().customConstraint('REFERENCES goals(id)')();
}

class TaskTags extends Table {
  IntColumn get taskId =>
      integer().customConstraint('REFERENCES tasks(id)').nullable()();
  IntColumn get tagId =>
      integer().customConstraint('REFERENCES tags(id)').nullable()();

  @override
  Set<Column> get primaryKey =>
      {taskId, tagId};
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get doneDate => dateTime().nullable()();
  IntColumn get priority => integer().nullable()();
  IntColumn get goalId =>
      integer().nullable().customConstraint('REFERENCES goals(id)')();
  IntColumn get parentTaskId =>
      integer().nullable().customConstraint('REFERENCES tasks(id)')();
}

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get theme => text().withLength(min: 1, max: 50).nullable()();
}

class NotificationPrefs extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get defaultReminderMinutes =>
      integer().withDefault(const Constant(30))();
  BoolColumn get snoozeEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get snoozePresets =>
      text().withDefault(const Constant('[10,60,1440]'))();
  BoolColumn get quietHoursEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get quietHoursStart =>
      text().withDefault(const Constant('22:00'))();
  TextColumn get quietHoursEnd =>
      text().withDefault(const Constant('08:00'))();
  TextColumn get workingDays =>
      text().withDefault(const Constant('[1,2,3,4,5]'))();
  BoolColumn get goalOverrideEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class GoalNotificationOverride extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId =>
      integer().nullable().customConstraint('REFERENCES goals(id)')();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get reminderMinutes =>
      integer().nullable().withDefault(const Constant(0))();
  BoolColumn get snoozeEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().withLength(min: 1, max: 100)();
  IntColumn get icon => integer().nullable()();
  IntColumn get color => integer().nullable()();
  TextColumn get payloadJson => text()();
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}