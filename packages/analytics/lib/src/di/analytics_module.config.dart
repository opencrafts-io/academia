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

import '../feature_flags/feature_flag_reader.dart' as _i996;
import '../feature_flags/posthog_feature_flag_reader.dart' as _i742;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initAnalytics(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i742.PosthogFeatureFlagGateway>(
    () => _i742.PosthogFlutterFeatureFlagGateway(),
  );
  gh.lazySingleton<_i996.FeatureFlagReader>(
    () => _i742.PosthogFeatureFlagReader(gh<_i742.PosthogFeatureFlagGateway>()),
  );
  return getIt;
}
