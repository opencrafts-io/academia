// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:analytics/analytics.dart' as _i548;
import 'package:core/config/flavor.dart' as _i666;
import 'package:core/core.dart' as _i494;
import 'package:database/database.dart' as _i252;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:notifications/notifications.dart' as _i327;

import '../data/profile_api_paths.dart' as _i604;
import '../data/profile_local_datasource.dart' as _i172;
import '../data/profile_remote_datasource.dart' as _i620;
import '../data/profile_repository_impl.dart' as _i1025;
import '../domain/account_deletion_usecase.dart' as _i780;
import '../domain/account_recovery_usecase.dart' as _i812;
import '../domain/clear_cached_profile_usecase.dart' as _i348;
import '../domain/get_cached_profile_usecase.dart' as _i558;
import '../domain/profile_repository.dart' as _i281;
import '../domain/refresh_current_user_profile_usecase.dart' as _i76;
import '../domain/update_user_phone_usecase.dart' as _i186;
import '../domain/update_user_profile.dart' as _i811;
import '../domain/usecases.dart' as _i311;
import '../presentation/bloc/profile_bloc.dart' as _i906;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initProfile(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i604.ProfileApiPaths>(
    () => _i604.ProfileApiPaths(gh<_i666.FlavorConfig>()),
  );
  gh.lazySingleton<_i172.ProfileLocalDatasource>(
    () => _i172.ProfileLocalDatasource(gh<_i252.ProfileDao>()),
  );
  gh.lazySingleton<_i620.ProfileRemoteDatasource>(
    () => _i620.ProfileRemoteDatasourceImpl(
      gh<_i494.ApiClient>(),
      gh<_i604.ProfileApiPaths>(),
    ),
  );
  gh.lazySingleton<_i281.ProfileRepository>(
    () => _i1025.ProfileRepositoryImpl(
      gh<_i620.ProfileRemoteDatasource>(),
      gh<_i172.ProfileLocalDatasource>(),
    ),
  );
  gh.factory<_i348.ClearCachedProfileUsecase>(
    () => _i348.ClearCachedProfileUsecase(
      repository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i780.RequestAccountDeletionUsecase>(
    () => _i780.RequestAccountDeletionUsecase(
      profileRepository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i812.RequestAccountRecoveryUsecase>(
    () => _i812.RequestAccountRecoveryUsecase(
      profileRepository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i558.GetCachedProfileUsecase>(
    () => _i558.GetCachedProfileUsecase(
      profileRepository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i76.RefreshCurrentUserProfileUsecase>(
    () => _i76.RefreshCurrentUserProfileUsecase(
      profileRepository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i186.UpdateUserPhone>(
    () =>
        _i186.UpdateUserPhone(profileRepository: gh<_i281.ProfileRepository>()),
  );
  gh.factory<_i811.UpdateUserProfile>(
    () => _i811.UpdateUserProfile(
      profileRepository: gh<_i281.ProfileRepository>(),
    ),
  );
  gh.factory<_i906.ProfileBloc>(
    () => _i906.ProfileBloc(
      refreshCurrentUserProfileUsecase:
          gh<_i311.RefreshCurrentUserProfileUsecase>(),
      updateUserProfile: gh<_i311.UpdateUserProfile>(),
      updateUserPhone: gh<_i311.UpdateUserPhone>(),
      getCachedProfileUsecase: gh<_i311.GetCachedProfileUsecase>(),
      clearCachedProfileUsecase: gh<_i311.ClearCachedProfileUsecase>(),
      requestAccountDeletionUsecase: gh<_i311.RequestAccountDeletionUsecase>(),
      requestAccountRecoveryUsecase: gh<_i311.RequestAccountRecoveryUsecase>(),
      analyticsTracker: gh<_i548.AnalyticsTracker>(),
      notificationIdentityService: gh<_i327.NotificationIdentityService>(),
    ),
  );
  return getIt;
}
