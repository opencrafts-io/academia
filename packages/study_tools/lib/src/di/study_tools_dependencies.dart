import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:analytics/analytics.dart';
import 'package:ads/ads.dart';
import 'package:audio_service/audio_service.dart';
import 'package:billing/billing.dart';
import 'package:database/daos/study_tools_dao.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../data/datasources/study_tools_api_paths.dart';
import '../data/datasources/study_tools_local_datasource.dart';
import '../data/datasources/study_tools_remote_datasource.dart';
import '../data/repositories/study_tools_repository_impl.dart';
import '../data/services/podcast_local_store.dart';
import '../domain/repositories/study_tools_repository.dart';
import '../presentation/audio/podcast_audio_handler.dart';
import '../presentation/audio/podcast_playback_adapter.dart';
import '../presentation/cubit/podcast_cubit.dart';
import '../presentation/study_tools_host.dart';
import '../presentation/cubit/study_tools_cubit.dart';

void configureStudyToolsDependencies(
  GetIt getIt,
  FlavorConfig flavor, {
  required String? Function() accountId,
}) {
  StudyToolsScope? currentScope() {
    final id = accountId();
    if (id == null || id.trim().isEmpty || id == 'unresolved') return null;
    return (
      environment: flavor.flavorName,
      accountId: id,
      legacyScope: '${flavor.flavorName}_$id',
    );
  }

  getIt.registerLazySingleton(() => StudyToolsApiPaths(flavor));
  getIt.registerLazySingleton<StudyToolsRemoteDatasource>(
    () => StudyToolsRemoteDatasourceImpl(
      getIt<ApiClient>(),
      getIt<StudyToolsApiPaths>(),
    ),
  );
  getIt.registerLazySingleton<StudyToolsLocalDatasource>(
    () => DriftStudyToolsLocalDatasource(
      dao: getIt<StudyToolsDao>(),
      scope: currentScope,
    ),
  );
  getIt.registerLazySingleton<PodcastLocalStore>(
    () => PodcastLocalStore(
      dao: getIt<StudyToolsDao>(),
      scope: currentScope,
      billing: getIt<BillingService>(),
      accessPolicy: getIt<SubscriptionAccessPolicy>(),
      clock: getIt<BillingClock>(),
    ),
  );
  getIt.registerSingletonAsync<PodcastAudioHandler>(() async {
    final store = getIt<PodcastLocalStore>();
    final handler = PodcastAudioHandler(
      adapter: SoloudPodcastPlaybackAdapter(engine: SoLoud.instance),
      access: store,
      positions: store,
      mediaBaseUri: Uri.parse(flavor.apiBaseUrl),
      onEpisodeActivated: (podcast) =>
          StudyToolsHost.openPodcastPlayer?.call(podcast),
    );
    return AudioService.init<PodcastAudioHandler>(
      builder: () => handler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'io.opencrafts.academia.study_podcasts',
        androidNotificationChannelName: 'Study podcasts',
        androidNotificationChannelDescription: 'Podcast playback controls',
        androidNotificationIcon: 'mipmap/ic_launcher',
        androidNotificationOngoing: false,
        androidStopForegroundOnPause: false,
        androidResumeOnClick: true,
      ),
    );
  });
  getIt.registerLazySingleton<StudyToolsRepository>(
    () => StudyToolsRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerFactory(
    () => StudyToolsCubit(
      getIt<StudyToolsRepository>(),
      podcastStore: getIt<PodcastLocalStore>(),
      audioHandler: getIt<PodcastAudioHandler>(),
      analyticsTracker: getIt<AnalyticsTracker>(),
      adService: getIt<AdService>(),
    ),
  );
  getIt.registerFactory(
    () => PodcastCubit(
      getIt<PodcastLocalStore>(),
      getIt<PodcastAudioHandler>(),
      analyticsTracker: getIt<AnalyticsTracker>(),
    ),
  );
}
