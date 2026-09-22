import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/goal_dao.dart';
import 'package:planza/core/data/data_access_object/hobbies_dao.dart';
import 'package:planza/core/data/data_access_object/hobby_sessions_dao.dart';
import 'package:planza/core/data/data_access_object/task_dao.dart';
import 'package:planza/core/data/data_access_object/user_stats_dao.dart';
import 'package:planza/core/data/database/database.dart';

import 'data/data_access_object/tag_dao.dart';
import 'services/locale_prefrence_service.dart';
import 'services/theme_prefrence_servie.dart';
import 'services/notification_service.dart';

Future<void> initServices() async {
  final AppDatabase database = AppDatabase();

  GetIt.instance.registerLazySingleton(
    () => database,
  );

  GetIt.instance.registerLazySingleton(
    () => GoalDao(database),
  );

  GetIt.instance.registerLazySingleton(
    () => TaskDao(database),
  );

  GetIt.instance.registerLazySingleton(
    () => TagDao(database),
  );

  GetIt.instance.registerLazySingleton(
    () => ThemePreferenceService(),
  );

  GetIt.instance.registerLazySingleton(
    () => LocalePreferenceService(),
  );

  GetIt.instance.registerLazySingleton(
    () => UserStatsDao(database),
  );
  GetIt.instance.registerLazySingleton(
    () => HobbiesDao(database),
  );
  GetIt.instance.registerLazySingleton(
    () => HobbySessionsDao(database),
  );

  final notificationService = await NotificationService().init();
  GetIt.instance.registerLazySingleton(
    () => notificationService,
  );
}
