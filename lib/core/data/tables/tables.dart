import 'package:drift/drift.dart';

class Subtasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId => integer().customConstraint('REFERENCES tasks(id)').nullable()();
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
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

class GoalTasks extends Table {
  IntColumn get goalId => integer().customConstraint('REFERENCES goals(id)').nullable()();
  IntColumn get taskId => integer().customConstraint('REFERENCES tasks(id)').nullable()();
  
  @override
  Set<Column> get primaryKey => {goalId, taskId}; // ترکیب دو ستون به عنوان کلید اصلی
}

class TaskTags extends Table {
  IntColumn get taskId => integer().customConstraint('REFERENCES tasks(id)').nullable()();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id)').nullable()();
  
  @override
  Set<Column> get primaryKey => {taskId, tagId}; // ترکیب دو ستون به عنوان کلید اصلی
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  IntColumn get priority => integer().nullable()();
  IntColumn get parentTaskId =>
      integer().nullable().customConstraint('REFERENCES tasks(id)')();
}

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get theme => text().withLength(min: 1, max: 50).nullable()();
}
