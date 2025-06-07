import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/goal_dao.dart';
import 'package:planza/core/data/data_access_object/task_dao.dart';
import 'package:planza/core/data/database/database.dart';

import 'data/data_access_object/tag_dao.dart';
import 'data/services/locale_prefrence_service.dart';
import 'data/services/theme_prefrence_servie.dart';

/* final sl = GetIt.instance;
 */
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
}
