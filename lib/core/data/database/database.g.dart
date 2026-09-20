// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentGoalIdMeta =
      const VerificationMeta('parentGoalId');
  @override
  late final GeneratedColumn<int> parentGoalId = GeneratedColumn<int>(
      'parent_goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES goals(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, deadline, color, icon, parentGoalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('parent_goal_id')) {
      context.handle(
          _parentGoalIdMeta,
          parentGoalId.isAcceptableOrUnknown(
              data['parent_goal_id']!, _parentGoalIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon'])!,
      parentGoalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_goal_id']),
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final String name;
  final String? description;
  final DateTime? deadline;
  final int color;
  final int icon;
  final int? parentGoalId;
  const Goal(
      {required this.id,
      required this.name,
      this.description,
      this.deadline,
      required this.color,
      required this.icon,
      this.parentGoalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['color'] = Variable<int>(color);
    map['icon'] = Variable<int>(icon);
    if (!nullToAbsent || parentGoalId != null) {
      map['parent_goal_id'] = Variable<int>(parentGoalId);
    }
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      color: Value(color),
      icon: Value(icon),
      parentGoalId: parentGoalId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentGoalId),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      color: serializer.fromJson<int>(json['color']),
      icon: serializer.fromJson<int>(json['icon']),
      parentGoalId: serializer.fromJson<int?>(json['parentGoalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'color': serializer.toJson<int>(color),
      'icon': serializer.toJson<int>(icon),
      'parentGoalId': serializer.toJson<int?>(parentGoalId),
    };
  }

  Goal copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          int? color,
          int? icon,
          Value<int?> parentGoalId = const Value.absent()}) =>
      Goal(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        deadline: deadline.present ? deadline.value : this.deadline,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        parentGoalId:
            parentGoalId.present ? parentGoalId.value : this.parentGoalId,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      parentGoalId: data.parentGoalId.present
          ? data.parentGoalId.value
          : this.parentGoalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('parentGoalId: $parentGoalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, deadline, color, icon, parentGoalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.deadline == this.deadline &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.parentGoalId == this.parentGoalId);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime?> deadline;
  final Value<int> color;
  final Value<int> icon;
  final Value<int?> parentGoalId;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.parentGoalId = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    required int color,
    required int icon,
    this.parentGoalId = const Value.absent(),
  })  : name = Value(name),
        color = Value(color),
        icon = Value(icon);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? deadline,
    Expression<int>? color,
    Expression<int>? icon,
    Expression<int>? parentGoalId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (deadline != null) 'deadline': deadline,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (parentGoalId != null) 'parent_goal_id': parentGoalId,
    });
  }

  GoalsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime?>? deadline,
      Value<int>? color,
      Value<int>? icon,
      Value<int?>? parentGoalId}) {
    return GoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      parentGoalId: parentGoalId ?? this.parentGoalId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (parentGoalId.present) {
      map['parent_goal_id'] = Variable<int>(parentGoalId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('parentGoalId: $parentGoalId')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _doneDateMeta =
      const VerificationMeta('doneDate');
  @override
  late final GeneratedColumn<DateTime> doneDate = GeneratedColumn<DateTime>(
      'done_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES goals(id)');
  static const VerificationMeta _parentTaskIdMeta =
      const VerificationMeta('parentTaskId');
  @override
  late final GeneratedColumn<int> parentTaskId = GeneratedColumn<int>(
      'parent_task_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tasks(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        dueDate,
        doneDate,
        priority,
        goalId,
        parentTaskId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('done_date')) {
      context.handle(_doneDateMeta,
          doneDate.isAcceptableOrUnknown(data['done_date']!, _doneDateMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('parent_task_id')) {
      context.handle(
          _parentTaskIdMeta,
          parentTaskId.isAcceptableOrUnknown(
              data['parent_task_id']!, _parentTaskIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      doneDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}done_date']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority']),
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id']),
      parentTaskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_task_id']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? doneDate;
  final int? priority;
  final int? goalId;
  final int? parentTaskId;
  const Task(
      {required this.id,
      required this.title,
      this.description,
      this.dueDate,
      this.doneDate,
      this.priority,
      this.goalId,
      this.parentTaskId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || doneDate != null) {
      map['done_date'] = Variable<DateTime>(doneDate);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<int>(goalId);
    }
    if (!nullToAbsent || parentTaskId != null) {
      map['parent_task_id'] = Variable<int>(parentTaskId);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      doneDate: doneDate == null && nullToAbsent
          ? const Value.absent()
          : Value(doneDate),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      parentTaskId: parentTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTaskId),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      doneDate: serializer.fromJson<DateTime?>(json['doneDate']),
      priority: serializer.fromJson<int?>(json['priority']),
      goalId: serializer.fromJson<int?>(json['goalId']),
      parentTaskId: serializer.fromJson<int?>(json['parentTaskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'doneDate': serializer.toJson<DateTime?>(doneDate),
      'priority': serializer.toJson<int?>(priority),
      'goalId': serializer.toJson<int?>(goalId),
      'parentTaskId': serializer.toJson<int?>(parentTaskId),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> dueDate = const Value.absent(),
          Value<DateTime?> doneDate = const Value.absent(),
          Value<int?> priority = const Value.absent(),
          Value<int?> goalId = const Value.absent(),
          Value<int?> parentTaskId = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        doneDate: doneDate.present ? doneDate.value : this.doneDate,
        priority: priority.present ? priority.value : this.priority,
        goalId: goalId.present ? goalId.value : this.goalId,
        parentTaskId:
            parentTaskId.present ? parentTaskId.value : this.parentTaskId,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      doneDate: data.doneDate.present ? data.doneDate.value : this.doneDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      parentTaskId: data.parentTaskId.present
          ? data.parentTaskId.value
          : this.parentTaskId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('doneDate: $doneDate, ')
          ..write('priority: $priority, ')
          ..write('goalId: $goalId, ')
          ..write('parentTaskId: $parentTaskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, dueDate, doneDate,
      priority, goalId, parentTaskId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dueDate == this.dueDate &&
          other.doneDate == this.doneDate &&
          other.priority == this.priority &&
          other.goalId == this.goalId &&
          other.parentTaskId == this.parentTaskId);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> doneDate;
  final Value<int?> priority;
  final Value<int?> goalId;
  final Value<int?> parentTaskId;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.doneDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.goalId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.doneDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.goalId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? doneDate,
    Expression<int>? priority,
    Expression<int>? goalId,
    Expression<int>? parentTaskId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'due_date': dueDate,
      if (doneDate != null) 'done_date': doneDate,
      if (priority != null) 'priority': priority,
      if (goalId != null) 'goal_id': goalId,
      if (parentTaskId != null) 'parent_task_id': parentTaskId,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? dueDate,
      Value<DateTime?>? doneDate,
      Value<int?>? priority,
      Value<int?>? goalId,
      Value<int?>? parentTaskId}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      doneDate: doneDate ?? this.doneDate,
      priority: priority ?? this.priority,
      goalId: goalId ?? this.goalId,
      parentTaskId: parentTaskId ?? this.parentTaskId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (doneDate.present) {
      map['done_date'] = Variable<DateTime>(doneDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (parentTaskId.present) {
      map['parent_task_id'] = Variable<int>(parentTaskId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('doneDate: $doneDate, ')
          ..write('priority: $priority, ')
          ..write('goalId: $goalId, ')
          ..write('parentTaskId: $parentTaskId')
          ..write(')'))
        .toString();
  }
}

class $SubtasksTable extends Subtasks with TableInfo<$SubtasksTable, Subtask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubtasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
      'task_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tasks(id)');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, taskId, title, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subtasks';
  @override
  VerificationContext validateIntegrity(Insertable<Subtask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subtask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subtask(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
    );
  }

  @override
  $SubtasksTable createAlias(String alias) {
    return $SubtasksTable(attachedDatabase, alias);
  }
}

class Subtask extends DataClass implements Insertable<Subtask> {
  final int id;
  final int? taskId;
  final String title;
  final bool completed;
  const Subtask(
      {required this.id,
      this.taskId,
      required this.title,
      required this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<int>(taskId);
    }
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  SubtasksCompanion toCompanion(bool nullToAbsent) {
    return SubtasksCompanion(
      id: Value(id),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      title: Value(title),
      completed: Value(completed),
    );
  }

  factory Subtask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subtask(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int?>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<int?>(taskId),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  Subtask copyWith(
          {int? id,
          Value<int?> taskId = const Value.absent(),
          String? title,
          bool? completed}) =>
      Subtask(
        id: id ?? this.id,
        taskId: taskId.present ? taskId.value : this.taskId,
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );
  Subtask copyWithCompanion(SubtasksCompanion data) {
    return Subtask(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subtask(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, title, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subtask &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.completed == this.completed);
}

class SubtasksCompanion extends UpdateCompanion<Subtask> {
  final Value<int> id;
  final Value<int?> taskId;
  final Value<String> title;
  final Value<bool> completed;
  const SubtasksCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
  });
  SubtasksCompanion.insert({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Subtask> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<String>? title,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
    });
  }

  SubtasksCompanion copyWith(
      {Value<int>? id,
      Value<int?>? taskId,
      Value<String>? title,
      Value<bool>? completed}) {
    return SubtasksCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubtasksCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  const Tag({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Tag copyWith({int? id, String? name}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TagsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TaskTagsTable extends TaskTags with TableInfo<$TaskTagsTable, TaskTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
      'task_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tasks(id)');
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tags(id)');
  @override
  List<GeneratedColumn> get $columns => [taskId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_tags';
  @override
  VerificationContext validateIntegrity(Insertable<TaskTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId, tagId};
  @override
  TaskTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTag(
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_id']),
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id']),
    );
  }

  @override
  $TaskTagsTable createAlias(String alias) {
    return $TaskTagsTable(attachedDatabase, alias);
  }
}

class TaskTag extends DataClass implements Insertable<TaskTag> {
  final int? taskId;
  final int? tagId;
  const TaskTag({this.taskId, this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<int>(taskId);
    }
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    return map;
  }

  TaskTagsCompanion toCompanion(bool nullToAbsent) {
    return TaskTagsCompanion(
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
    );
  }

  factory TaskTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTag(
      taskId: serializer.fromJson<int?>(json['taskId']),
      tagId: serializer.fromJson<int?>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<int?>(taskId),
      'tagId': serializer.toJson<int?>(tagId),
    };
  }

  TaskTag copyWith(
          {Value<int?> taskId = const Value.absent(),
          Value<int?> tagId = const Value.absent()}) =>
      TaskTag(
        taskId: taskId.present ? taskId.value : this.taskId,
        tagId: tagId.present ? tagId.value : this.tagId,
      );
  TaskTag copyWithCompanion(TaskTagsCompanion data) {
    return TaskTag(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTag(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTag &&
          other.taskId == this.taskId &&
          other.tagId == this.tagId);
}

class TaskTagsCompanion extends UpdateCompanion<TaskTag> {
  final Value<int?> taskId;
  final Value<int?> tagId;
  final Value<int> rowid;
  const TaskTagsCompanion({
    this.taskId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskTagsCompanion.insert({
    this.taskId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<TaskTag> custom({
    Expression<int>? taskId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskTagsCompanion copyWith(
      {Value<int?>? taskId, Value<int?>? tagId, Value<int>? rowid}) {
    return TaskTagsCompanion(
      taskId: taskId ?? this.taskId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTagsCompanion(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
      'theme', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, notificationsEnabled, theme];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
          _themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      theme: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme']),
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final int id;
  final bool notificationsEnabled;
  final String? theme;
  const UserSetting(
      {required this.id, required this.notificationsEnabled, this.theme});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    if (!nullToAbsent || theme != null) {
      map['theme'] = Variable<String>(theme);
    }
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      notificationsEnabled: Value(notificationsEnabled),
      theme:
          theme == null && nullToAbsent ? const Value.absent() : Value(theme),
    );
  }

  factory UserSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<int>(json['id']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      theme: serializer.fromJson<String?>(json['theme']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'theme': serializer.toJson<String?>(theme),
    };
  }

  UserSetting copyWith(
          {int? id,
          bool? notificationsEnabled,
          Value<String?> theme = const Value.absent()}) =>
      UserSetting(
        id: id ?? this.id,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        theme: theme.present ? theme.value : this.theme,
      );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      theme: data.theme.present ? data.theme.value : this.theme,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('theme: $theme')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notificationsEnabled, theme);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.theme == this.theme);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<int> id;
  final Value<bool> notificationsEnabled;
  final Value<String?> theme;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.theme = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.theme = const Value.absent(),
  });
  static Insertable<UserSetting> custom({
    Expression<int>? id,
    Expression<bool>? notificationsEnabled,
    Expression<String>? theme,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (theme != null) 'theme': theme,
    });
  }

  UserSettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? notificationsEnabled,
      Value<String?>? theme}) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      theme: theme ?? this.theme,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('theme: $theme')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isBuiltinMeta =
      const VerificationMeta('isBuiltin');
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
      'is_builtin', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_builtin" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        category,
        icon,
        color,
        payloadJson,
        isBuiltin,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(Insertable<Template> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('is_builtin')) {
      context.handle(_isBuiltinMeta,
          isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      isBuiltin: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_builtin'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String payloadJson;
  final bool isBuiltin;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Template(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      this.icon,
      this.color,
      required this.payloadJson,
      required this.isBuiltin,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<int>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['payload_json'] = Variable<String>(payloadJson);
    map['is_builtin'] = Variable<bool>(isBuiltin);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      payloadJson: Value(payloadJson),
      isBuiltin: Value(isBuiltin),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Template.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      icon: serializer.fromJson<int?>(json['icon']),
      color: serializer.fromJson<int?>(json['color']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'icon': serializer.toJson<int?>(icon),
      'color': serializer.toJson<int?>(color),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Template copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? category,
          Value<int?> icon = const Value.absent(),
          Value<int?> color = const Value.absent(),
          String? payloadJson,
          bool? isBuiltin,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Template(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        icon: icon.present ? icon.value : this.icon,
        color: color.present ? color.value : this.color,
        payloadJson: payloadJson ?? this.payloadJson,
        isBuiltin: isBuiltin ?? this.isBuiltin,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, category, icon, color,
      payloadJson, isBuiltin, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.payloadJson == this.payloadJson &&
          other.isBuiltin == this.isBuiltin &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> category;
  final Value<int?> icon;
  final Value<int?> color;
  final Value<String> payloadJson;
  final Value<bool> isBuiltin;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String category,
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    required String payloadJson,
    this.isBuiltin = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        category = Value(category),
        payloadJson = Value(payloadJson),
        createdAt = Value(createdAt);
  static Insertable<Template> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<String>? payloadJson,
    Expression<bool>? isBuiltin,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? category,
      Value<int?>? icon,
      Value<int?>? color,
      Value<String>? payloadJson,
      Value<bool>? isBuiltin,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      payloadJson: payloadJson ?? this.payloadJson,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationPrefsTable extends NotificationPrefs
    with TableInfo<$NotificationPrefsTable, NotificationPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _defaultReminderMinutesMeta =
      const VerificationMeta('defaultReminderMinutes');
  @override
  late final GeneratedColumn<int> defaultReminderMinutes = GeneratedColumn<int>(
      'default_reminder_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _snoozeEnabledMeta =
      const VerificationMeta('snoozeEnabled');
  @override
  late final GeneratedColumn<bool> snoozeEnabled = GeneratedColumn<bool>(
      'snooze_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("snooze_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _snoozePresetsMeta =
      const VerificationMeta('snoozePresets');
  @override
  late final GeneratedColumn<String> snoozePresets = GeneratedColumn<String>(
      'snooze_presets', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[10,60,1440]'));
  static const VerificationMeta _quietHoursEnabledMeta =
      const VerificationMeta('quietHoursEnabled');
  @override
  late final GeneratedColumn<bool> quietHoursEnabled = GeneratedColumn<bool>(
      'quiet_hours_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("quiet_hours_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _quietHoursStartMeta =
      const VerificationMeta('quietHoursStart');
  @override
  late final GeneratedColumn<String> quietHoursStart = GeneratedColumn<String>(
      'quiet_hours_start', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('22:00'));
  static const VerificationMeta _quietHoursEndMeta =
      const VerificationMeta('quietHoursEnd');
  @override
  late final GeneratedColumn<String> quietHoursEnd = GeneratedColumn<String>(
      'quiet_hours_end', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('08:00'));
  static const VerificationMeta _workingDaysMeta =
      const VerificationMeta('workingDays');
  @override
  late final GeneratedColumn<String> workingDays = GeneratedColumn<String>(
      'working_days', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[1,2,3,4,5]'));
  static const VerificationMeta _goalOverrideEnabledMeta =
      const VerificationMeta('goalOverrideEnabled');
  @override
  late final GeneratedColumn<bool> goalOverrideEnabled = GeneratedColumn<bool>(
      'goal_override_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("goal_override_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        notificationsEnabled,
        defaultReminderMinutes,
        snoozeEnabled,
        snoozePresets,
        quietHoursEnabled,
        quietHoursStart,
        quietHoursEnd,
        workingDays,
        goalOverrideEnabled,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_prefs';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationPref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('default_reminder_minutes')) {
      context.handle(
          _defaultReminderMinutesMeta,
          defaultReminderMinutes.isAcceptableOrUnknown(
              data['default_reminder_minutes']!, _defaultReminderMinutesMeta));
    }
    if (data.containsKey('snooze_enabled')) {
      context.handle(
          _snoozeEnabledMeta,
          snoozeEnabled.isAcceptableOrUnknown(
              data['snooze_enabled']!, _snoozeEnabledMeta));
    }
    if (data.containsKey('snooze_presets')) {
      context.handle(
          _snoozePresetsMeta,
          snoozePresets.isAcceptableOrUnknown(
              data['snooze_presets']!, _snoozePresetsMeta));
    }
    if (data.containsKey('quiet_hours_enabled')) {
      context.handle(
          _quietHoursEnabledMeta,
          quietHoursEnabled.isAcceptableOrUnknown(
              data['quiet_hours_enabled']!, _quietHoursEnabledMeta));
    }
    if (data.containsKey('quiet_hours_start')) {
      context.handle(
          _quietHoursStartMeta,
          quietHoursStart.isAcceptableOrUnknown(
              data['quiet_hours_start']!, _quietHoursStartMeta));
    }
    if (data.containsKey('quiet_hours_end')) {
      context.handle(
          _quietHoursEndMeta,
          quietHoursEnd.isAcceptableOrUnknown(
              data['quiet_hours_end']!, _quietHoursEndMeta));
    }
    if (data.containsKey('working_days')) {
      context.handle(
          _workingDaysMeta,
          workingDays.isAcceptableOrUnknown(
              data['working_days']!, _workingDaysMeta));
    }
    if (data.containsKey('goal_override_enabled')) {
      context.handle(
          _goalOverrideEnabledMeta,
          goalOverrideEnabled.isAcceptableOrUnknown(
              data['goal_override_enabled']!, _goalOverrideEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPref(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      defaultReminderMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}default_reminder_minutes'])!,
      snoozeEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}snooze_enabled'])!,
      snoozePresets: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snooze_presets'])!,
      quietHoursEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}quiet_hours_enabled'])!,
      quietHoursStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quiet_hours_start'])!,
      quietHoursEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quiet_hours_end'])!,
      workingDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}working_days'])!,
      goalOverrideEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}goal_override_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $NotificationPrefsTable createAlias(String alias) {
    return $NotificationPrefsTable(attachedDatabase, alias);
  }
}

class NotificationPref extends DataClass
    implements Insertable<NotificationPref> {
  final int id;
  final bool notificationsEnabled;
  final int defaultReminderMinutes;
  final bool snoozeEnabled;
  final String snoozePresets;
  final bool quietHoursEnabled;
  final String quietHoursStart;
  final String quietHoursEnd;
  final String workingDays;
  final bool goalOverrideEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const NotificationPref(
      {required this.id,
      required this.notificationsEnabled,
      required this.defaultReminderMinutes,
      required this.snoozeEnabled,
      required this.snoozePresets,
      required this.quietHoursEnabled,
      required this.quietHoursStart,
      required this.quietHoursEnd,
      required this.workingDays,
      required this.goalOverrideEnabled,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['default_reminder_minutes'] = Variable<int>(defaultReminderMinutes);
    map['snooze_enabled'] = Variable<bool>(snoozeEnabled);
    map['snooze_presets'] = Variable<String>(snoozePresets);
    map['quiet_hours_enabled'] = Variable<bool>(quietHoursEnabled);
    map['quiet_hours_start'] = Variable<String>(quietHoursStart);
    map['quiet_hours_end'] = Variable<String>(quietHoursEnd);
    map['working_days'] = Variable<String>(workingDays);
    map['goal_override_enabled'] = Variable<bool>(goalOverrideEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  NotificationPrefsCompanion toCompanion(bool nullToAbsent) {
    return NotificationPrefsCompanion(
      id: Value(id),
      notificationsEnabled: Value(notificationsEnabled),
      defaultReminderMinutes: Value(defaultReminderMinutes),
      snoozeEnabled: Value(snoozeEnabled),
      snoozePresets: Value(snoozePresets),
      quietHoursEnabled: Value(quietHoursEnabled),
      quietHoursStart: Value(quietHoursStart),
      quietHoursEnd: Value(quietHoursEnd),
      workingDays: Value(workingDays),
      goalOverrideEnabled: Value(goalOverrideEnabled),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory NotificationPref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPref(
      id: serializer.fromJson<int>(json['id']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      defaultReminderMinutes:
          serializer.fromJson<int>(json['defaultReminderMinutes']),
      snoozeEnabled: serializer.fromJson<bool>(json['snoozeEnabled']),
      snoozePresets: serializer.fromJson<String>(json['snoozePresets']),
      quietHoursEnabled: serializer.fromJson<bool>(json['quietHoursEnabled']),
      quietHoursStart: serializer.fromJson<String>(json['quietHoursStart']),
      quietHoursEnd: serializer.fromJson<String>(json['quietHoursEnd']),
      workingDays: serializer.fromJson<String>(json['workingDays']),
      goalOverrideEnabled:
          serializer.fromJson<bool>(json['goalOverrideEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'defaultReminderMinutes': serializer.toJson<int>(defaultReminderMinutes),
      'snoozeEnabled': serializer.toJson<bool>(snoozeEnabled),
      'snoozePresets': serializer.toJson<String>(snoozePresets),
      'quietHoursEnabled': serializer.toJson<bool>(quietHoursEnabled),
      'quietHoursStart': serializer.toJson<String>(quietHoursStart),
      'quietHoursEnd': serializer.toJson<String>(quietHoursEnd),
      'workingDays': serializer.toJson<String>(workingDays),
      'goalOverrideEnabled': serializer.toJson<bool>(goalOverrideEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  NotificationPref copyWith(
          {int? id,
          bool? notificationsEnabled,
          int? defaultReminderMinutes,
          bool? snoozeEnabled,
          String? snoozePresets,
          bool? quietHoursEnabled,
          String? quietHoursStart,
          String? quietHoursEnd,
          String? workingDays,
          bool? goalOverrideEnabled,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      NotificationPref(
        id: id ?? this.id,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        defaultReminderMinutes:
            defaultReminderMinutes ?? this.defaultReminderMinutes,
        snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
        snoozePresets: snoozePresets ?? this.snoozePresets,
        quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
        quietHoursStart: quietHoursStart ?? this.quietHoursStart,
        quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
        workingDays: workingDays ?? this.workingDays,
        goalOverrideEnabled: goalOverrideEnabled ?? this.goalOverrideEnabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  NotificationPref copyWithCompanion(NotificationPrefsCompanion data) {
    return NotificationPref(
      id: data.id.present ? data.id.value : this.id,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      defaultReminderMinutes: data.defaultReminderMinutes.present
          ? data.defaultReminderMinutes.value
          : this.defaultReminderMinutes,
      snoozeEnabled: data.snoozeEnabled.present
          ? data.snoozeEnabled.value
          : this.snoozeEnabled,
      snoozePresets: data.snoozePresets.present
          ? data.snoozePresets.value
          : this.snoozePresets,
      quietHoursEnabled: data.quietHoursEnabled.present
          ? data.quietHoursEnabled.value
          : this.quietHoursEnabled,
      quietHoursStart: data.quietHoursStart.present
          ? data.quietHoursStart.value
          : this.quietHoursStart,
      quietHoursEnd: data.quietHoursEnd.present
          ? data.quietHoursEnd.value
          : this.quietHoursEnd,
      workingDays:
          data.workingDays.present ? data.workingDays.value : this.workingDays,
      goalOverrideEnabled: data.goalOverrideEnabled.present
          ? data.goalOverrideEnabled.value
          : this.goalOverrideEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPref(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderMinutes: $defaultReminderMinutes, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('snoozePresets: $snoozePresets, ')
          ..write('quietHoursEnabled: $quietHoursEnabled, ')
          ..write('quietHoursStart: $quietHoursStart, ')
          ..write('quietHoursEnd: $quietHoursEnd, ')
          ..write('workingDays: $workingDays, ')
          ..write('goalOverrideEnabled: $goalOverrideEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      notificationsEnabled,
      defaultReminderMinutes,
      snoozeEnabled,
      snoozePresets,
      quietHoursEnabled,
      quietHoursStart,
      quietHoursEnd,
      workingDays,
      goalOverrideEnabled,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPref &&
          other.id == this.id &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.defaultReminderMinutes == this.defaultReminderMinutes &&
          other.snoozeEnabled == this.snoozeEnabled &&
          other.snoozePresets == this.snoozePresets &&
          other.quietHoursEnabled == this.quietHoursEnabled &&
          other.quietHoursStart == this.quietHoursStart &&
          other.quietHoursEnd == this.quietHoursEnd &&
          other.workingDays == this.workingDays &&
          other.goalOverrideEnabled == this.goalOverrideEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotificationPrefsCompanion extends UpdateCompanion<NotificationPref> {
  final Value<int> id;
  final Value<bool> notificationsEnabled;
  final Value<int> defaultReminderMinutes;
  final Value<bool> snoozeEnabled;
  final Value<String> snoozePresets;
  final Value<bool> quietHoursEnabled;
  final Value<String> quietHoursStart;
  final Value<String> quietHoursEnd;
  final Value<String> workingDays;
  final Value<bool> goalOverrideEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const NotificationPrefsCompanion({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderMinutes = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    this.snoozePresets = const Value.absent(),
    this.quietHoursEnabled = const Value.absent(),
    this.quietHoursStart = const Value.absent(),
    this.quietHoursEnd = const Value.absent(),
    this.workingDays = const Value.absent(),
    this.goalOverrideEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationPrefsCompanion.insert({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderMinutes = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    this.snoozePresets = const Value.absent(),
    this.quietHoursEnabled = const Value.absent(),
    this.quietHoursStart = const Value.absent(),
    this.quietHoursEnd = const Value.absent(),
    this.workingDays = const Value.absent(),
    this.goalOverrideEnabled = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  }) : createdAt = Value(createdAt);
  static Insertable<NotificationPref> custom({
    Expression<int>? id,
    Expression<bool>? notificationsEnabled,
    Expression<int>? defaultReminderMinutes,
    Expression<bool>? snoozeEnabled,
    Expression<String>? snoozePresets,
    Expression<bool>? quietHoursEnabled,
    Expression<String>? quietHoursStart,
    Expression<String>? quietHoursEnd,
    Expression<String>? workingDays,
    Expression<bool>? goalOverrideEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (defaultReminderMinutes != null)
        'default_reminder_minutes': defaultReminderMinutes,
      if (snoozeEnabled != null) 'snooze_enabled': snoozeEnabled,
      if (snoozePresets != null) 'snooze_presets': snoozePresets,
      if (quietHoursEnabled != null) 'quiet_hours_enabled': quietHoursEnabled,
      if (quietHoursStart != null) 'quiet_hours_start': quietHoursStart,
      if (quietHoursEnd != null) 'quiet_hours_end': quietHoursEnd,
      if (workingDays != null) 'working_days': workingDays,
      if (goalOverrideEnabled != null)
        'goal_override_enabled': goalOverrideEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationPrefsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? notificationsEnabled,
      Value<int>? defaultReminderMinutes,
      Value<bool>? snoozeEnabled,
      Value<String>? snoozePresets,
      Value<bool>? quietHoursEnabled,
      Value<String>? quietHoursStart,
      Value<String>? quietHoursEnd,
      Value<String>? workingDays,
      Value<bool>? goalOverrideEnabled,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return NotificationPrefsCompanion(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultReminderMinutes:
          defaultReminderMinutes ?? this.defaultReminderMinutes,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      snoozePresets: snoozePresets ?? this.snoozePresets,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      workingDays: workingDays ?? this.workingDays,
      goalOverrideEnabled: goalOverrideEnabled ?? this.goalOverrideEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (defaultReminderMinutes.present) {
      map['default_reminder_minutes'] =
          Variable<int>(defaultReminderMinutes.value);
    }
    if (snoozeEnabled.present) {
      map['snooze_enabled'] = Variable<bool>(snoozeEnabled.value);
    }
    if (snoozePresets.present) {
      map['snooze_presets'] = Variable<String>(snoozePresets.value);
    }
    if (quietHoursEnabled.present) {
      map['quiet_hours_enabled'] = Variable<bool>(quietHoursEnabled.value);
    }
    if (quietHoursStart.present) {
      map['quiet_hours_start'] = Variable<String>(quietHoursStart.value);
    }
    if (quietHoursEnd.present) {
      map['quiet_hours_end'] = Variable<String>(quietHoursEnd.value);
    }
    if (workingDays.present) {
      map['working_days'] = Variable<String>(workingDays.value);
    }
    if (goalOverrideEnabled.present) {
      map['goal_override_enabled'] = Variable<bool>(goalOverrideEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPrefsCompanion(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderMinutes: $defaultReminderMinutes, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('snoozePresets: $snoozePresets, ')
          ..write('quietHoursEnabled: $quietHoursEnabled, ')
          ..write('quietHoursStart: $quietHoursStart, ')
          ..write('quietHoursEnd: $quietHoursEnd, ')
          ..write('workingDays: $workingDays, ')
          ..write('goalOverrideEnabled: $goalOverrideEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalNotificationOverrideTable extends GoalNotificationOverride
    with
        TableInfo<$GoalNotificationOverrideTable,
            GoalNotificationOverrideData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalNotificationOverrideTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES goals(id)');
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _reminderMinutesMeta =
      const VerificationMeta('reminderMinutes');
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
      'reminder_minutes', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _snoozeEnabledMeta =
      const VerificationMeta('snoozeEnabled');
  @override
  late final GeneratedColumn<bool> snoozeEnabled = GeneratedColumn<bool>(
      'snooze_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("snooze_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        goalId,
        notificationsEnabled,
        reminderMinutes,
        snoozeEnabled,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_notification_override';
  @override
  VerificationContext validateIntegrity(
      Insertable<GoalNotificationOverrideData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
          _reminderMinutesMeta,
          reminderMinutes.isAcceptableOrUnknown(
              data['reminder_minutes']!, _reminderMinutesMeta));
    }
    if (data.containsKey('snooze_enabled')) {
      context.handle(
          _snoozeEnabledMeta,
          snoozeEnabled.isAcceptableOrUnknown(
              data['snooze_enabled']!, _snoozeEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalNotificationOverrideData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalNotificationOverrideData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id']),
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      reminderMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_minutes']),
      snoozeEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}snooze_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $GoalNotificationOverrideTable createAlias(String alias) {
    return $GoalNotificationOverrideTable(attachedDatabase, alias);
  }
}

class GoalNotificationOverrideData extends DataClass
    implements Insertable<GoalNotificationOverrideData> {
  final int id;
  final int? goalId;
  final bool notificationsEnabled;
  final int? reminderMinutes;
  final bool snoozeEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const GoalNotificationOverrideData(
      {required this.id,
      this.goalId,
      required this.notificationsEnabled,
      this.reminderMinutes,
      required this.snoozeEnabled,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<int>(goalId);
    }
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    if (!nullToAbsent || reminderMinutes != null) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes);
    }
    map['snooze_enabled'] = Variable<bool>(snoozeEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  GoalNotificationOverrideCompanion toCompanion(bool nullToAbsent) {
    return GoalNotificationOverrideCompanion(
      id: Value(id),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      notificationsEnabled: Value(notificationsEnabled),
      reminderMinutes: reminderMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinutes),
      snoozeEnabled: Value(snoozeEnabled),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory GoalNotificationOverrideData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalNotificationOverrideData(
      id: serializer.fromJson<int>(json['id']),
      goalId: serializer.fromJson<int?>(json['goalId']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      reminderMinutes: serializer.fromJson<int?>(json['reminderMinutes']),
      snoozeEnabled: serializer.fromJson<bool>(json['snoozeEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalId': serializer.toJson<int?>(goalId),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'reminderMinutes': serializer.toJson<int?>(reminderMinutes),
      'snoozeEnabled': serializer.toJson<bool>(snoozeEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  GoalNotificationOverrideData copyWith(
          {int? id,
          Value<int?> goalId = const Value.absent(),
          bool? notificationsEnabled,
          Value<int?> reminderMinutes = const Value.absent(),
          bool? snoozeEnabled,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      GoalNotificationOverrideData(
        id: id ?? this.id,
        goalId: goalId.present ? goalId.value : this.goalId,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        reminderMinutes: reminderMinutes.present
            ? reminderMinutes.value
            : this.reminderMinutes,
        snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  GoalNotificationOverrideData copyWithCompanion(
      GoalNotificationOverrideCompanion data) {
    return GoalNotificationOverrideData(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      snoozeEnabled: data.snoozeEnabled.present
          ? data.snoozeEnabled.value
          : this.snoozeEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalNotificationOverrideData(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goalId, notificationsEnabled,
      reminderMinutes, snoozeEnabled, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalNotificationOverrideData &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.reminderMinutes == this.reminderMinutes &&
          other.snoozeEnabled == this.snoozeEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalNotificationOverrideCompanion
    extends UpdateCompanion<GoalNotificationOverrideData> {
  final Value<int> id;
  final Value<int?> goalId;
  final Value<bool> notificationsEnabled;
  final Value<int?> reminderMinutes;
  final Value<bool> snoozeEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const GoalNotificationOverrideCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GoalNotificationOverrideCompanion.insert({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  }) : createdAt = Value(createdAt);
  static Insertable<GoalNotificationOverrideData> custom({
    Expression<int>? id,
    Expression<int>? goalId,
    Expression<bool>? notificationsEnabled,
    Expression<int>? reminderMinutes,
    Expression<bool>? snoozeEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (snoozeEnabled != null) 'snooze_enabled': snoozeEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GoalNotificationOverrideCompanion copyWith(
      {Value<int>? id,
      Value<int?>? goalId,
      Value<bool>? notificationsEnabled,
      Value<int?>? reminderMinutes,
      Value<bool>? snoozeEnabled,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return GoalNotificationOverrideCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (snoozeEnabled.present) {
      map['snooze_enabled'] = Variable<bool>(snoozeEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalNotificationOverrideCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserStatsTable extends UserStats
    with TableInfo<$UserStatsTable, UserStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
      'xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastActiveDateMeta =
      const VerificationMeta('lastActiveDate');
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>('last_active_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _totalTasksCompletedMeta =
      const VerificationMeta('totalTasksCompleted');
  @override
  late final GeneratedColumn<int> totalTasksCompleted = GeneratedColumn<int>(
      'total_tasks_completed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalGoalsCompletedMeta =
      const VerificationMeta('totalGoalsCompleted');
  @override
  late final GeneratedColumn<int> totalGoalsCompleted = GeneratedColumn<int>(
      'total_goals_completed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalTemplatesCreatedMeta =
      const VerificationMeta('totalTemplatesCreated');
  @override
  late final GeneratedColumn<int> totalTemplatesCreated = GeneratedColumn<int>(
      'total_templates_created', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _unlockedThemesMeta =
      const VerificationMeta('unlockedThemes');
  @override
  late final GeneratedColumn<String> unlockedThemes = GeneratedColumn<String>(
      'unlocked_themes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unlockedIconsMeta =
      const VerificationMeta('unlockedIcons');
  @override
  late final GeneratedColumn<String> unlockedIcons = GeneratedColumn<String>(
      'unlocked_icons', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unlockedAnimationsMeta =
      const VerificationMeta('unlockedAnimations');
  @override
  late final GeneratedColumn<String> unlockedAnimations =
      GeneratedColumn<String>('unlocked_animations', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        xp,
        level,
        currentStreak,
        longestStreak,
        lastActiveDate,
        totalTasksCompleted,
        totalGoalsCompleted,
        totalTemplatesCreated,
        unlockedThemes,
        unlockedIcons,
        unlockedAnimations,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_stats';
  @override
  VerificationContext validateIntegrity(Insertable<UserStat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
          _lastActiveDateMeta,
          lastActiveDate.isAcceptableOrUnknown(
              data['last_active_date']!, _lastActiveDateMeta));
    }
    if (data.containsKey('total_tasks_completed')) {
      context.handle(
          _totalTasksCompletedMeta,
          totalTasksCompleted.isAcceptableOrUnknown(
              data['total_tasks_completed']!, _totalTasksCompletedMeta));
    }
    if (data.containsKey('total_goals_completed')) {
      context.handle(
          _totalGoalsCompletedMeta,
          totalGoalsCompleted.isAcceptableOrUnknown(
              data['total_goals_completed']!, _totalGoalsCompletedMeta));
    }
    if (data.containsKey('total_templates_created')) {
      context.handle(
          _totalTemplatesCreatedMeta,
          totalTemplatesCreated.isAcceptableOrUnknown(
              data['total_templates_created']!, _totalTemplatesCreatedMeta));
    }
    if (data.containsKey('unlocked_themes')) {
      context.handle(
          _unlockedThemesMeta,
          unlockedThemes.isAcceptableOrUnknown(
              data['unlocked_themes']!, _unlockedThemesMeta));
    }
    if (data.containsKey('unlocked_icons')) {
      context.handle(
          _unlockedIconsMeta,
          unlockedIcons.isAcceptableOrUnknown(
              data['unlocked_icons']!, _unlockedIconsMeta));
    }
    if (data.containsKey('unlocked_animations')) {
      context.handle(
          _unlockedAnimationsMeta,
          unlockedAnimations.isAcceptableOrUnknown(
              data['unlocked_animations']!, _unlockedAnimationsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      lastActiveDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_active_date']),
      totalTasksCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_tasks_completed'])!,
      totalGoalsCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_goals_completed'])!,
      totalTemplatesCreated: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_templates_created'])!,
      unlockedThemes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unlocked_themes']),
      unlockedIcons: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unlocked_icons']),
      unlockedAnimations: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}unlocked_animations']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $UserStatsTable createAlias(String alias) {
    return $UserStatsTable(attachedDatabase, alias);
  }
}

class UserStat extends DataClass implements Insertable<UserStat> {
  final int id;
  final int xp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActiveDate;
  final int totalTasksCompleted;
  final int totalGoalsCompleted;
  final int totalTemplatesCreated;
  final String? unlockedThemes;
  final String? unlockedIcons;
  final String? unlockedAnimations;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const UserStat(
      {required this.id,
      required this.xp,
      required this.level,
      required this.currentStreak,
      required this.longestStreak,
      this.lastActiveDate,
      required this.totalTasksCompleted,
      required this.totalGoalsCompleted,
      required this.totalTemplatesCreated,
      this.unlockedThemes,
      this.unlockedIcons,
      this.unlockedAnimations,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['xp'] = Variable<int>(xp);
    map['level'] = Variable<int>(level);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    }
    map['total_tasks_completed'] = Variable<int>(totalTasksCompleted);
    map['total_goals_completed'] = Variable<int>(totalGoalsCompleted);
    map['total_templates_created'] = Variable<int>(totalTemplatesCreated);
    if (!nullToAbsent || unlockedThemes != null) {
      map['unlocked_themes'] = Variable<String>(unlockedThemes);
    }
    if (!nullToAbsent || unlockedIcons != null) {
      map['unlocked_icons'] = Variable<String>(unlockedIcons);
    }
    if (!nullToAbsent || unlockedAnimations != null) {
      map['unlocked_animations'] = Variable<String>(unlockedAnimations);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  UserStatsCompanion toCompanion(bool nullToAbsent) {
    return UserStatsCompanion(
      id: Value(id),
      xp: Value(xp),
      level: Value(level),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastActiveDate: lastActiveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDate),
      totalTasksCompleted: Value(totalTasksCompleted),
      totalGoalsCompleted: Value(totalGoalsCompleted),
      totalTemplatesCreated: Value(totalTemplatesCreated),
      unlockedThemes: unlockedThemes == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedThemes),
      unlockedIcons: unlockedIcons == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedIcons),
      unlockedAnimations: unlockedAnimations == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAnimations),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory UserStat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStat(
      id: serializer.fromJson<int>(json['id']),
      xp: serializer.fromJson<int>(json['xp']),
      level: serializer.fromJson<int>(json['level']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastActiveDate: serializer.fromJson<DateTime?>(json['lastActiveDate']),
      totalTasksCompleted:
          serializer.fromJson<int>(json['totalTasksCompleted']),
      totalGoalsCompleted:
          serializer.fromJson<int>(json['totalGoalsCompleted']),
      totalTemplatesCreated:
          serializer.fromJson<int>(json['totalTemplatesCreated']),
      unlockedThemes: serializer.fromJson<String?>(json['unlockedThemes']),
      unlockedIcons: serializer.fromJson<String?>(json['unlockedIcons']),
      unlockedAnimations:
          serializer.fromJson<String?>(json['unlockedAnimations']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'xp': serializer.toJson<int>(xp),
      'level': serializer.toJson<int>(level),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastActiveDate': serializer.toJson<DateTime?>(lastActiveDate),
      'totalTasksCompleted': serializer.toJson<int>(totalTasksCompleted),
      'totalGoalsCompleted': serializer.toJson<int>(totalGoalsCompleted),
      'totalTemplatesCreated': serializer.toJson<int>(totalTemplatesCreated),
      'unlockedThemes': serializer.toJson<String?>(unlockedThemes),
      'unlockedIcons': serializer.toJson<String?>(unlockedIcons),
      'unlockedAnimations': serializer.toJson<String?>(unlockedAnimations),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  UserStat copyWith(
          {int? id,
          int? xp,
          int? level,
          int? currentStreak,
          int? longestStreak,
          Value<DateTime?> lastActiveDate = const Value.absent(),
          int? totalTasksCompleted,
          int? totalGoalsCompleted,
          int? totalTemplatesCreated,
          Value<String?> unlockedThemes = const Value.absent(),
          Value<String?> unlockedIcons = const Value.absent(),
          Value<String?> unlockedAnimations = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      UserStat(
        id: id ?? this.id,
        xp: xp ?? this.xp,
        level: level ?? this.level,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        lastActiveDate:
            lastActiveDate.present ? lastActiveDate.value : this.lastActiveDate,
        totalTasksCompleted: totalTasksCompleted ?? this.totalTasksCompleted,
        totalGoalsCompleted: totalGoalsCompleted ?? this.totalGoalsCompleted,
        totalTemplatesCreated:
            totalTemplatesCreated ?? this.totalTemplatesCreated,
        unlockedThemes:
            unlockedThemes.present ? unlockedThemes.value : this.unlockedThemes,
        unlockedIcons:
            unlockedIcons.present ? unlockedIcons.value : this.unlockedIcons,
        unlockedAnimations: unlockedAnimations.present
            ? unlockedAnimations.value
            : this.unlockedAnimations,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  UserStat copyWithCompanion(UserStatsCompanion data) {
    return UserStat(
      id: data.id.present ? data.id.value : this.id,
      xp: data.xp.present ? data.xp.value : this.xp,
      level: data.level.present ? data.level.value : this.level,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
      totalTasksCompleted: data.totalTasksCompleted.present
          ? data.totalTasksCompleted.value
          : this.totalTasksCompleted,
      totalGoalsCompleted: data.totalGoalsCompleted.present
          ? data.totalGoalsCompleted.value
          : this.totalGoalsCompleted,
      totalTemplatesCreated: data.totalTemplatesCreated.present
          ? data.totalTemplatesCreated.value
          : this.totalTemplatesCreated,
      unlockedThemes: data.unlockedThemes.present
          ? data.unlockedThemes.value
          : this.unlockedThemes,
      unlockedIcons: data.unlockedIcons.present
          ? data.unlockedIcons.value
          : this.unlockedIcons,
      unlockedAnimations: data.unlockedAnimations.present
          ? data.unlockedAnimations.value
          : this.unlockedAnimations,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStat(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('totalTasksCompleted: $totalTasksCompleted, ')
          ..write('totalGoalsCompleted: $totalGoalsCompleted, ')
          ..write('totalTemplatesCreated: $totalTemplatesCreated, ')
          ..write('unlockedThemes: $unlockedThemes, ')
          ..write('unlockedIcons: $unlockedIcons, ')
          ..write('unlockedAnimations: $unlockedAnimations, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      xp,
      level,
      currentStreak,
      longestStreak,
      lastActiveDate,
      totalTasksCompleted,
      totalGoalsCompleted,
      totalTemplatesCreated,
      unlockedThemes,
      unlockedIcons,
      unlockedAnimations,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStat &&
          other.id == this.id &&
          other.xp == this.xp &&
          other.level == this.level &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastActiveDate == this.lastActiveDate &&
          other.totalTasksCompleted == this.totalTasksCompleted &&
          other.totalGoalsCompleted == this.totalGoalsCompleted &&
          other.totalTemplatesCreated == this.totalTemplatesCreated &&
          other.unlockedThemes == this.unlockedThemes &&
          other.unlockedIcons == this.unlockedIcons &&
          other.unlockedAnimations == this.unlockedAnimations &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserStatsCompanion extends UpdateCompanion<UserStat> {
  final Value<int> id;
  final Value<int> xp;
  final Value<int> level;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<DateTime?> lastActiveDate;
  final Value<int> totalTasksCompleted;
  final Value<int> totalGoalsCompleted;
  final Value<int> totalTemplatesCreated;
  final Value<String?> unlockedThemes;
  final Value<String?> unlockedIcons;
  final Value<String?> unlockedAnimations;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const UserStatsCompanion({
    this.id = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.totalTasksCompleted = const Value.absent(),
    this.totalGoalsCompleted = const Value.absent(),
    this.totalTemplatesCreated = const Value.absent(),
    this.unlockedThemes = const Value.absent(),
    this.unlockedIcons = const Value.absent(),
    this.unlockedAnimations = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserStatsCompanion.insert({
    this.id = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.totalTasksCompleted = const Value.absent(),
    this.totalGoalsCompleted = const Value.absent(),
    this.totalTemplatesCreated = const Value.absent(),
    this.unlockedThemes = const Value.absent(),
    this.unlockedIcons = const Value.absent(),
    this.unlockedAnimations = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  }) : createdAt = Value(createdAt);
  static Insertable<UserStat> custom({
    Expression<int>? id,
    Expression<int>? xp,
    Expression<int>? level,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastActiveDate,
    Expression<int>? totalTasksCompleted,
    Expression<int>? totalGoalsCompleted,
    Expression<int>? totalTemplatesCreated,
    Expression<String>? unlockedThemes,
    Expression<String>? unlockedIcons,
    Expression<String>? unlockedAnimations,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (xp != null) 'xp': xp,
      if (level != null) 'level': level,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
      if (totalTasksCompleted != null)
        'total_tasks_completed': totalTasksCompleted,
      if (totalGoalsCompleted != null)
        'total_goals_completed': totalGoalsCompleted,
      if (totalTemplatesCreated != null)
        'total_templates_created': totalTemplatesCreated,
      if (unlockedThemes != null) 'unlocked_themes': unlockedThemes,
      if (unlockedIcons != null) 'unlocked_icons': unlockedIcons,
      if (unlockedAnimations != null) 'unlocked_animations': unlockedAnimations,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserStatsCompanion copyWith(
      {Value<int>? id,
      Value<int>? xp,
      Value<int>? level,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<DateTime?>? lastActiveDate,
      Value<int>? totalTasksCompleted,
      Value<int>? totalGoalsCompleted,
      Value<int>? totalTemplatesCreated,
      Value<String?>? unlockedThemes,
      Value<String?>? unlockedIcons,
      Value<String?>? unlockedAnimations,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return UserStatsCompanion(
      id: id ?? this.id,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      totalTasksCompleted: totalTasksCompleted ?? this.totalTasksCompleted,
      totalGoalsCompleted: totalGoalsCompleted ?? this.totalGoalsCompleted,
      totalTemplatesCreated:
          totalTemplatesCreated ?? this.totalTemplatesCreated,
      unlockedThemes: unlockedThemes ?? this.unlockedThemes,
      unlockedIcons: unlockedIcons ?? this.unlockedIcons,
      unlockedAnimations: unlockedAnimations ?? this.unlockedAnimations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    if (totalTasksCompleted.present) {
      map['total_tasks_completed'] = Variable<int>(totalTasksCompleted.value);
    }
    if (totalGoalsCompleted.present) {
      map['total_goals_completed'] = Variable<int>(totalGoalsCompleted.value);
    }
    if (totalTemplatesCreated.present) {
      map['total_templates_created'] =
          Variable<int>(totalTemplatesCreated.value);
    }
    if (unlockedThemes.present) {
      map['unlocked_themes'] = Variable<String>(unlockedThemes.value);
    }
    if (unlockedIcons.present) {
      map['unlocked_icons'] = Variable<String>(unlockedIcons.value);
    }
    if (unlockedAnimations.present) {
      map['unlocked_animations'] = Variable<String>(unlockedAnimations.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStatsCompanion(')
          ..write('id: $id, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('totalTasksCompleted: $totalTasksCompleted, ')
          ..write('totalGoalsCompleted: $totalGoalsCompleted, ')
          ..write('totalTemplatesCreated: $totalTemplatesCreated, ')
          ..write('unlockedThemes: $unlockedThemes, ')
          ..write('unlockedIcons: $unlockedIcons, ')
          ..write('unlockedAnimations: $unlockedAnimations, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HobbiesTable extends Hobbies with TableInfo<$HobbiesTable, Hobby> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HobbiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('daily'));
  static const VerificationMeta _customFrequencyJsonMeta =
      const VerificationMeta('customFrequencyJson');
  @override
  late final GeneratedColumn<String> customFrequencyJson =
      GeneratedColumn<String>('custom_frequency_json', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _targetDurationMinutesMeta =
      const VerificationMeta('targetDurationMinutes');
  @override
  late final GeneratedColumn<int> targetDurationMinutes = GeneratedColumn<int>(
      'target_duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES goals(id)');
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        category,
        icon,
        color,
        frequency,
        customFrequencyJson,
        targetDurationMinutes,
        goalId,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hobbies';
  @override
  VerificationContext validateIntegrity(Insertable<Hobby> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('custom_frequency_json')) {
      context.handle(
          _customFrequencyJsonMeta,
          customFrequencyJson.isAcceptableOrUnknown(
              data['custom_frequency_json']!, _customFrequencyJsonMeta));
    }
    if (data.containsKey('target_duration_minutes')) {
      context.handle(
          _targetDurationMinutesMeta,
          targetDurationMinutes.isAcceptableOrUnknown(
              data['target_duration_minutes']!, _targetDurationMinutesMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hobby map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hobby(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      customFrequencyJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}custom_frequency_json']),
      targetDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}target_duration_minutes']),
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $HobbiesTable createAlias(String alias) {
    return $HobbiesTable(attachedDatabase, alias);
  }
}

class Hobby extends DataClass implements Insertable<Hobby> {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String frequency;
  final String? customFrequencyJson;
  final int? targetDurationMinutes;
  final int? goalId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Hobby(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      this.icon,
      this.color,
      required this.frequency,
      this.customFrequencyJson,
      this.targetDurationMinutes,
      this.goalId,
      required this.isActive,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<int>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || customFrequencyJson != null) {
      map['custom_frequency_json'] = Variable<String>(customFrequencyJson);
    }
    if (!nullToAbsent || targetDurationMinutes != null) {
      map['target_duration_minutes'] = Variable<int>(targetDurationMinutes);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<int>(goalId);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  HobbiesCompanion toCompanion(bool nullToAbsent) {
    return HobbiesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      frequency: Value(frequency),
      customFrequencyJson: customFrequencyJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customFrequencyJson),
      targetDurationMinutes: targetDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDurationMinutes),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Hobby.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hobby(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      icon: serializer.fromJson<int?>(json['icon']),
      color: serializer.fromJson<int?>(json['color']),
      frequency: serializer.fromJson<String>(json['frequency']),
      customFrequencyJson:
          serializer.fromJson<String?>(json['customFrequencyJson']),
      targetDurationMinutes:
          serializer.fromJson<int?>(json['targetDurationMinutes']),
      goalId: serializer.fromJson<int?>(json['goalId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'icon': serializer.toJson<int?>(icon),
      'color': serializer.toJson<int?>(color),
      'frequency': serializer.toJson<String>(frequency),
      'customFrequencyJson': serializer.toJson<String?>(customFrequencyJson),
      'targetDurationMinutes': serializer.toJson<int?>(targetDurationMinutes),
      'goalId': serializer.toJson<int?>(goalId),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Hobby copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? category,
          Value<int?> icon = const Value.absent(),
          Value<int?> color = const Value.absent(),
          String? frequency,
          Value<String?> customFrequencyJson = const Value.absent(),
          Value<int?> targetDurationMinutes = const Value.absent(),
          Value<int?> goalId = const Value.absent(),
          bool? isActive,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Hobby(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        icon: icon.present ? icon.value : this.icon,
        color: color.present ? color.value : this.color,
        frequency: frequency ?? this.frequency,
        customFrequencyJson: customFrequencyJson.present
            ? customFrequencyJson.value
            : this.customFrequencyJson,
        targetDurationMinutes: targetDurationMinutes.present
            ? targetDurationMinutes.value
            : this.targetDurationMinutes,
        goalId: goalId.present ? goalId.value : this.goalId,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Hobby copyWithCompanion(HobbiesCompanion data) {
    return Hobby(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      customFrequencyJson: data.customFrequencyJson.present
          ? data.customFrequencyJson.value
          : this.customFrequencyJson,
      targetDurationMinutes: data.targetDurationMinutes.present
          ? data.targetDurationMinutes.value
          : this.targetDurationMinutes,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hobby(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('frequency: $frequency, ')
          ..write('customFrequencyJson: $customFrequencyJson, ')
          ..write('targetDurationMinutes: $targetDurationMinutes, ')
          ..write('goalId: $goalId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      category,
      icon,
      color,
      frequency,
      customFrequencyJson,
      targetDurationMinutes,
      goalId,
      isActive,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hobby &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.frequency == this.frequency &&
          other.customFrequencyJson == this.customFrequencyJson &&
          other.targetDurationMinutes == this.targetDurationMinutes &&
          other.goalId == this.goalId &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HobbiesCompanion extends UpdateCompanion<Hobby> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> category;
  final Value<int?> icon;
  final Value<int?> color;
  final Value<String> frequency;
  final Value<String?> customFrequencyJson;
  final Value<int?> targetDurationMinutes;
  final Value<int?> goalId;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const HobbiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.frequency = const Value.absent(),
    this.customFrequencyJson = const Value.absent(),
    this.targetDurationMinutes = const Value.absent(),
    this.goalId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HobbiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String category,
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.frequency = const Value.absent(),
    this.customFrequencyJson = const Value.absent(),
    this.targetDurationMinutes = const Value.absent(),
    this.goalId = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        category = Value(category),
        createdAt = Value(createdAt);
  static Insertable<Hobby> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? icon,
    Expression<int>? color,
    Expression<String>? frequency,
    Expression<String>? customFrequencyJson,
    Expression<int>? targetDurationMinutes,
    Expression<int>? goalId,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (frequency != null) 'frequency': frequency,
      if (customFrequencyJson != null)
        'custom_frequency_json': customFrequencyJson,
      if (targetDurationMinutes != null)
        'target_duration_minutes': targetDurationMinutes,
      if (goalId != null) 'goal_id': goalId,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HobbiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? category,
      Value<int?>? icon,
      Value<int?>? color,
      Value<String>? frequency,
      Value<String?>? customFrequencyJson,
      Value<int?>? targetDurationMinutes,
      Value<int?>? goalId,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return HobbiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      frequency: frequency ?? this.frequency,
      customFrequencyJson: customFrequencyJson ?? this.customFrequencyJson,
      targetDurationMinutes:
          targetDurationMinutes ?? this.targetDurationMinutes,
      goalId: goalId ?? this.goalId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (customFrequencyJson.present) {
      map['custom_frequency_json'] =
          Variable<String>(customFrequencyJson.value);
    }
    if (targetDurationMinutes.present) {
      map['target_duration_minutes'] =
          Variable<int>(targetDurationMinutes.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HobbiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('frequency: $frequency, ')
          ..write('customFrequencyJson: $customFrequencyJson, ')
          ..write('targetDurationMinutes: $targetDurationMinutes, ')
          ..write('goalId: $goalId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HobbySessionsTable extends HobbySessions
    with TableInfo<$HobbySessionsTable, HobbySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HobbySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _hobbyIdMeta =
      const VerificationMeta('hobbyId');
  @override
  late final GeneratedColumn<int> hobbyId = GeneratedColumn<int>(
      'hobby_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES hobbies(id)');
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
      'mood', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        hobbyId,
        startTime,
        endTime,
        durationMinutes,
        mood,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hobby_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<HobbySession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hobby_id')) {
      context.handle(_hobbyIdMeta,
          hobbyId.isAcceptableOrUnknown(data['hobby_id']!, _hobbyIdMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HobbySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HobbySession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hobbyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hobby_id']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes']),
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HobbySessionsTable createAlias(String alias) {
    return $HobbySessionsTable(attachedDatabase, alias);
  }
}

class HobbySession extends DataClass implements Insertable<HobbySession> {
  final int id;
  final int? hobbyId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final int? mood;
  final String? notes;
  final DateTime createdAt;
  const HobbySession(
      {required this.id,
      this.hobbyId,
      required this.startTime,
      this.endTime,
      this.durationMinutes,
      this.mood,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || hobbyId != null) {
      map['hobby_id'] = Variable<int>(hobbyId);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<int>(mood);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HobbySessionsCompanion toCompanion(bool nullToAbsent) {
    return HobbySessionsCompanion(
      id: Value(id),
      hobbyId: hobbyId == null && nullToAbsent
          ? const Value.absent()
          : Value(hobbyId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory HobbySession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HobbySession(
      id: serializer.fromJson<int>(json['id']),
      hobbyId: serializer.fromJson<int?>(json['hobbyId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      mood: serializer.fromJson<int?>(json['mood']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hobbyId': serializer.toJson<int?>(hobbyId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'mood': serializer.toJson<int?>(mood),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HobbySession copyWith(
          {int? id,
          Value<int?> hobbyId = const Value.absent(),
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> durationMinutes = const Value.absent(),
          Value<int?> mood = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      HobbySession(
        id: id ?? this.id,
        hobbyId: hobbyId.present ? hobbyId.value : this.hobbyId,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        durationMinutes: durationMinutes.present
            ? durationMinutes.value
            : this.durationMinutes,
        mood: mood.present ? mood.value : this.mood,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  HobbySession copyWithCompanion(HobbySessionsCompanion data) {
    return HobbySession(
      id: data.id.present ? data.id.value : this.id,
      hobbyId: data.hobbyId.present ? data.hobbyId.value : this.hobbyId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      mood: data.mood.present ? data.mood.value : this.mood,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HobbySession(')
          ..write('id: $id, ')
          ..write('hobbyId: $hobbyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, hobbyId, startTime, endTime, durationMinutes, mood, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HobbySession &&
          other.id == this.id &&
          other.hobbyId == this.hobbyId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationMinutes == this.durationMinutes &&
          other.mood == this.mood &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class HobbySessionsCompanion extends UpdateCompanion<HobbySession> {
  final Value<int> id;
  final Value<int?> hobbyId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationMinutes;
  final Value<int?> mood;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const HobbySessionsCompanion({
    this.id = const Value.absent(),
    this.hobbyId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HobbySessionsCompanion.insert({
    this.id = const Value.absent(),
    this.hobbyId = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
  })  : startTime = Value(startTime),
        createdAt = Value(createdAt);
  static Insertable<HobbySession> custom({
    Expression<int>? id,
    Expression<int>? hobbyId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationMinutes,
    Expression<int>? mood,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hobbyId != null) 'hobby_id': hobbyId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (mood != null) 'mood': mood,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HobbySessionsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? hobbyId,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<int?>? durationMinutes,
      Value<int?>? mood,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return HobbySessionsCompanion(
      id: id ?? this.id,
      hobbyId: hobbyId ?? this.hobbyId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hobbyId.present) {
      map['hobby_id'] = Variable<int>(hobbyId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HobbySessionsCompanion(')
          ..write('id: $id, ')
          ..write('hobbyId: $hobbyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $SubtasksTable subtasks = $SubtasksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TaskTagsTable taskTags = $TaskTagsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  late final $NotificationPrefsTable notificationPrefs =
      $NotificationPrefsTable(this);
  late final $GoalNotificationOverrideTable goalNotificationOverride =
      $GoalNotificationOverrideTable(this);
  late final $UserStatsTable userStats = $UserStatsTable(this);
  late final $HobbiesTable hobbies = $HobbiesTable(this);
  late final $HobbySessionsTable hobbySessions = $HobbySessionsTable(this);
  late final TaskDao taskDao = TaskDao(this as AppDatabase);
  late final TagDao tagDao = TagDao(this as AppDatabase);
  late final UserSettingsDao userSettingsDao =
      UserSettingsDao(this as AppDatabase);
  late final GoalDao goalDao = GoalDao(this as AppDatabase);
  late final TemplateDao templateDao = TemplateDao(this as AppDatabase);
  late final HobbiesDao hobbiesDao = HobbiesDao(this as AppDatabase);
  late final HobbySessionsDao hobbySessionsDao =
      HobbySessionsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        goals,
        tasks,
        subtasks,
        tags,
        taskTags,
        userSettings,
        templates,
        notificationPrefs,
        goalNotificationOverride,
        userStats,
        hobbies,
        hobbySessions
      ];
}

typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<DateTime?> deadline,
  required int color,
  required int icon,
  Value<int?> parentGoalId,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime?> deadline,
  Value<int> color,
  Value<int> icon,
  Value<int?> parentGoalId,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tasks,
          aliasName: $_aliasNameGenerator(db.goals.id, db.tasks.goalId));

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoalNotificationOverrideTable,
      List<GoalNotificationOverrideData>> _goalNotificationOverrideRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.goalNotificationOverride,
          aliasName: $_aliasNameGenerator(
              db.goals.id, db.goalNotificationOverride.goalId));

  $$GoalNotificationOverrideTableProcessedTableManager
      get goalNotificationOverrideRefs {
    final manager = $$GoalNotificationOverrideTableTableManager(
            $_db, $_db.goalNotificationOverride)
        .filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_goalNotificationOverrideRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$HobbiesTable, List<Hobby>> _hobbiesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.hobbies,
          aliasName: $_aliasNameGenerator(db.goals.id, db.hobbies.goalId));

  $$HobbiesTableProcessedTableManager get hobbiesRefs {
    final manager = $$HobbiesTableTableManager($_db, $_db.hobbies)
        .filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_hobbiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentGoalId => $composableBuilder(
      column: $table.parentGoalId, builder: (column) => ColumnFilters(column));

  Expression<bool> tasksRefs(
      Expression<bool> Function($$TasksTableFilterComposer f) f) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goalNotificationOverrideRefs(
      Expression<bool> Function($$GoalNotificationOverrideTableFilterComposer f)
          f) {
    final $$GoalNotificationOverrideTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.goalNotificationOverride,
            getReferencedColumn: (t) => t.goalId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GoalNotificationOverrideTableFilterComposer(
                  $db: $db,
                  $table: $db.goalNotificationOverride,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> hobbiesRefs(
      Expression<bool> Function($$HobbiesTableFilterComposer f) f) {
    final $$HobbiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hobbies,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbiesTableFilterComposer(
              $db: $db,
              $table: $db.hobbies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentGoalId => $composableBuilder(
      column: $table.parentGoalId,
      builder: (column) => ColumnOrderings(column));
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get parentGoalId => $composableBuilder(
      column: $table.parentGoalId, builder: (column) => column);

  Expression<T> tasksRefs<T extends Object>(
      Expression<T> Function($$TasksTableAnnotationComposer a) f) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goalNotificationOverrideRefs<T extends Object>(
      Expression<T> Function(
              $$GoalNotificationOverrideTableAnnotationComposer a)
          f) {
    final $$GoalNotificationOverrideTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.goalNotificationOverride,
            getReferencedColumn: (t) => t.goalId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GoalNotificationOverrideTableAnnotationComposer(
                  $db: $db,
                  $table: $db.goalNotificationOverride,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> hobbiesRefs<T extends Object>(
      Expression<T> Function($$HobbiesTableAnnotationComposer a) f) {
    final $$HobbiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hobbies,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbiesTableAnnotationComposer(
              $db: $db,
              $table: $db.hobbies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function(
        {bool tasksRefs,
        bool goalNotificationOverrideRefs,
        bool hobbiesRefs})> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<int> icon = const Value.absent(),
            Value<int?> parentGoalId = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            name: name,
            description: description,
            deadline: deadline,
            color: color,
            icon: icon,
            parentGoalId: parentGoalId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            required int color,
            required int icon,
            Value<int?> parentGoalId = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            name: name,
            description: description,
            deadline: deadline,
            color: color,
            icon: icon,
            parentGoalId: parentGoalId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GoalsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {tasksRefs = false,
              goalNotificationOverrideRefs = false,
              hobbiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tasksRefs) db.tasks,
                if (goalNotificationOverrideRefs) db.goalNotificationOverride,
                if (hobbiesRefs) db.hobbies
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable, Task>(
                        currentTable: table,
                        referencedTable:
                            $$GoalsTableReferences._tasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0).tasksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items),
                  if (goalNotificationOverrideRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable,
                            GoalNotificationOverrideData>(
                        currentTable: table,
                        referencedTable: $$GoalsTableReferences
                            ._goalNotificationOverrideRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0)
                                .goalNotificationOverrideRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items),
                  if (hobbiesRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable, Hobby>(
                        currentTable: table,
                        referencedTable:
                            $$GoalsTableReferences._hobbiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0).hobbiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function(
        {bool tasksRefs, bool goalNotificationOverrideRefs, bool hobbiesRefs})>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<DateTime?> doneDate,
  Value<int?> priority,
  Value<int?> goalId,
  Value<int?> parentTaskId,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<DateTime?> doneDate,
  Value<int?> priority,
  Value<int?> goalId,
  Value<int?> parentTaskId,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias($_aliasNameGenerator(db.tasks.goalId, db.goals.id));

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<int>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SubtasksTable, List<Subtask>> _subtasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.subtasks,
          aliasName: $_aliasNameGenerator(db.tasks.id, db.subtasks.taskId));

  $$SubtasksTableProcessedTableManager get subtasksRefs {
    final manager = $$SubtasksTableTableManager($_db, $_db.subtasks)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subtasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TaskTagsTable, List<TaskTag>> _taskTagsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.taskTags,
          aliasName: $_aliasNameGenerator(db.tasks.id, db.taskTags.taskId));

  $$TaskTagsTableProcessedTableManager get taskTagsRefs {
    final manager = $$TaskTagsTableTableManager($_db, $_db.taskTags)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskTagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get doneDate => $composableBuilder(
      column: $table.doneDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parentTaskId => $composableBuilder(
      column: $table.parentTaskId, builder: (column) => ColumnFilters(column));

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> subtasksRefs(
      Expression<bool> Function($$SubtasksTableFilterComposer f) f) {
    final $$SubtasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.subtasks,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubtasksTableFilterComposer(
              $db: $db,
              $table: $db.subtasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> taskTagsRefs(
      Expression<bool> Function($$TaskTagsTableFilterComposer f) f) {
    final $$TaskTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTags,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTagsTableFilterComposer(
              $db: $db,
              $table: $db.taskTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get doneDate => $composableBuilder(
      column: $table.doneDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parentTaskId => $composableBuilder(
      column: $table.parentTaskId,
      builder: (column) => ColumnOrderings(column));

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get doneDate =>
      $composableBuilder(column: $table.doneDate, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get parentTaskId => $composableBuilder(
      column: $table.parentTaskId, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> subtasksRefs<T extends Object>(
      Expression<T> Function($$SubtasksTableAnnotationComposer a) f) {
    final $$SubtasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.subtasks,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubtasksTableAnnotationComposer(
              $db: $db,
              $table: $db.subtasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> taskTagsRefs<T extends Object>(
      Expression<T> Function($$TaskTagsTableAnnotationComposer a) f) {
    final $$TaskTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTags,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.taskTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function(
        {bool goalId, bool subtasksRefs, bool taskTagsRefs})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<DateTime?> doneDate = const Value.absent(),
            Value<int?> priority = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<int?> parentTaskId = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            doneDate: doneDate,
            priority: priority,
            goalId: goalId,
            parentTaskId: parentTaskId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<DateTime?> doneDate = const Value.absent(),
            Value<int?> priority = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<int?> parentTaskId = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            doneDate: doneDate,
            priority: priority,
            goalId: goalId,
            parentTaskId: parentTaskId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {goalId = false, subtasksRefs = false, taskTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (subtasksRefs) db.subtasks,
                if (taskTagsRefs) db.taskTags
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable: $$TasksTableReferences._goalIdTable(db),
                    referencedColumn:
                        $$TasksTableReferences._goalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (subtasksRefs)
                    await $_getPrefetchedData<Task, $TasksTable, Subtask>(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._subtasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0).subtasksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items),
                  if (taskTagsRefs)
                    await $_getPrefetchedData<Task, $TasksTable, TaskTag>(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._taskTagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0).taskTagsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function(
        {bool goalId, bool subtasksRefs, bool taskTagsRefs})>;
typedef $$SubtasksTableCreateCompanionBuilder = SubtasksCompanion Function({
  Value<int> id,
  Value<int?> taskId,
  required String title,
  Value<bool> completed,
});
typedef $$SubtasksTableUpdateCompanionBuilder = SubtasksCompanion Function({
  Value<int> id,
  Value<int?> taskId,
  Value<String> title,
  Value<bool> completed,
});

final class $$SubtasksTableReferences
    extends BaseReferences<_$AppDatabase, $SubtasksTable, Subtask> {
  $$SubtasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.subtasks.taskId, db.tasks.id));

  $$TasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<int>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SubtasksTableFilterComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubtasksTableOrderingComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubtasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubtasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubtasksTable,
    Subtask,
    $$SubtasksTableFilterComposer,
    $$SubtasksTableOrderingComposer,
    $$SubtasksTableAnnotationComposer,
    $$SubtasksTableCreateCompanionBuilder,
    $$SubtasksTableUpdateCompanionBuilder,
    (Subtask, $$SubtasksTableReferences),
    Subtask,
    PrefetchHooks Function({bool taskId})> {
  $$SubtasksTableTableManager(_$AppDatabase db, $SubtasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubtasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubtasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubtasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> taskId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> completed = const Value.absent(),
          }) =>
              SubtasksCompanion(
            id: id,
            taskId: taskId,
            title: title,
            completed: completed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> taskId = const Value.absent(),
            required String title,
            Value<bool> completed = const Value.absent(),
          }) =>
              SubtasksCompanion.insert(
            id: id,
            taskId: taskId,
            title: title,
            completed: completed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SubtasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable: $$SubtasksTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$SubtasksTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SubtasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SubtasksTable,
    Subtask,
    $$SubtasksTableFilterComposer,
    $$SubtasksTableOrderingComposer,
    $$SubtasksTableAnnotationComposer,
    $$SubtasksTableCreateCompanionBuilder,
    $$SubtasksTableUpdateCompanionBuilder,
    (Subtask, $$SubtasksTableReferences),
    Subtask,
    PrefetchHooks Function({bool taskId})>;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskTagsTable, List<TaskTag>> _taskTagsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.taskTags,
          aliasName: $_aliasNameGenerator(db.tags.id, db.taskTags.tagId));

  $$TaskTagsTableProcessedTableManager get taskTagsRefs {
    final manager = $$TaskTagsTableTableManager($_db, $_db.taskTags)
        .filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskTagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> taskTagsRefs(
      Expression<bool> Function($$TaskTagsTableFilterComposer f) f) {
    final $$TaskTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTagsTableFilterComposer(
              $db: $db,
              $table: $db.taskTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> taskTagsRefs<T extends Object>(
      Expression<T> Function($$TaskTagsTableAnnotationComposer a) f) {
    final $$TaskTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.taskTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, $$TagsTableReferences),
    Tag,
    PrefetchHooks Function({bool taskTagsRefs})> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              TagsCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TagsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({taskTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (taskTagsRefs) db.taskTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, TaskTag>(
                        currentTable: table,
                        referencedTable:
                            $$TagsTableReferences._taskTagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagsTableReferences(db, table, p0).taskTagsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, $$TagsTableReferences),
    Tag,
    PrefetchHooks Function({bool taskTagsRefs})>;
typedef $$TaskTagsTableCreateCompanionBuilder = TaskTagsCompanion Function({
  Value<int?> taskId,
  Value<int?> tagId,
  Value<int> rowid,
});
typedef $$TaskTagsTableUpdateCompanionBuilder = TaskTagsCompanion Function({
  Value<int?> taskId,
  Value<int?> tagId,
  Value<int> rowid,
});

final class $$TaskTagsTableReferences
    extends BaseReferences<_$AppDatabase, $TaskTagsTable, TaskTag> {
  $$TaskTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.taskTags.taskId, db.tasks.id));

  $$TasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<int>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.taskTags.tagId, db.tags.id));

  $$TagsTableProcessedTableManager? get tagId {
    final $_column = $_itemColumn<int>('tag_id');
    if ($_column == null) return null;
    final manager = $$TagsTableTableManager($_db, $_db.tags)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TaskTagsTableFilterComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableFilterComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableOrderingComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableAnnotationComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskTagsTable,
    TaskTag,
    $$TaskTagsTableFilterComposer,
    $$TaskTagsTableOrderingComposer,
    $$TaskTagsTableAnnotationComposer,
    $$TaskTagsTableCreateCompanionBuilder,
    $$TaskTagsTableUpdateCompanionBuilder,
    (TaskTag, $$TaskTagsTableReferences),
    TaskTag,
    PrefetchHooks Function({bool taskId, bool tagId})> {
  $$TaskTagsTableTableManager(_$AppDatabase db, $TaskTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> taskId = const Value.absent(),
            Value<int?> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskTagsCompanion(
            taskId: taskId,
            tagId: tagId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<int?> taskId = const Value.absent(),
            Value<int?> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskTagsCompanion.insert(
            taskId: taskId,
            tagId: tagId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TaskTagsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({taskId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable: $$TaskTagsTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$TaskTagsTableReferences._taskIdTable(db).id,
                  ) as T;
                }
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable: $$TaskTagsTableReferences._tagIdTable(db),
                    referencedColumn:
                        $$TaskTagsTableReferences._tagIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TaskTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskTagsTable,
    TaskTag,
    $$TaskTagsTableFilterComposer,
    $$TaskTagsTableOrderingComposer,
    $$TaskTagsTableAnnotationComposer,
    $$TaskTagsTableCreateCompanionBuilder,
    $$TaskTagsTableUpdateCompanionBuilder,
    (TaskTag, $$TaskTagsTableReferences),
    TaskTag,
    PrefetchHooks Function({bool taskId, bool tagId})>;
typedef $$UserSettingsTableCreateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<String?> theme,
});
typedef $$UserSettingsTableUpdateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<String?> theme,
});

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnFilters(column));
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnOrderings(column));
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);
}

class $$UserSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSettingsTable,
    UserSetting,
    $$UserSettingsTableFilterComposer,
    $$UserSettingsTableOrderingComposer,
    $$UserSettingsTableAnnotationComposer,
    $$UserSettingsTableCreateCompanionBuilder,
    $$UserSettingsTableUpdateCompanionBuilder,
    (
      UserSetting,
      BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>
    ),
    UserSetting,
    PrefetchHooks Function()> {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String?> theme = const Value.absent(),
          }) =>
              UserSettingsCompanion(
            id: id,
            notificationsEnabled: notificationsEnabled,
            theme: theme,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String?> theme = const Value.absent(),
          }) =>
              UserSettingsCompanion.insert(
            id: id,
            notificationsEnabled: notificationsEnabled,
            theme: theme,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSettingsTable,
    UserSetting,
    $$UserSettingsTableFilterComposer,
    $$UserSettingsTableOrderingComposer,
    $$UserSettingsTableAnnotationComposer,
    $$UserSettingsTableCreateCompanionBuilder,
    $$UserSettingsTableUpdateCompanionBuilder,
    (
      UserSetting,
      BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>
    ),
    UserSetting,
    PrefetchHooks Function()>;
typedef $$TemplatesTableCreateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required String category,
  Value<int?> icon,
  Value<int?> color,
  required String payloadJson,
  Value<bool> isBuiltin,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$TemplatesTableUpdateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String> category,
  Value<int?> icon,
  Value<int?> color,
  Value<String> payloadJson,
  Value<bool> isBuiltin,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
      column: $table.isBuiltin, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
      column: $table.isBuiltin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$AppDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()> {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int?> icon = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<bool> isBuiltin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              TemplatesCompanion(
            id: id,
            name: name,
            description: description,
            category: category,
            icon: icon,
            color: color,
            payloadJson: payloadJson,
            isBuiltin: isBuiltin,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required String category,
            Value<int?> icon = const Value.absent(),
            Value<int?> color = const Value.absent(),
            required String payloadJson,
            Value<bool> isBuiltin = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              TemplatesCompanion.insert(
            id: id,
            name: name,
            description: description,
            category: category,
            icon: icon,
            color: color,
            payloadJson: payloadJson,
            isBuiltin: isBuiltin,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$AppDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()>;
typedef $$NotificationPrefsTableCreateCompanionBuilder
    = NotificationPrefsCompanion Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<int> defaultReminderMinutes,
  Value<bool> snoozeEnabled,
  Value<String> snoozePresets,
  Value<bool> quietHoursEnabled,
  Value<String> quietHoursStart,
  Value<String> quietHoursEnd,
  Value<String> workingDays,
  Value<bool> goalOverrideEnabled,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$NotificationPrefsTableUpdateCompanionBuilder
    = NotificationPrefsCompanion Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<int> defaultReminderMinutes,
  Value<bool> snoozeEnabled,
  Value<String> snoozePresets,
  Value<bool> quietHoursEnabled,
  Value<String> quietHoursStart,
  Value<String> quietHoursEnd,
  Value<String> workingDays,
  Value<bool> goalOverrideEnabled,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$NotificationPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultReminderMinutes => $composableBuilder(
      column: $table.defaultReminderMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get snoozePresets => $composableBuilder(
      column: $table.snoozePresets, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get quietHoursEnabled => $composableBuilder(
      column: $table.quietHoursEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quietHoursStart => $composableBuilder(
      column: $table.quietHoursStart,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quietHoursEnd => $composableBuilder(
      column: $table.quietHoursEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workingDays => $composableBuilder(
      column: $table.workingDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get goalOverrideEnabled => $composableBuilder(
      column: $table.goalOverrideEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultReminderMinutes => $composableBuilder(
      column: $table.defaultReminderMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get snoozePresets => $composableBuilder(
      column: $table.snoozePresets,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get quietHoursEnabled => $composableBuilder(
      column: $table.quietHoursEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quietHoursStart => $composableBuilder(
      column: $table.quietHoursStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quietHoursEnd => $composableBuilder(
      column: $table.quietHoursEnd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workingDays => $composableBuilder(
      column: $table.workingDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get goalOverrideEnabled => $composableBuilder(
      column: $table.goalOverrideEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<int> get defaultReminderMinutes => $composableBuilder(
      column: $table.defaultReminderMinutes, builder: (column) => column);

  GeneratedColumn<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled, builder: (column) => column);

  GeneratedColumn<String> get snoozePresets => $composableBuilder(
      column: $table.snoozePresets, builder: (column) => column);

  GeneratedColumn<bool> get quietHoursEnabled => $composableBuilder(
      column: $table.quietHoursEnabled, builder: (column) => column);

  GeneratedColumn<String> get quietHoursStart => $composableBuilder(
      column: $table.quietHoursStart, builder: (column) => column);

  GeneratedColumn<String> get quietHoursEnd => $composableBuilder(
      column: $table.quietHoursEnd, builder: (column) => column);

  GeneratedColumn<String> get workingDays => $composableBuilder(
      column: $table.workingDays, builder: (column) => column);

  GeneratedColumn<bool> get goalOverrideEnabled => $composableBuilder(
      column: $table.goalOverrideEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPrefsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationPrefsTable,
    NotificationPref,
    $$NotificationPrefsTableFilterComposer,
    $$NotificationPrefsTableOrderingComposer,
    $$NotificationPrefsTableAnnotationComposer,
    $$NotificationPrefsTableCreateCompanionBuilder,
    $$NotificationPrefsTableUpdateCompanionBuilder,
    (
      NotificationPref,
      BaseReferences<_$AppDatabase, $NotificationPrefsTable, NotificationPref>
    ),
    NotificationPref,
    PrefetchHooks Function()> {
  $$NotificationPrefsTableTableManager(
      _$AppDatabase db, $NotificationPrefsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationPrefsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int> defaultReminderMinutes = const Value.absent(),
            Value<bool> snoozeEnabled = const Value.absent(),
            Value<String> snoozePresets = const Value.absent(),
            Value<bool> quietHoursEnabled = const Value.absent(),
            Value<String> quietHoursStart = const Value.absent(),
            Value<String> quietHoursEnd = const Value.absent(),
            Value<String> workingDays = const Value.absent(),
            Value<bool> goalOverrideEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              NotificationPrefsCompanion(
            id: id,
            notificationsEnabled: notificationsEnabled,
            defaultReminderMinutes: defaultReminderMinutes,
            snoozeEnabled: snoozeEnabled,
            snoozePresets: snoozePresets,
            quietHoursEnabled: quietHoursEnabled,
            quietHoursStart: quietHoursStart,
            quietHoursEnd: quietHoursEnd,
            workingDays: workingDays,
            goalOverrideEnabled: goalOverrideEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int> defaultReminderMinutes = const Value.absent(),
            Value<bool> snoozeEnabled = const Value.absent(),
            Value<String> snoozePresets = const Value.absent(),
            Value<bool> quietHoursEnabled = const Value.absent(),
            Value<String> quietHoursStart = const Value.absent(),
            Value<String> quietHoursEnd = const Value.absent(),
            Value<String> workingDays = const Value.absent(),
            Value<bool> goalOverrideEnabled = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              NotificationPrefsCompanion.insert(
            id: id,
            notificationsEnabled: notificationsEnabled,
            defaultReminderMinutes: defaultReminderMinutes,
            snoozeEnabled: snoozeEnabled,
            snoozePresets: snoozePresets,
            quietHoursEnabled: quietHoursEnabled,
            quietHoursStart: quietHoursStart,
            quietHoursEnd: quietHoursEnd,
            workingDays: workingDays,
            goalOverrideEnabled: goalOverrideEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationPrefsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationPrefsTable,
    NotificationPref,
    $$NotificationPrefsTableFilterComposer,
    $$NotificationPrefsTableOrderingComposer,
    $$NotificationPrefsTableAnnotationComposer,
    $$NotificationPrefsTableCreateCompanionBuilder,
    $$NotificationPrefsTableUpdateCompanionBuilder,
    (
      NotificationPref,
      BaseReferences<_$AppDatabase, $NotificationPrefsTable, NotificationPref>
    ),
    NotificationPref,
    PrefetchHooks Function()>;
typedef $$GoalNotificationOverrideTableCreateCompanionBuilder
    = GoalNotificationOverrideCompanion Function({
  Value<int> id,
  Value<int?> goalId,
  Value<bool> notificationsEnabled,
  Value<int?> reminderMinutes,
  Value<bool> snoozeEnabled,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$GoalNotificationOverrideTableUpdateCompanionBuilder
    = GoalNotificationOverrideCompanion Function({
  Value<int> id,
  Value<int?> goalId,
  Value<bool> notificationsEnabled,
  Value<int?> reminderMinutes,
  Value<bool> snoozeEnabled,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$GoalNotificationOverrideTableReferences extends BaseReferences<
    _$AppDatabase,
    $GoalNotificationOverrideTable,
    GoalNotificationOverrideData> {
  $$GoalNotificationOverrideTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) => db.goals.createAlias(
      $_aliasNameGenerator(db.goalNotificationOverride.goalId, db.goals.id));

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<int>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GoalNotificationOverrideTableFilterComposer
    extends Composer<_$AppDatabase, $GoalNotificationOverrideTable> {
  $$GoalNotificationOverrideTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
      column: $table.reminderMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalNotificationOverrideTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalNotificationOverrideTable> {
  $$GoalNotificationOverrideTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
      column: $table.reminderMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalNotificationOverrideTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalNotificationOverrideTable> {
  $$GoalNotificationOverrideTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
      column: $table.reminderMinutes, builder: (column) => column);

  GeneratedColumn<bool> get snoozeEnabled => $composableBuilder(
      column: $table.snoozeEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalNotificationOverrideTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalNotificationOverrideTable,
    GoalNotificationOverrideData,
    $$GoalNotificationOverrideTableFilterComposer,
    $$GoalNotificationOverrideTableOrderingComposer,
    $$GoalNotificationOverrideTableAnnotationComposer,
    $$GoalNotificationOverrideTableCreateCompanionBuilder,
    $$GoalNotificationOverrideTableUpdateCompanionBuilder,
    (GoalNotificationOverrideData, $$GoalNotificationOverrideTableReferences),
    GoalNotificationOverrideData,
    PrefetchHooks Function({bool goalId})> {
  $$GoalNotificationOverrideTableTableManager(
      _$AppDatabase db, $GoalNotificationOverrideTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalNotificationOverrideTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalNotificationOverrideTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalNotificationOverrideTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int?> reminderMinutes = const Value.absent(),
            Value<bool> snoozeEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              GoalNotificationOverrideCompanion(
            id: id,
            goalId: goalId,
            notificationsEnabled: notificationsEnabled,
            reminderMinutes: reminderMinutes,
            snoozeEnabled: snoozeEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int?> reminderMinutes = const Value.absent(),
            Value<bool> snoozeEnabled = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              GoalNotificationOverrideCompanion.insert(
            id: id,
            goalId: goalId,
            notificationsEnabled: notificationsEnabled,
            reminderMinutes: reminderMinutes,
            snoozeEnabled: snoozeEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoalNotificationOverrideTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable: $$GoalNotificationOverrideTableReferences
                        ._goalIdTable(db),
                    referencedColumn: $$GoalNotificationOverrideTableReferences
                        ._goalIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GoalNotificationOverrideTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $GoalNotificationOverrideTable,
        GoalNotificationOverrideData,
        $$GoalNotificationOverrideTableFilterComposer,
        $$GoalNotificationOverrideTableOrderingComposer,
        $$GoalNotificationOverrideTableAnnotationComposer,
        $$GoalNotificationOverrideTableCreateCompanionBuilder,
        $$GoalNotificationOverrideTableUpdateCompanionBuilder,
        (
          GoalNotificationOverrideData,
          $$GoalNotificationOverrideTableReferences
        ),
        GoalNotificationOverrideData,
        PrefetchHooks Function({bool goalId})>;
typedef $$UserStatsTableCreateCompanionBuilder = UserStatsCompanion Function({
  Value<int> id,
  Value<int> xp,
  Value<int> level,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<DateTime?> lastActiveDate,
  Value<int> totalTasksCompleted,
  Value<int> totalGoalsCompleted,
  Value<int> totalTemplatesCreated,
  Value<String?> unlockedThemes,
  Value<String?> unlockedIcons,
  Value<String?> unlockedAnimations,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$UserStatsTableUpdateCompanionBuilder = UserStatsCompanion Function({
  Value<int> id,
  Value<int> xp,
  Value<int> level,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<DateTime?> lastActiveDate,
  Value<int> totalTasksCompleted,
  Value<int> totalGoalsCompleted,
  Value<int> totalTemplatesCreated,
  Value<String?> unlockedThemes,
  Value<String?> unlockedIcons,
  Value<String?> unlockedAnimations,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$UserStatsTableFilterComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
      column: $table.lastActiveDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTasksCompleted => $composableBuilder(
      column: $table.totalTasksCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalGoalsCompleted => $composableBuilder(
      column: $table.totalGoalsCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTemplatesCreated => $composableBuilder(
      column: $table.totalTemplatesCreated,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockedThemes => $composableBuilder(
      column: $table.unlockedThemes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockedIcons => $composableBuilder(
      column: $table.unlockedIcons, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockedAnimations => $composableBuilder(
      column: $table.unlockedAnimations,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
      column: $table.lastActiveDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTasksCompleted => $composableBuilder(
      column: $table.totalTasksCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalGoalsCompleted => $composableBuilder(
      column: $table.totalGoalsCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTemplatesCreated => $composableBuilder(
      column: $table.totalTemplatesCreated,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockedThemes => $composableBuilder(
      column: $table.unlockedThemes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockedIcons => $composableBuilder(
      column: $table.unlockedIcons,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockedAnimations => $composableBuilder(
      column: $table.unlockedAnimations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
      column: $table.lastActiveDate, builder: (column) => column);

  GeneratedColumn<int> get totalTasksCompleted => $composableBuilder(
      column: $table.totalTasksCompleted, builder: (column) => column);

  GeneratedColumn<int> get totalGoalsCompleted => $composableBuilder(
      column: $table.totalGoalsCompleted, builder: (column) => column);

  GeneratedColumn<int> get totalTemplatesCreated => $composableBuilder(
      column: $table.totalTemplatesCreated, builder: (column) => column);

  GeneratedColumn<String> get unlockedThemes => $composableBuilder(
      column: $table.unlockedThemes, builder: (column) => column);

  GeneratedColumn<String> get unlockedIcons => $composableBuilder(
      column: $table.unlockedIcons, builder: (column) => column);

  GeneratedColumn<String> get unlockedAnimations => $composableBuilder(
      column: $table.unlockedAnimations, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserStatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserStatsTable,
    UserStat,
    $$UserStatsTableFilterComposer,
    $$UserStatsTableOrderingComposer,
    $$UserStatsTableAnnotationComposer,
    $$UserStatsTableCreateCompanionBuilder,
    $$UserStatsTableUpdateCompanionBuilder,
    (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
    UserStat,
    PrefetchHooks Function()> {
  $$UserStatsTableTableManager(_$AppDatabase db, $UserStatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<DateTime?> lastActiveDate = const Value.absent(),
            Value<int> totalTasksCompleted = const Value.absent(),
            Value<int> totalGoalsCompleted = const Value.absent(),
            Value<int> totalTemplatesCreated = const Value.absent(),
            Value<String?> unlockedThemes = const Value.absent(),
            Value<String?> unlockedIcons = const Value.absent(),
            Value<String?> unlockedAnimations = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              UserStatsCompanion(
            id: id,
            xp: xp,
            level: level,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            lastActiveDate: lastActiveDate,
            totalTasksCompleted: totalTasksCompleted,
            totalGoalsCompleted: totalGoalsCompleted,
            totalTemplatesCreated: totalTemplatesCreated,
            unlockedThemes: unlockedThemes,
            unlockedIcons: unlockedIcons,
            unlockedAnimations: unlockedAnimations,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<DateTime?> lastActiveDate = const Value.absent(),
            Value<int> totalTasksCompleted = const Value.absent(),
            Value<int> totalGoalsCompleted = const Value.absent(),
            Value<int> totalTemplatesCreated = const Value.absent(),
            Value<String?> unlockedThemes = const Value.absent(),
            Value<String?> unlockedIcons = const Value.absent(),
            Value<String?> unlockedAnimations = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              UserStatsCompanion.insert(
            id: id,
            xp: xp,
            level: level,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            lastActiveDate: lastActiveDate,
            totalTasksCompleted: totalTasksCompleted,
            totalGoalsCompleted: totalGoalsCompleted,
            totalTemplatesCreated: totalTemplatesCreated,
            unlockedThemes: unlockedThemes,
            unlockedIcons: unlockedIcons,
            unlockedAnimations: unlockedAnimations,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserStatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserStatsTable,
    UserStat,
    $$UserStatsTableFilterComposer,
    $$UserStatsTableOrderingComposer,
    $$UserStatsTableAnnotationComposer,
    $$UserStatsTableCreateCompanionBuilder,
    $$UserStatsTableUpdateCompanionBuilder,
    (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
    UserStat,
    PrefetchHooks Function()>;
typedef $$HobbiesTableCreateCompanionBuilder = HobbiesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required String category,
  Value<int?> icon,
  Value<int?> color,
  Value<String> frequency,
  Value<String?> customFrequencyJson,
  Value<int?> targetDurationMinutes,
  Value<int?> goalId,
  Value<bool> isActive,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$HobbiesTableUpdateCompanionBuilder = HobbiesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String> category,
  Value<int?> icon,
  Value<int?> color,
  Value<String> frequency,
  Value<String?> customFrequencyJson,
  Value<int?> targetDurationMinutes,
  Value<int?> goalId,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$HobbiesTableReferences
    extends BaseReferences<_$AppDatabase, $HobbiesTable, Hobby> {
  $$HobbiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) => db.goals
      .createAlias($_aliasNameGenerator(db.hobbies.goalId, db.goals.id));

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<int>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$HobbySessionsTable, List<HobbySession>>
      _hobbySessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.hobbySessions,
              aliasName: $_aliasNameGenerator(
                  db.hobbies.id, db.hobbySessions.hobbyId));

  $$HobbySessionsTableProcessedTableManager get hobbySessionsRefs {
    final manager = $$HobbySessionsTableTableManager($_db, $_db.hobbySessions)
        .filter((f) => f.hobbyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_hobbySessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HobbiesTableFilterComposer
    extends Composer<_$AppDatabase, $HobbiesTable> {
  $$HobbiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customFrequencyJson => $composableBuilder(
      column: $table.customFrequencyJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> hobbySessionsRefs(
      Expression<bool> Function($$HobbySessionsTableFilterComposer f) f) {
    final $$HobbySessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hobbySessions,
        getReferencedColumn: (t) => t.hobbyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbySessionsTableFilterComposer(
              $db: $db,
              $table: $db.hobbySessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HobbiesTableOrderingComposer
    extends Composer<_$AppDatabase, $HobbiesTable> {
  $$HobbiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customFrequencyJson => $composableBuilder(
      column: $table.customFrequencyJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HobbiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HobbiesTable> {
  $$HobbiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get customFrequencyJson => $composableBuilder(
      column: $table.customFrequencyJson, builder: (column) => column);

  GeneratedColumn<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> hobbySessionsRefs<T extends Object>(
      Expression<T> Function($$HobbySessionsTableAnnotationComposer a) f) {
    final $$HobbySessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hobbySessions,
        getReferencedColumn: (t) => t.hobbyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbySessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.hobbySessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HobbiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HobbiesTable,
    Hobby,
    $$HobbiesTableFilterComposer,
    $$HobbiesTableOrderingComposer,
    $$HobbiesTableAnnotationComposer,
    $$HobbiesTableCreateCompanionBuilder,
    $$HobbiesTableUpdateCompanionBuilder,
    (Hobby, $$HobbiesTableReferences),
    Hobby,
    PrefetchHooks Function({bool goalId, bool hobbySessionsRefs})> {
  $$HobbiesTableTableManager(_$AppDatabase db, $HobbiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HobbiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HobbiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HobbiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int?> icon = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String?> customFrequencyJson = const Value.absent(),
            Value<int?> targetDurationMinutes = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              HobbiesCompanion(
            id: id,
            name: name,
            description: description,
            category: category,
            icon: icon,
            color: color,
            frequency: frequency,
            customFrequencyJson: customFrequencyJson,
            targetDurationMinutes: targetDurationMinutes,
            goalId: goalId,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required String category,
            Value<int?> icon = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String?> customFrequencyJson = const Value.absent(),
            Value<int?> targetDurationMinutes = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              HobbiesCompanion.insert(
            id: id,
            name: name,
            description: description,
            category: category,
            icon: icon,
            color: color,
            frequency: frequency,
            customFrequencyJson: customFrequencyJson,
            targetDurationMinutes: targetDurationMinutes,
            goalId: goalId,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$HobbiesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({goalId = false, hobbySessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (hobbySessionsRefs) db.hobbySessions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable: $$HobbiesTableReferences._goalIdTable(db),
                    referencedColumn:
                        $$HobbiesTableReferences._goalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hobbySessionsRefs)
                    await $_getPrefetchedData<Hobby, $HobbiesTable,
                            HobbySession>(
                        currentTable: table,
                        referencedTable: $$HobbiesTableReferences
                            ._hobbySessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HobbiesTableReferences(db, table, p0)
                                .hobbySessionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.hobbyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HobbiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HobbiesTable,
    Hobby,
    $$HobbiesTableFilterComposer,
    $$HobbiesTableOrderingComposer,
    $$HobbiesTableAnnotationComposer,
    $$HobbiesTableCreateCompanionBuilder,
    $$HobbiesTableUpdateCompanionBuilder,
    (Hobby, $$HobbiesTableReferences),
    Hobby,
    PrefetchHooks Function({bool goalId, bool hobbySessionsRefs})>;
typedef $$HobbySessionsTableCreateCompanionBuilder = HobbySessionsCompanion
    Function({
  Value<int> id,
  Value<int?> hobbyId,
  required DateTime startTime,
  Value<DateTime?> endTime,
  Value<int?> durationMinutes,
  Value<int?> mood,
  Value<String?> notes,
  required DateTime createdAt,
});
typedef $$HobbySessionsTableUpdateCompanionBuilder = HobbySessionsCompanion
    Function({
  Value<int> id,
  Value<int?> hobbyId,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<int?> durationMinutes,
  Value<int?> mood,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$HobbySessionsTableReferences
    extends BaseReferences<_$AppDatabase, $HobbySessionsTable, HobbySession> {
  $$HobbySessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $HobbiesTable _hobbyIdTable(_$AppDatabase db) =>
      db.hobbies.createAlias(
          $_aliasNameGenerator(db.hobbySessions.hobbyId, db.hobbies.id));

  $$HobbiesTableProcessedTableManager? get hobbyId {
    final $_column = $_itemColumn<int>('hobby_id');
    if ($_column == null) return null;
    final manager = $$HobbiesTableTableManager($_db, $_db.hobbies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hobbyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HobbySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $HobbySessionsTable> {
  $$HobbySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$HobbiesTableFilterComposer get hobbyId {
    final $$HobbiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hobbyId,
        referencedTable: $db.hobbies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbiesTableFilterComposer(
              $db: $db,
              $table: $db.hobbies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HobbySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HobbySessionsTable> {
  $$HobbySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$HobbiesTableOrderingComposer get hobbyId {
    final $$HobbiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hobbyId,
        referencedTable: $db.hobbies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbiesTableOrderingComposer(
              $db: $db,
              $table: $db.hobbies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HobbySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HobbySessionsTable> {
  $$HobbySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HobbiesTableAnnotationComposer get hobbyId {
    final $$HobbiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hobbyId,
        referencedTable: $db.hobbies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HobbiesTableAnnotationComposer(
              $db: $db,
              $table: $db.hobbies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HobbySessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HobbySessionsTable,
    HobbySession,
    $$HobbySessionsTableFilterComposer,
    $$HobbySessionsTableOrderingComposer,
    $$HobbySessionsTableAnnotationComposer,
    $$HobbySessionsTableCreateCompanionBuilder,
    $$HobbySessionsTableUpdateCompanionBuilder,
    (HobbySession, $$HobbySessionsTableReferences),
    HobbySession,
    PrefetchHooks Function({bool hobbyId})> {
  $$HobbySessionsTableTableManager(_$AppDatabase db, $HobbySessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HobbySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HobbySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HobbySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> hobbyId = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HobbySessionsCompanion(
            id: id,
            hobbyId: hobbyId,
            startTime: startTime,
            endTime: endTime,
            durationMinutes: durationMinutes,
            mood: mood,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> hobbyId = const Value.absent(),
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
          }) =>
              HobbySessionsCompanion.insert(
            id: id,
            hobbyId: hobbyId,
            startTime: startTime,
            endTime: endTime,
            durationMinutes: durationMinutes,
            mood: mood,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HobbySessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hobbyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (hobbyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.hobbyId,
                    referencedTable:
                        $$HobbySessionsTableReferences._hobbyIdTable(db),
                    referencedColumn:
                        $$HobbySessionsTableReferences._hobbyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HobbySessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HobbySessionsTable,
    HobbySession,
    $$HobbySessionsTableFilterComposer,
    $$HobbySessionsTableOrderingComposer,
    $$HobbySessionsTableAnnotationComposer,
    $$HobbySessionsTableCreateCompanionBuilder,
    $$HobbySessionsTableUpdateCompanionBuilder,
    (HobbySession, $$HobbySessionsTableReferences),
    HobbySession,
    PrefetchHooks Function({bool hobbyId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$SubtasksTableTableManager get subtasks =>
      $$SubtasksTableTableManager(_db, _db.subtasks);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$TaskTagsTableTableManager get taskTags =>
      $$TaskTagsTableTableManager(_db, _db.taskTags);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
  $$NotificationPrefsTableTableManager get notificationPrefs =>
      $$NotificationPrefsTableTableManager(_db, _db.notificationPrefs);
  $$GoalNotificationOverrideTableTableManager get goalNotificationOverride =>
      $$GoalNotificationOverrideTableTableManager(
          _db, _db.goalNotificationOverride);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db, _db.userStats);
  $$HobbiesTableTableManager get hobbies =>
      $$HobbiesTableTableManager(_db, _db.hobbies);
  $$HobbySessionsTableTableManager get hobbySessions =>
      $$HobbySessionsTableTableManager(_db, _db.hobbySessions);
}
