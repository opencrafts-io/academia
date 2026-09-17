// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../application/app_update_configuration_source.dart' as _i939;
import '../application/app_update_platform_provider.dart' as _i33;
import '../application/app_update_store_launcher.dart' as _i388;
import '../application/app_update_store_urls.dart' as _i364;
import '../application/app_version_provider.dart' as _i809;
import '../domain/app_update_policy_evaluator.dart' as _i168;
import '../presentation/in_app_update_bloc.dart' as _i334;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initInAppUpdate(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i168.AppUpdatePolicyEvaluator>(
    () => _i168.AppUpdatePolicyEvaluator(),
  );
  gh.lazySingleton<_i33.AppUpdatePlatformProvider>(
    () => const _i33.DeviceAppUpdatePlatformProvider(),
  );
  gh.lazySingleton<_i809.AppVersionProvider>(
    () => const _i809.PackageInfoAppVersionProvider(),
  );
  gh.lazySingleton<_i388.StoreUrlOpener>(
    () => const _i388.UrlLauncherStoreUrlOpener(),
  );
  gh.lazySingleton<_i388.AppUpdateStoreLauncher>(
    () => _i388.AppUpdateStoreLauncher(gh<_i388.StoreUrlOpener>()),
  );
  gh.lazySingleton<_i334.InAppUpdateBloc>(
    () => _i334.InAppUpdateBloc(
      configurationSource: gh<_i939.AppUpdateConfigurationSource>(),
      platformProvider: gh<_i33.AppUpdatePlatformProvider>(),
      versionProvider: gh<_i809.AppVersionProvider>(),
      storeUrls: gh<_i364.AppUpdateStoreUrls>(),
      policyEvaluator: gh<_i168.AppUpdatePolicyEvaluator>(),
    ),
  );
  return getIt;
}
