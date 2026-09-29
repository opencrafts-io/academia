import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:database/app_database_v2.dart';
import 'package:database/di/database_module.config.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabaseV2 appDatabaseV2() => AppDatabaseV2();
}

@InjectableInit(
  initializerName: 'initAppDatabaseV2',
  preferRelativeImports: false,
  asExtension: false,
)
void configureLocalDatabaseDependencies(GetIt getIt) {
  initAppDatabaseV2(getIt);
}
