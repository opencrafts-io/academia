import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:in_app_update/src/application/app_update_configuration_source.dart';
import 'package:in_app_update/src/application/app_update_store_urls.dart';

import 'in_app_update_module.config.dart';

@InjectableInit(
  initializerName: 'initInAppUpdate',
  preferRelativeImports: true,
  asExtension: false,
)
void configureInAppUpdateDependencies(
  GetIt getIt, {
  required AppUpdateConfigurationSource configurationSource,
  required AppUpdateStoreUrls storeUrls,
}) {
  if (!getIt.isRegistered<AppUpdateConfigurationSource>()) {
    getIt.registerSingleton<AppUpdateConfigurationSource>(configurationSource);
  }
  if (!getIt.isRegistered<AppUpdateStoreUrls>()) {
    getIt.registerSingleton<AppUpdateStoreUrls>(storeUrls);
  }
  initInAppUpdate(getIt);
}
