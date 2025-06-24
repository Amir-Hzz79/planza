import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../data_access_object/tag_dao.dart';
import '../data_access_object/task_dao.dart';
import '../data_access_object/user_setting_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Tasks, Subtasks, Tags, TaskTags, Goals, UserSettings],
  daos: [TaskDao, TagDao, UserSettingsDao],
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

  Future<void> insertEnDummyData() async {
    await goals.deleteAll();
    await tasks.deleteAll();
    await tags.deleteAll();
    await taskTags.deleteAll();

    // Insert Goals
    await into(goals).insert(GoalsCompanion(
      id: Value(1),
      name: Value("Fitness Challenge"),
      description: Value("Get fit in 3 months"),
      deadline: Value(DateTime(2025, 6, 1)),
      color: Value(0xFFffc8dd),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(2),
      name: Value("Read More Books"),
      description: Value("Read 12 books this year"),
      deadline: Value(DateTime(2025, 12, 31)),
      color: Value(0xFFbde0fe),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(3),
      name: Value("Vacation Planning"),
      description: Value("Plan summer vacation"),
      deadline: Value(DateTime(2025, 4, 15)),
      color: Value(0xFFa2d2ff),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(4),
      name: Value("Cooking Challenge"),
      description: Value("Learn to cook 10 new recipes"),
      deadline: Value(DateTime(2025, 5, 30)),
      color: Value(0xFFffafcc),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(5),
      name: Value("Home Renovation"),
      description: Value("Redesign the living room and kitchen"),
      deadline: Value(DateTime(2025, 7, 15)),
      color: Value(0xFFcdb4db),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(6),
      name: Value("Language Learning"),
      description: Value("Learn conversational Spanish"),
      deadline: Value(DateTime(2025, 10, 1)),
      color: Value(0xFFb9fbc0),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(7),
      name: Value("Gardening Project"),
      description: Value("Grow vegetables and flowers in the backyard"),
      deadline: Value(DateTime(2025, 8, 15)),
      color: Value(0xFFffd6a5),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(8),
      name: Value("Tech Skills Improvement"),
      description: Value("Complete an advanced programming course"),
      deadline: Value(DateTime(2025, 9, 30)),
      color: Value(0xFFf4a261),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(9),
      name: Value("Fitness Milestone"),
      description: Value("Run a half marathon"),
      deadline: Value(DateTime(2025, 10, 20)),
      color: Value(0xFFe9c46a),
    ));

    // Insert Tasks
    await into(tasks).insert(TasksCompanion(
      id: Value(1),
      goalId: Value(1),
      title: Value("Morning Jogging"),
      description: Value("Jog every morning"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 5))),
      doneDate: Value(DateTime.now().subtract(Duration(days: 6))),
      priority: Value(1),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(2),
      goalId: Value(1),
      title: Value("Gym Session"),
      description: Value("Strength training"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 4))),
      doneDate: Value(DateTime.now().subtract(Duration(days: 3))),
      priority: Value(2),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(3),
      goalId: Value(3),
      title: Value("Finalize Flight Tickets"),
      description: Value("Book flights for the trip"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 1))),
      priority: Value(3),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(4),
      goalId: Value(3),
      title: Value("Create Vacation Budget"),
      description: Value("Budget your expenses"),
      dueDate: Value(DateTime.now()),
      priority: Value(1),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(5),
      goalId: Value(2),
      title: Value("Start Reading Novel"),
      description: Value("Read a new fiction book"),
      dueDate: Value(DateTime.now()),
      doneDate: Value(DateTime(2025, 4, 14)),
      priority: Value(2),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(6),
      goalId: Value(4),
      title: Value("Try Italian Recipe"),
      description: Value("Cook pasta from scratch"),
      dueDate: Value(DateTime.now()),
      priority: Value(2),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(7),
      goalId: Value(5),
      title: Value("Buy Paint for Walls"),
      description: Value("Choose a color palette and purchase paint"),
      dueDate: Value(DateTime.now().add(Duration(days: 1))),
      priority: Value(3),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(8),
      goalId: Value(6),
      title: Value("Practice Spanish Verbs"),
      description: Value("Master the 20 most common verbs"),
      dueDate: Value(DateTime.now().add(Duration(days: 2))),
      priority: Value(1),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(9),
      goalId: Value(4),
      title: Value("Bake a Cake"),
      description: Value("Bake a chocolate cake for dessert"),
      dueDate: Value(DateTime.now().add(Duration(days: 5))),
      doneDate: Value(DateTime.now().add(Duration(days: 1))),
      priority: Value(1),
      parentTaskId: Value(6),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(10),
      goalId: Value(5),
      title: Value("Sand and Prep Walls"),
      description: Value("Prepare the walls for painting"),
      dueDate: Value(DateTime.now().add(Duration(days: 15))),
      doneDate: Value(DateTime.now().add(Duration(days: 4))),
      priority: Value(3),
      parentTaskId: Value(7),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(11),
      goalId: Value(7),
      title: Value("Prepare Soil for Planting"),
      description: Value("Clear weeds and add compost"),
      dueDate: Value(DateTime.now().add(Duration(days: 2))),
      priority: Value(2),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(12),
      goalId: Value(8),
      title: Value("Enroll in Online Course"),
      description: Value("Sign up for an advanced programming course"),
      dueDate: Value(DateTime.now().add(Duration(days: 3))),
      priority: Value(1),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(13),
      goalId: Value(9),
      title: Value("Research Running Gear"),
      description: Value("Find the best running shoes and clothes"),
      dueDate: Value(DateTime.now()),
      priority: Value(2),
      parentTaskId: Value(null),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(14),
      goalId: Value(7),
      title: Value("Plant Vegetables"),
      description: Value("Plant tomatoes, carrots, and peppers"),
      dueDate: Value(DateTime.now().add(Duration(days: 30))),
      priority: Value(3),
      parentTaskId: Value(11),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(15),
      goalId: Value(9),
      title: Value("Practice Running"),
      description: Value("Follow a training schedule for the half marathon"),
      dueDate: Value(DateTime.now().add(Duration(days: 12))),
      priority: Value(3),
      parentTaskId: Value(13),
    ));
    await into(tasks).insert(TasksCompanion(
      id: Value(16),
      goalId: Value(1),
      title: Value("Practice Running"),
      description: Value("Follow a training schedule for the half marathon"),
      dueDate: Value(DateTime.now().add(Duration(days: 7))),
      priority: Value(3),
      parentTaskId: Value(13),
    ));

    //Insert Tags
    await into(tags).insert(TagsCompanion(
      id: Value(1),
      name: Value('Urgent'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(2),
      name: Value('other'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(3),
      name: Value('today'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(4),
      name: Value('call'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(5),
      name: Value('message'),
    ));

    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(1),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(2),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(3),
      taskId: Value(4),
    ));

    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(4),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(5),
      taskId: Value(4),
    ));
  }

  Future<void> insertFaDummyData() async {
    await goals.deleteAll();
    await tasks.deleteAll();
    await tags.deleteAll();
    await taskTags.deleteAll();

    await into(goals).insert(GoalsCompanion(
      id: Value(1),
      name: Value("چالش تناسب اندام"),
      description: Value("رسیدن به تناسب اندام در ۳ ماه"),
      deadline: Value(DateTime(2025, 6, 1)),
      color: Value(0xFFffc8dd),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(2),
      name: Value("کتاب‌خوانی بیشتر"),
      description: Value("خواندن ۱۲ کتاب در سال جاری"),
      deadline: Value(DateTime(2025, 12, 31)),
      color: Value(0xFFbde0fe),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(3),
      name: Value("برنامه‌ریزی تعطیلات"),
      description: Value("برنامه‌ریزی برای تعطیلات تابستان"),
      deadline: Value(DateTime(2025, 4, 15)),
      color: Value(0xFFa2d2ff),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(4),
      name: Value("چالش آشپزی"),
      description: Value("یادگیری ۱۰ دستور پخت جدید"),
      deadline: Value(DateTime(2025, 5, 30)),
      color: Value(0xFFffafcc),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(5),
      name: Value("بازسازی خانه"),
      description: Value("طراحی مجدد اتاق نشیمن و آشپزخانه"),
      deadline: Value(DateTime(2025, 7, 15)),
      color: Value(0xFFcdb4db),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(6),
      name: Value("یادگیری زبان"),
      description: Value("یادگیری مکالمه اسپانیایی"),
      deadline: Value(DateTime(2025, 10, 1)),
      color: Value(0xFFb9fbc0),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(7),
      name: Value("پروژه باغبانی"),
      description: Value("پرورش سبزیجات و گل در حیاط"),
      deadline: Value(DateTime(2025, 8, 15)),
      color: Value(0xFFffd6a5),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(8),
      name: Value("بهبود مهارت‌های فنی"),
      description: Value("تکمیل یک دوره پیشرفته برنامه‌نویسی"),
      deadline: Value(DateTime(2025, 9, 30)),
      color: Value(0xFFf4a261),
    ));

    await into(goals).insert(GoalsCompanion(
      id: Value(9),
      name: Value("نقطه عطف ورزشی"),
      description: Value("دویدن در مسابقه نیمه ماراتن"),
      deadline: Value(DateTime(2025, 10, 20)),
      color: Value(0xFFe9c46a),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(1),
      goalId: Value(1),
      title: Value("دویدن صبحگاهی"),
      description: Value("هر روز صبح بدو"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 5))),
      doneDate: Value(DateTime.now().subtract(Duration(days: 6))),
      priority: Value(1),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(2),
      goalId: Value(1),
      title: Value("جلسه باشگاه"),
      description: Value("تمرین قدرتی"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 4))),
      doneDate: Value(DateTime.now().subtract(Duration(days: 3))),
      priority: Value(2),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(3),
      goalId: Value(3),
      title: Value("نهایی کردن بلیط‌های پرواز"),
      description: Value("رزرو بلیط برای سفر"),
      dueDate: Value(DateTime.now().subtract(Duration(days: 1))),
      priority: Value(3),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(4),
      goalId: Value(3),
      title: Value("ایجاد بودجه تعطیلات"),
      description: Value("هزینه‌هاتو بودجه‌بندی کن"),
      dueDate: Value(DateTime.now()),
      priority: Value(1),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(5),
      goalId: Value(2),
      title: Value("شروع خواندن رمان"),
      description: Value("خواندن یک کتاب داستانی جدید"),
      dueDate: Value(DateTime.now()),
      doneDate: Value(DateTime(2025, 4, 14)),
      priority: Value(2),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(6),
      goalId: Value(4),
      title: Value("امتحان کردن دستور پخت ایتالیایی"),
      description: Value("پختن پاستا از صفر"),
      dueDate: Value(DateTime.now()),
      priority: Value(2),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(7),
      goalId: Value(5),
      title: Value("خرید رنگ برای دیوارها"),
      description: Value("انتخاب پالت رنگی و خرید رنگ"),
      dueDate: Value(DateTime.now().add(Duration(days: 1))),
      priority: Value(3),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(8),
      goalId: Value(6),
      title: Value("تمرین افعال اسپانیایی"),
      description: Value("مسلط شدن بر ۲۰ فعل رایج"),
      dueDate: Value(DateTime.now().add(Duration(days: 2))),
      priority: Value(1),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(9),
      goalId: Value(4),
      title: Value("پختن کیک"),
      description: Value("پختن یک کیک شکلاتی برای دسر"),
      dueDate: Value(DateTime.now().add(Duration(days: 5))),
      doneDate: Value(DateTime.now().add(Duration(days: 1))),
      priority: Value(1),
      parentTaskId: Value(6),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(10),
      goalId: Value(5),
      title: Value("سنباده زدن و آماده‌سازی دیوارها"),
      description: Value("آماده کردن دیوارها برای نقاشی"),
      dueDate: Value(DateTime.now().add(Duration(days: 15))),
      doneDate: Value(DateTime.now().add(Duration(days: 4))),
      priority: Value(3),
      parentTaskId: Value(7),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(11),
      goalId: Value(7),
      title: Value("آماده کردن خاک برای کاشت"),
      description: Value("پاک کردن علف‌های هرز و اضافه کردن کمپوست"),
      dueDate: Value(DateTime.now().add(Duration(days: 2))),
      priority: Value(2),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(12),
      goalId: Value(8),
      title: Value("ثبت‌نام در دوره آنلاین"),
      description: Value("ثبت‌نام برای یک دوره پیشرفته برنامه‌نویسی"),
      dueDate: Value(DateTime.now().add(Duration(days: 3))),
      priority: Value(1),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(13),
      goalId: Value(9),
      title: Value("تحقیق درباره وسایل دویدن"),
      description: Value("پیدا کردن بهترین کفش و لباس دویدن"),
      dueDate: Value(DateTime.now()),
      priority: Value(2),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(14),
      goalId: Value(7),
      title: Value("کاشت سبزیجات"),
      description: Value("کاشتن گوجه، هویج و فلفل"),
      dueDate: Value(DateTime.now().add(Duration(days: 30))),
      priority: Value(3),
      parentTaskId: Value(11),
    ));

    await into(tasks).insert(TasksCompanion(
      id: Value(15),
      goalId: Value(9),
      title: Value("تمرین دویدن"),
      description: Value("دنبال کردن برنامه تمرینی برای نیمه ماراتن"),
      dueDate: Value(DateTime.now().add(Duration(days: 12))),
      priority: Value(3),
      parentTaskId: Value(13),
    ));
    await into(tasks).insert(TasksCompanion(
      id: Value(16),
      goalId: Value(1),
      title: Value("تمرین دویدن"),
      description: Value("دنبال کردن برنامه تمرینی برای نیمه ماراتن"),
      dueDate: Value(DateTime.now().add(Duration(days: 7))),
      priority: Value(3),
      parentTaskId: Value(13),
    ));

    await into(tags).insert(TagsCompanion(
      id: Value(1),
      name: Value('فوری'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(2),
      name: Value('متفرقه'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(3),
      name: Value('امروز'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(4),
      name: Value('تماس'),
    ));
    await into(tags).insert(TagsCompanion(
      id: Value(5),
      name: Value('پیام'),
    ));

    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(1),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(2),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(3),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(4),
      taskId: Value(4),
    ));
    await into(taskTags).insert(TaskTagsCompanion.insert(
      tagId: Value(5),
      taskId: Value(4),
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
