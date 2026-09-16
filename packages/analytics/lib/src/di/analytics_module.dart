import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'analytics_module.config.dart';

@InjectableInit(
  initializerName: 'initAnalytics',
  preferRelativeImports: true,
  asExtension: false,
)
void configureAnalyticsDependencies(GetIt getIt) {
  initAnalytics(getIt);
}
