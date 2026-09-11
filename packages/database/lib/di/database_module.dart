import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../app_database_v2.dart';
import 'database_module.config.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabaseV2 appDatabaseV2() => AppDatabaseV2();
}

@InjectableInit(
  initializerName: 'initAppDatabaseV2',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLocalDatabaseDependencies(GetIt getIt) {
  initAppDatabaseV2(getIt);
}
