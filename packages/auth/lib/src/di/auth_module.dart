import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/datasources/auth_local_datasource.dart';
import 'auth_module.config.dart';

@InjectableInit(
  initializerName: 'initAuth',
  preferRelativeImports: true,
  asExtension: false,
)
void configureAuthDependencies(GetIt getIt) {
  initAuth(getIt);
  if (!getIt.isRegistered<AuthLocalDatasource>()) {
    getIt.registerLazySingleton<AuthLocalDatasource>(AuthLocalDatasource.new);
  }
}
