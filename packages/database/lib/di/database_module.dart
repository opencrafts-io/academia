import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'database_module.config.dart';

@InjectableInit(
  initializerName: 'initAppDatabaseV2',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLocalDatabaseDependencies(GetIt getIt) {
  initAppDatabaseV2(getIt);
}
