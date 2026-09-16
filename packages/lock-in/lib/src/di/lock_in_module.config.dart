// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:database/daos/lock_in_dao.dart' as _i951;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../application/app_blocking_gateway.dart' as _i534;
import '../application/lock_in_service.dart' as _i4;
import '../data/lock_in_repository.dart' as _i438;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initLockIn(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i534.AppBlockingGateway>(() => _i534.AppBlockerGateway());
  gh.lazySingleton<_i438.LockInRepository>(
    () => _i438.LockInRepository(gh<_i951.LockInDao>()),
  );
  gh.lazySingleton<_i4.LockInService>(
    () => _i4.LockInService(
      gh<_i438.LockInRepository>(),
      gh<_i534.AppBlockingGateway>(),
    ),
  );
  return getIt;
}
