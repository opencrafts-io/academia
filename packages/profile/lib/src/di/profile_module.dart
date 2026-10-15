import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'profile_module.config.dart';

@InjectableInit(
  initializerName: 'initProfile',
  preferRelativeImports: true,
  asExtension: false,
)
void configureProfileDependencies(GetIt getIt) {
  initProfile(getIt);
}
