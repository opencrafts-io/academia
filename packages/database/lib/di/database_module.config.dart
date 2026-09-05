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

import '../app_database_v2.dart' as _i883;
import '../daos/plan_dao.dart' as _i433;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initAppDatabaseV2(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i883.AppDatabaseV2>(() => _i883.AppDatabaseV2());
  gh.factory<_i433.PlanDao>(() => _i433.PlanDao(gh<_i883.AppDatabaseV2>()));
  return getIt;
}
