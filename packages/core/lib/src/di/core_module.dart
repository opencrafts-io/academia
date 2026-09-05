import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core_module.config.dart';

@InjectableInit(
  initializerName: 'initCore',
  preferRelativeImports: true,
  asExtension: false,
)
void configureCoreDependencies(GetIt getIt) {
  initCore(getIt);
}
