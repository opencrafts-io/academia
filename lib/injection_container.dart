import 'package:core/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/config/router/router.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  sl.registerSingleton<AuthHttpClient>(dioClient);

  configureDependencies(sl, flavor);
  if (!isBackground) {
    const resetKey = 'profile_storage_v2_auth_reset_v1';
    final preferences = await SharedPreferences.getInstance();
    if (!(preferences.getBool(resetKey) ?? false)) {
      await cacheDB.delete(cacheDB.userProfile).go();

      final tokenDeletion = await sl<AuthLocalDatasource>().deleteAllTokens();
      if (tokenDeletion.isRight()) {
        await preferences.setBool(resetKey, true);
      }
    }
  }

  _registerShereheAndProfile(sl, cacheDB);
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
