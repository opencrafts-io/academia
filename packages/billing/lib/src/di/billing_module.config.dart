// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/core.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/datasources/plan_remote_datasource.dart' as _i745;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initBilling(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i745.PlanRemoteDatasource>(
    () => _i745.PlanRemoteDatasource(apiClient: gh<_i494.ApiClient>()),
  );
  return getIt;
}
