import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:core/config/flavor.dart';

import 'core_module.config.dart';

late FlavorConfig _flavorConfig;

@module
abstract class CoreModule {
  @singleton
  FlavorConfig get flavorConfig => _flavorConfig;
}

@InjectableInit(
  initializerName: 'initCore',
  preferRelativeImports: true,
  asExtension: false,
)
void configureCoreDependencies(GetIt getIt, FlavorConfig flavorConfig) {
  _flavorConfig = flavorConfig;
  initCore(getIt);
}
