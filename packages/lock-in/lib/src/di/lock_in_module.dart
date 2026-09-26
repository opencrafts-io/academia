import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'lock_in_module.config.dart';

@InjectableInit(
  initializerName: 'initLockIn',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLockInDependencies(GetIt getIt) {
  initLockIn(getIt);
}
