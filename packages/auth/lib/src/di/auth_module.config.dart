// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:analytics/analytics.dart' as _i548;
import 'package:billing/billing.dart' as _i444;
import 'package:core/config/flavor.dart' as _i666;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:notifications/notifications.dart' as _i327;

import '../../auth.dart' as _i607;
import '../data/auth_http_client.dart' as _i1070;
import '../data/datasources/auth_remote_datasource.dart' as _i355;
import '../data/repository/auth_repository_impl.dart' as _i461;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/usecases/get_current_user.dart' as _i8;
import '../domain/usecases/refresh_verisafe_token_usecase.dart' as _i811;
import '../domain/usecases/set_password_usecase.dart' as _i339;
import '../domain/usecases/sign_in_as_review_usecase.dart' as _i400;
import '../domain/usecases/sign_in_with_apple_usecase.dart' as _i819;
import '../domain/usecases/sign_in_with_google_usecase.dart' as _i1011;
import '../domain/usecases/sign_in_with_password_usecase.dart' as _i947;
import '../domain/usecases/sign_in_with_provider_usecase.dart' as _i956;
import '../domain/usecases/sign_in_with_spotify.dart' as _i553;
import '../domain/usecases/sign_out_usecase.dart' as _i873;
import '../presentation/bloc/auth_bloc.dart' as _i244;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initAuth(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i355.AuthRemoteDatasource>(
    () => _i355.AuthRemoteDatasource(
      flavor: gh<_i666.FlavorConfig>(),
      dioClient: gh<_i1070.AuthHttpClient>(),
    ),
  );
  gh.lazySingleton<_i607.AuthRepository>(
    () => _i461.AuthRepositoryImpl(
      authRemoteDatasource: gh<_i607.AuthRemoteDatasource>(),
      authLocalDatasource: gh<_i607.AuthLocalDatasource>(),
    ),
  );
  gh.factory<_i8.GetPreviousAuthState>(
    () => _i8.GetPreviousAuthState(gh<_i607.AuthRepository>()),
  );
  gh.factory<_i819.SignInWithAppleUsecase>(
    () => _i819.SignInWithAppleUsecase(gh<_i607.AuthRepository>()),
  );
  gh.factory<_i1011.SignInWithGoogleUsecase>(
    () => _i1011.SignInWithGoogleUsecase(gh<_i607.AuthRepository>()),
  );
  gh.factory<_i553.SignInWithSpotifyUsecase>(
    () => _i553.SignInWithSpotifyUsecase(gh<_i607.AuthRepository>()),
  );
  gh.factory<_i339.SetPasswordUsecase>(
    () => _i339.SetPasswordUsecase(repository: gh<_i306.AuthRepository>()),
  );
  gh.factory<_i400.SignInAsReviewUsecase>(
    () => _i400.SignInAsReviewUsecase(repository: gh<_i607.AuthRepository>()),
  );
  gh.factory<_i947.SignInWithPasswordUsecase>(
    () =>
        _i947.SignInWithPasswordUsecase(repository: gh<_i306.AuthRepository>()),
  );
  gh.factory<_i956.SignInWithProviderUsecase>(
    () =>
        _i956.SignInWithProviderUsecase(repository: gh<_i607.AuthRepository>()),
  );
  gh.factory<_i811.RefreshVerisafeTokenUsecase>(
    () => _i811.RefreshVerisafeTokenUsecase(
      authRepository: gh<_i607.AuthRepository>(),
    ),
  );
  gh.factory<_i873.SignOutUsecase>(
    () => _i873.SignOutUsecase(authRepository: gh<_i306.AuthRepository>()),
  );
  gh.lazySingleton<_i244.AuthBloc>(
    () => _i244.AuthBloc(
      signInWithGoogle: gh<_i607.SignInWithGoogleUsecase>(),
      signInWithSpotifyUsecase: gh<_i607.SignInWithSpotifyUsecase>(),
      getPreviousAuthState: gh<_i607.GetPreviousAuthState>(),
      refreshVerisafeTokenUsecase: gh<_i607.RefreshVerisafeTokenUsecase>(),
      signInAsReviewUsecase: gh<_i607.SignInAsReviewUsecase>(),
      signInWithAppleUsecase: gh<_i607.SignInWithAppleUsecase>(),
      signInWithProviderUsecase: gh<_i607.SignInWithProviderUsecase>(),
      signInWithPasswordUsecase: gh<_i607.SignInWithPasswordUsecase>(),
      signOutUsecase: gh<_i607.SignOutUsecase>(),
      authLocalDatasource: gh<_i607.AuthLocalDatasource>(),
      analyticsTracker: gh<_i548.AnalyticsTracker>(),
      notificationIdentityService: gh<_i327.NotificationIdentityService>(),
      billingService: gh<_i444.BillingService>(),
    ),
  );
  return getIt;
}
