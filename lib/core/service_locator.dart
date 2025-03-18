import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/goal_dao.dart';
import 'package:planza/core/data/data_access_object/task_dao.dart';
import 'package:planza/core/data/database/database.dart';

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
    () => ThemePreferenceService(),
  );
}
