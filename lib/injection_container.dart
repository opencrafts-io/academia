import 'package:core/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/config/router/router.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:ads/ads.dart';
import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:lock_in/lock_in.dart';
import 'package:courses/courses.dart' as courses;
import 'package:academia/core/institution/verisafe_institution_lookup.dart';
import 'package:study_tools/study_tools.dart' as study_tools;
import 'package:billing/billing.dart' as billing;
import 'package:academia/core/notifications/course_schedule_reminder_service.dart';
import 'package:notifications/notifications.dart';
import 'package:permissions/permissions.dart';

part 'injection/sherehe_profile.dart';
part 'injection/communities.dart';
part 'injection/chirp.dart';
part 'injection/institutions.dart';
part 'injection/academics.dart';

final sl = GetIt.instance;

Future<void> init(FlavorConfig flavor, {bool isBackground = false}) async {
  if (!isBackground) {
    final DioRequestInspector inspector = DioRequestInspector(
      isInspectorEnabled: kDebugMode,
      showSummary: false,
    );
    sl.registerSingleton<DioRequestInspector>(inspector);
  }

  final cacheDB = sl.registerSingleton<AppDataBase>(AppDataBase());

  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());

  final dioClient = sl.registerSingleton<DioClient>(
    DioClient(
      flavor,
      authLocalDatasource: sl.get<AuthLocalDatasource>(),
      requestInspector: isBackground ? null : sl<DioRequestInspector>(),
    ),
  );

  sl.registerSingleton<Dio>(dioClient.dio);

  configureDependencies(sl, flavor);

  sl.registerFactory(
    () => AuthRemoteDatasource(flavor: flavor, dioClient: sl()),
  );
  sl.registerFactory<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: sl.get<AuthRemoteDatasource>(),
      authLocalDatasource: sl.get<AuthLocalDatasource>(),
    ),
  );

  sl.registerFactory<SignInWithGoogleUsecase>(
    () => SignInWithGoogleUsecase(sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInWithProviderUsecase>(
    () => SignInWithProviderUsecase(repository: sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInWithPasswordUsecase>(
    () => SignInWithPasswordUsecase(repository: sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SetPasswordUsecase>(
    () => SetPasswordUsecase(repository: sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInWithAppleUsecase>(
    () => SignInWithAppleUsecase(sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInAsReviewUsecase>(
    () => SignInAsReviewUsecase(repository: sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInWithSpotifyUsecase>(
    () => SignInWithSpotifyUsecase(sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<GetPreviousAuthState>(
    () => GetPreviousAuthState(sl.get<AuthRepositoryImpl>()),
  );
  sl.registerFactory<RefreshVerisafeTokenUsecase>(
    () => RefreshVerisafeTokenUsecase(authRepository: sl<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignOutUsecase>(
    () => SignOutUsecase(authRepository: sl<AuthRepositoryImpl>()),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      signOutUsecase: sl(),
      signInWithProviderUsecase: sl(),
      signInWithAppleUsecase: sl(),
      signInAsReviewUsecase: sl(),
      signInWithPasswordUsecase: sl(),
      refreshVerisafeTokenUsecase: sl(),
      signInWithSpotifyUsecase: sl.get<SignInWithSpotifyUsecase>(),
      getPreviousAuthState: sl.get<GetPreviousAuthState>(),
      signInWithGoogle: sl.get<SignInWithGoogleUsecase>(),
      authLocalDatasource: sl<AuthLocalDatasource>(),
      analyticsTracker: sl(),
      notificationIdentityService: sl(),
    ),
  );

  _registerShereheAndProfile(sl, flavor, cacheDB);
  _registerCommunities(sl, flavor);
  _registerChirp(sl, flavor);
  _registerInstitutions(sl, flavor);
  _registerAcademics(sl);
}

/// Initializes optional platform services after the first app frame is shown.
Future<void> initializeDeferredServices() async {
  await Future.wait([
    initializeNotifications(),
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
      sl<LockInService>().start(),
    _initializeAds(),
  ]);
}

Future<void> initializeNotifications() =>
    sl<NotificationService>().initialize(sl<NotificationActionHandler>());

Future<void> _initializeAds() async {
  final adService = sl<AdService>();
  await adService.initialize();
  await adService.loadInterstitialAd();
  await adService.loadAppOpenAd();
  await adService.loadRewardedAd();
}
