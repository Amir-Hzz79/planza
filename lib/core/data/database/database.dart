import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../data_access_object/goal_task_dao.dart';
import '../data_access_object/tag_dao.dart';
import '../data_access_object/task_dao.dart';
import '../data_access_object/user_setting_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Tasks, Subtasks, Tags, TaskTags, Goals, GoalTasks, UserSettings],
  daos: [TaskDao, TagDao, GoalTaskDao, UserSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFolderPath = '${dbFolder.path}/database';
      final file = File('$dbFolderPath/planza_db.sqlite');

      // Ensure the directory exists
      if (!(await Directory(dbFolderPath).exists())) {
        await Directory(dbFolderPath).create(recursive: true);
      }

      return NativeDatabase(file);
    });
  }

  Future<void> insertDummyData(AppDatabase db) async {
    await db.goals.deleteAll();
    await db.tasks.deleteAll();
    await db.goalTasks.deleteAll();

    // Insert Goals
    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(1),
          name: Value("Fitness Challenge"),
          description: Value("Get fit in 3 months"),
          deadline: Value(DateTime(2025, 6, 1)),
          completed: Value(false),
          color: Value(0xFFffc8dd),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(2),
          name: Value("Read More Books"),
          description: Value("Read 12 books this year"),
          deadline: Value(DateTime(2025, 12, 31)),
          completed: Value(false),
          color: Value(0xFFbde0fe),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(3),
          name: Value("Vacation Planning"),
          description: Value("Plan summer vacation"),
          deadline: Value(DateTime(2025, 4, 15)),
          completed: Value(true),
          color: Value(0xFFa2d2ff),
        ));

    // Insert Tasks
    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(1),
          title: Value("Morning Jogging"),
          description: Value("Jog every morning"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 3, 1)),
          priority: Value(1),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(2),
          title: Value("Gym Session"),
          description: Value("Strength training"),
          isCompleted: Value(true),
          dueDate: Value(DateTime(2025, 3, 3)),
          priority: Value(2),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(3),
          title: Value("Start Reading Novel"),
          description: Value("Read a new fiction book"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 3, 4)),
          priority: Value(2),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(4),
          title: Value("Create Vacation Budget"),
          description: Value("Budget your expenses"),
          isCompleted: Value(true),
          dueDate: Value(DateTime(2025, 3, 4)),
          priority: Value(1),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(5),
          title: Value("Finalize Flight Tickets"),
          description: Value("Book flights for the trip"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 3, 5)),
          priority: Value(3),
          parentTaskId: Value(null),
        ));

    // Insert GoalTasks
    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(1),
          taskId: Value(1),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(1),
          taskId: Value(2),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(2),
          taskId: Value(3),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(3),
          taskId: Value(4),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(3),
          taskId: Value(5),
        ));

    // Insert Goals
    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(4),
          name: Value("Cooking Challenge"),
          description: Value("Learn to cook 10 new recipes"),
          deadline: Value(DateTime(2025, 5, 30)),
          completed: Value(false),
          color: Value(0xFFffafcc),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(5),
          name: Value("Home Renovation"),
          description: Value("Redesign the living room and kitchen"),
          deadline: Value(DateTime(2025, 7, 15)),
          completed: Value(false),
          color: Value(0xFFcdb4db),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(6),
          name: Value("Language Learning"),
          description: Value("Learn conversational Spanish"),
          deadline: Value(DateTime(2025, 10, 1)),
          completed: Value(false),
          color: Value(0xFFb9fbc0),
        ));

// Insert Tasks
    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(6),
          title: Value("Try Italian Recipe"),
          description: Value("Cook pasta from scratch"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 10)),
          priority: Value(2),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(7),
          title: Value("Buy Paint for Walls"),
          description: Value("Choose a color palette and purchase paint"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 5, 1)),
          priority: Value(3),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(8),
          title: Value("Practice Spanish Verbs"),
          description: Value("Master the 20 most common verbs"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 3, 20)),
          priority: Value(1),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(9),
          title: Value("Bake a Cake"),
          description: Value("Bake a chocolate cake for dessert"),
          isCompleted: Value(true),
          dueDate: Value(DateTime(2025, 4, 5)),
          priority: Value(1),
          parentTaskId: Value(6),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(10),
          title: Value("Sand and Prep Walls"),
          description: Value("Prepare the walls for painting"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 5, 5)),
          priority: Value(3),
          parentTaskId: Value(7),
        ));

// Insert GoalTasks
    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(4),
          taskId: Value(6),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(4),
          taskId: Value(9),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(5),
          taskId: Value(7),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(5),
          taskId: Value(10),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(6),
          taskId: Value(8),
        )); // Insert Goals
    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(7),
          name: Value("Gardening Project"),
          description: Value("Grow vegetables and flowers in the backyard"),
          deadline: Value(DateTime(2025, 8, 15)),
          completed: Value(false),
          color: Value(0xFFffd6a5),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(8),
          name: Value("Tech Skills Improvement"),
          description: Value("Complete an advanced programming course"),
          deadline: Value(DateTime(2025, 9, 30)),
          completed: Value(false),
          color: Value(0xFFf4a261),
        ));

    await db.into(db.goals).insert(GoalsCompanion(
          id: Value(9),
          name: Value("Fitness Milestone"),
          description: Value("Run a half marathon"),
          deadline: Value(DateTime(2025, 10, 20)),
          completed: Value(false),
          color: Value(0xFFe9c46a),
        ));

// Insert Tasks
    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(11),
          title: Value("Prepare Soil for Planting"),
          description: Value("Clear weeds and add compost"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 1)),
          priority: Value(2),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(12),
          title: Value("Enroll in Online Course"),
          description: Value("Sign up for an advanced programming course"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 10)),
          priority: Value(1),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(13),
          title: Value("Research Running Gear"),
          description: Value("Find the best running shoes and clothes"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 15)),
          priority: Value(2),
          parentTaskId: Value(null),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(14),
          title: Value("Plant Vegetables"),
          description: Value("Plant tomatoes, carrots, and peppers"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 20)),
          priority: Value(3),
          parentTaskId: Value(11),
        ));

    await db.into(db.tasks).insert(TasksCompanion(
          id: Value(15),
          title: Value("Practice Running"),
          description:
              Value("Follow a training schedule for the half marathon"),
          isCompleted: Value(false),
          dueDate: Value(DateTime(2025, 4, 25)),
          priority: Value(3),
          parentTaskId: Value(13),
        ));

// Insert GoalTasks
    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(7),
          taskId: Value(11),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(7),
          taskId: Value(14),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(8),
          taskId: Value(12),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(9),
          taskId: Value(13),
        ));

    await db.into(db.goalTasks).insert(GoalTasksCompanion(
          goalId: Value(9),
          taskId: Value(15),
        ));
  }

  @override
  // TODO: implement migration
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(
              goals,
              GeneratedColumn(
                'color',
                'Goals',
                false,
                type: DriftSqlType.int,
              ),
            );
          }
        },
      );
}
