import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'settings_module.config.dart';

@InjectableInit(
  initializerName: 'initSettings',
  preferRelativeImports: true,
  asExtension: false,
)
void configureSettingsDependencies(GetIt getIt) {
  initSettings(getIt);
}
