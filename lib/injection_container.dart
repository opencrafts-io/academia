import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> init(FlavorConfig flavor) async {
  final DioRequestInspector inspector = DioRequestInspector(
    isInspectorEnabled: kDebugMode,
    showSummary: false,
  );

  sl.registerSingleton<DioRequestInspector>(inspector);

  // Register the flavor
  sl.registerSingleton<FlavorConfig>(flavor);

  final cacheDB = sl.registerSingleton<AppDataBase>(AppDataBase());

  final AdService adService = AdService();
  await adService.initialize();
  adService.loadInterstitialAd();

  sl.registerSingleton<AdService>(adService);

  sl.registerFactory<AuthLocalDatasource>(
    () => AuthLocalDatasource(localDB: cacheDB),
  );

  sl.registerFactory<DioClient>(
    () => DioClient(
      flavor,
      authLocalDatasource: sl.get<AuthLocalDatasource>(),
      requestInspector: sl<DioRequestInspector>(),
    ),
  );

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

  //sherehe
  sl.registerLazySingleton<ShereheRemoteDataSource>(
    () => ShereheRemoteDataSource(dioClient: sl.get<DioClient>(), flavor: sl()),
  );
  sl.registerLazySingleton(
    () => CreateEventUseCase(sl.get<ShereheRepository>()),
  );
  sl.registerLazySingleton<ShereheLocalDataSource>(
    () => ShereheLocalDataSource(localDB: cacheDB),
  );
  sl.registerLazySingleton(() => CreateAttendeeUseCase(sl()));

  sl.registerSingleton<ShereheRepository>(
    ShereheRepositoryImpl(
      remoteDataSource: sl.get<ShereheRemoteDataSource>(),
      localDataSource: sl.get<ShereheLocalDataSource>(),
    ),
  );

  sl.registerSingleton<GetEvent>(GetEvent(sl()));
  sl.registerLazySingleton(() => GetSpecificEvent(sl()));
  sl.registerLazySingleton(() => GetAttendee(sl()));
  sl.registerLazySingleton(() => CacheEventsUseCase(sl()));

  sl.registerFactory(
    () => ShereheHomeBloc(
      getEvent: sl(),
      getAttendee: sl(),
      cacheEventsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(),
      getAttendeesUseCase: sl(),
      createAttendeeUseCase: sl(),
      getCachedUserProfileUseCase: sl(),
    ),
  );

  sl.registerFactory(() => CreateEventBloc(createEventUseCase: sl()));
  sl.registerFactory<ProfileRemoteDatasource>(
    () =>
        ProfileRemoteDatasource(dioClient: sl.get<DioClient>(), flavor: flavor),
  );
  sl.registerFactory<ProfileLocalDatasource>(
    () => ProfileLocalDatasource(localDB: cacheDB),
  );

  sl.registerFactory<ProfileRepositoryImpl>(
    () => ProfileRepositoryImpl(
      profileLocalDatasource: sl.get<ProfileLocalDatasource>(),
      profileRemoteDatasource: sl.get<ProfileRemoteDatasource>(),
    ),
  );

  sl.registerFactory<RefreshCurrentUserProfileUsecase>(
    () => RefreshCurrentUserProfileUsecase(
      profileRepository: sl.get<ProfileRepositoryImpl>(),
    ),
  );

  sl.registerFactory<UpdateUserProfile>(
    () => UpdateUserProfile(profileRepository: sl.get<ProfileRepositoryImpl>()),
  );

  sl.registerFactory<UpdateUserPhone>(
    () => UpdateUserPhone(profileRepository: sl.get<ProfileRepositoryImpl>()),
  );

  sl.registerFactory<GetCachedProfileUsecase>(
    () => GetCachedProfileUsecase(
      profileRepository: sl.get<ProfileRepositoryImpl>(),
    ),
  );

  // Todos
  sl.registerFactory<TodoLocalDatasource>(
    () => TodoLocalDatasource(localDB: cacheDB),
  );
  sl.registerFactory<TodoRemoteDatasource>(
    () => TodoRemoteDatasource(dioClient: sl.get<DioClient>(), flavor: flavor),
  );

  sl.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      todoRemoteDatasource: sl.get<TodoRemoteDatasource>(),
      todoLocalDatasource: sl.get<TodoLocalDatasource>(),
    ),
  );

  sl.registerFactory<GetCachedTodosUsecase>(
    () => GetCachedTodosUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  sl.registerFactory<RefreshTodosUsecase>(
    () => RefreshTodosUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<CreateTodoUsecase>(
    () => CreateTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<UpdateTodoUsecase>(
    () => UpdateTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<CompleteTodoUsecase>(
    () => CompleteTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  sl.registerFactory<DeleteTodoUsecase>(
    () => DeleteTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  sl.registerFactory<SyncTodosWithGoogleTasksUsecase>(
    () => SyncTodosWithGoogleTasksUsecase(
      todoRepository: sl.get<TodoRepository>(),
    ),
  );

  sl.registerFactory<TodoBloc>(
    () => TodoBloc(
      syncTodosWithGoogleTasksUsecase: sl(),
      getCachedTodosUsecase: sl(),
      refreshTodosUsecase: sl(),
      createTodoUsecase: sl(),
      updateTodoUsecase: sl(),
      deleteTodoUsecase: sl(),
      completeTodoUsecase: sl(),
    ),
  );

  // Agenda
  sl.registerFactory<AgendaEventLocalDataSource>(
    () => AgendaEventLocalDataSource(localDB: cacheDB),
  );
  sl.registerFactory<AgendaEventRemoteDatasource>(
    () => AgendaEventRemoteDatasource(
      dioClient: sl.get<DioClient>(),
      flavor: flavor,
    ),
  );

  sl.registerFactory<AgendaEventRepository>(
    () => AgendaEventRepositoryImpl(
      agendaEventRemoteDatasource: sl.get<AgendaEventRemoteDatasource>(),
      agendaEventLocalDataSource: sl.get<AgendaEventLocalDataSource>(),
    ),
  );

  sl.registerFactory<GetCachedAgendaEventsUsecase>(
    () => GetCachedAgendaEventsUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<RefreshAgendaEventsUsecase>(
    () => RefreshAgendaEventsUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<CreateAgendaEventUsecase>(
    () => CreateAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<UpdateAgendaEventUsecase>(
    () => UpdateAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<DeleteAgendaEventUsecase>(
    () => DeleteAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<AgendaEventBloc>(
    () => AgendaEventBloc(
      getCachedAgendaEventsUsecase: sl.get<GetCachedAgendaEventsUsecase>(),
      refreshAgendaEventsUsecase: sl.get<RefreshAgendaEventsUsecase>(),
      createAgendaEventUsecase: sl.get<CreateAgendaEventUsecase>(),
      updateAgendaEventUsecase: sl.get<UpdateAgendaEventUsecase>(),
      deleteAgendaEventUsecase: sl.get<DeleteAgendaEventUsecase>(),
    ),
  );

  // Communities
  sl.registerFactory<CommunityRemoteDatasource>(
    () => CommunityRemoteDatasource(
      dioClient: sl.get<DioClient>(),
      flavor: flavor,
    ),
  );

  sl.registerFactory<CommunityLocalDatasource>(
    () => CommunityLocalDatasource(localDB: sl()),
  );

  sl.registerFactory<CommunityRepositoryImpl>(
    () => CommunityRepositoryImpl(
      remoteDatasource: sl.get(),
      communityLocalDatasource: sl.get(),
    ),
  );

  sl.registerFactory<CreateCommunityUseCase>(
    () => CreateCommunityUseCase(repository: sl.get<CommunityRepositoryImpl>()),
  );

  sl.registerFactory<GetCommunityByIdUseCase>(
    () =>
        GetCommunityByIdUseCase(repository: sl.get<CommunityRepositoryImpl>()),
  );

  sl.registerFactory<ModerateMembersUseCase>(
    () => ModerateMembersUseCase(repository: sl.get<CommunityRepositoryImpl>()),
  );

  sl.registerFactory<DeleteCommunityUseCase>(
    () => DeleteCommunityUseCase(repository: sl.get<CommunityRepositoryImpl>()),
  );

  sl.registerFactory<GetCommunityMembersUsecase>(
    () => GetCommunityMembersUsecase(
      repository: sl.get<CommunityRepositoryImpl>(),
    ),
  );

  sl.registerFactory<AddCommunityGuidelinesUsecase>(
    () => AddCommunityGuidelinesUsecase(
      repository: sl.get<CommunityRepositoryImpl>(),
    ),
  );

  sl.registerFactory<GetPostableCommunitiesUsecase>(
    () => GetPostableCommunitiesUsecase(
      communityRepository: sl.get<CommunityRepositoryImpl>(),
    ),
  );

  sl.registerFactory(
    () => SearchForCommunityUsecase(
      communityRepository: sl.get<CommunityRepositoryImpl>(),
    ),
  );

  sl.registerFactory(
    () => CommunityListingCubit(
      getPostableCommunitiesUsecase: sl(),
      searchForCommunityUsecase: sl(),
    ),
  );

  sl.registerFactory<CommunityHomeBloc>(
    () => CommunityHomeBloc(
      getCommunityByIdUseCase: sl.get<GetCommunityByIdUseCase>(),
      deleteCommunityUseCase: sl.get<DeleteCommunityUseCase>(),
      addCommunityGuidelinesUsecase: sl.get<AddCommunityGuidelinesUsecase>(),
    ),
  );

  sl.registerFactory<CreateCommunityBloc>(
    () => CreateCommunityBloc(
      createCommunityUseCase: sl.get<CreateCommunityUseCase>(),
    ),
  );

  sl.registerFactory<CommunityUsersBloc>(
    () => CommunityUsersBloc(
      getCommunityMembersUsecase: sl.get<GetCommunityMembersUsecase>(),
    ),
  );

  /*************************************************************************
                                    CHIRP
  *************************************************************************/
  //                        --- Chirp Users ---
  sl.registerFactory<ChirpUserLocalDataSource>(
    () => ChirpUserLocalDataSource(localDB: sl()),
  );
  sl.registerFactory(
    () => ChirpUserRemoteDataSource(dioClient: sl(), flavor: flavor),
  );
  sl.registerFactory<ChirpUserRepository>(
    () => ChirpUserRepositoryImpl(
      chirpRemoteDataSource: sl(),
      chirpUserLocalDataSource: sl(),
    ),
  );

  sl.registerFactory(() => GetChirpUserByIdUsecase(chirpUserRepository: sl()));
  sl.registerFactory(
    () => GetChirpUserByUsernameUsecase(chirpUserRepository: sl()),
  );
  sl.registerFactory<ChirpUserCubit>(
    () => ChirpUserCubit(
      getChirpUserByIdUsecase: sl(),
      getChirpUserByUsernameUsecase: sl(),
    ),
  );

  // -- Memberships
  sl.registerFactory<ChirpCommunityMembershipLocalDatasource>(
    () => ChirpCommunityMembershipLocalDatasource(localDB: sl()),
  );
  sl.registerFactory<ChirpCommunityMembershipRemoteDatasource>(
    () => ChirpCommunityMembershipRemoteDatasource(
      dioClient: sl(),
      flavor: flavor,
    ),
  );
  sl.registerFactory<ChirpCommunityMembershipRepository>(
    () => ChirpCommunityMembershipRepositoryImpl(
      chirpCommunityMembershipLocalDatasource: sl(),
      chirpCommunityMembershipRemoteDatasource: sl(),
    ),
  );

  sl.registerFactory<GetCachedPersonalChirpCommunityMemberships>(
    () => GetCachedPersonalChirpCommunityMemberships(repository: sl()),
  );

  sl.registerFactory<GetCommunityMembershipsUsecase>(
    () => GetCommunityMembershipsUsecase(communityMembershipRepository: sl()),
  );

  sl.registerFactory<GetRemotePersonalChirpMembershipsUsecase>(
    () => GetRemotePersonalChirpMembershipsUsecase(repository: sl()),
  );

  sl.registerFactory<JoinCommunityUsecase>(
    () => JoinCommunityUsecase(chirpCommunityMembershipRepository: sl()),
  );
  sl.registerFactory<LeaveCommunityUsecase>(
    () => LeaveCommunityUsecase(repository: sl()),
  );

  sl.registerFactory<GetPersonalCommunityMembershipForCommunityUsecase>(
    () => GetPersonalCommunityMembershipForCommunityUsecase(repository: sl()),
  );

  //                    --- Posts ----
  sl.registerFactory<ChirpPostLocalDataSource>(
    () => ChirpPostLocalDataSource(db: sl()),
  );
  sl.registerFactory<ChirpRemoteDataSource>(
    () => ChirpRemoteDataSource(dioClient: sl.get<DioClient>(), flavor: flavor),
  );
  sl.registerFactory<ChirpRepository>(
    () => ChirpRepositoryImpl(
      remoteDataSource: sl.get<ChirpRemoteDataSource>(),
      localDataSource: sl<ChirpPostLocalDataSource>(),
    ),
  );
  sl.registerFactory(() => GetFeedPostsUsecase(sl()));
  sl.registerFactory<GetPostsFromCommunityUsecase>(
    () => GetPostsFromCommunityUsecase(repository: sl()),
  );
  sl.registerFactory(
    () => CreatePostUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => CreatePostAttachmentUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => GetPostDetailUseCase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => MarkPostAsViewedUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => GetPostCommentsUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => AddCommentUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => DeletePostUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => DeletePostCommentUsecase(repository: sl.get<ChirpRepository>()),
  );

  // sl.registerFactory(
  //   () => LikePostUsecase(chirpRepository: sl.get<ChirpRepository>()),
  // );
  sl.registerFactory(
    () => FeedBloc(
      getPostsFromCommunityUsecase: sl<GetPostsFromCommunityUsecase>(),
      getFeedPosts: sl.get<GetFeedPostsUsecase>(),
      createPost: sl.get<CreatePostUsecase>(),
      getPostDetail: sl.get<GetPostDetailUseCase>(),
      markPostAsViewed: sl.get<MarkPostAsViewedUsecase>(),
      createPostAttachment: sl.get<CreatePostAttachmentUsecase>(),
      deletePost: sl.get<DeletePostUsecase>(),
      // likePost: sl.get<LikePostUsecase>(),
      // addComment: sl.get<CommentUsecase>(),
      // getPostReplies: sl.get<GetPostRepliesUsecase>(),
    ),
  );
  sl.registerFactory(
    () => CommentBloc(
      addComment: sl.get<AddCommentUsecase>(),
      getPostComments: sl.get<GetPostCommentsUsecase>(),
    ),
  );

  /*************************************************************************
                              // NOTIFICATIONS
  *************************************************************************/
  sl.registerFactory<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasource(),
  );
  sl.registerFactory<NotificationLocalDatasource>(
    () => NotificationLocalDatasource(localDB: cacheDB),
  );

  sl.registerFactory<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDatasource: sl.get<NotificationRemoteDatasource>(),
      localDatasource: sl.get<NotificationLocalDatasource>(),
    ),
  );

  sl.registerFactory<InitializeLocalNotificationsUsecase>(
    () => InitializeLocalNotificationsUsecase(
      notificationRepository: sl.get<NotificationRepository>(),
    ),
  );

  sl.registerFactory<InitializeOneSignalUsecase>(
    () => InitializeOneSignalUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<GetNotificationsUsecase>(
    () => GetNotificationsUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<MarkNotificationAsReadUsecase>(
    () => MarkNotificationAsReadUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<MarkAllNotificationsAsReadUsecase>(
    () => MarkAllNotificationsAsReadUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<DeleteNotificationUsecase>(
    () => DeleteNotificationUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<ClearAllNotificationsUsecase>(
    () => ClearAllNotificationsUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<GetNotificationCountUsecase>(
    () => GetNotificationCountUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<GetUnreadCountUsecase>(
    () => GetUnreadCountUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<SetNotificationPermissionUsecase>(
    () => SetNotificationPermissionUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<GetNotificationPermissionUsecase>(
    () => GetNotificationPermissionUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<SendLocalNotificationUsecase>(
    () => SendLocalNotificationUsecase(sl.get<NotificationRepository>()),
  );
  sl.registerFactory<SetUserDataUsecase>(
    () => SetUserDataUsecase(repository: sl.get<NotificationRepository>()),
  );

  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      initializeLocalNotificationsUsecase: sl
          .get<InitializeLocalNotificationsUsecase>(),
      initializeOneSignalUsecase: sl.get<InitializeOneSignalUsecase>(),
      getNotificationsUsecase: sl.get<GetNotificationsUsecase>(),
      markNotificationAsReadUsecase: sl.get<MarkNotificationAsReadUsecase>(),
      markAllNotificationsAsReadUsecase: sl
          .get<MarkAllNotificationsAsReadUsecase>(),
      deleteNotificationUsecase: sl.get<DeleteNotificationUsecase>(),
      clearAllNotificationsUsecase: sl.get<ClearAllNotificationsUsecase>(),
      getNotificationCountUsecase: sl.get<GetNotificationCountUsecase>(),
      getUnreadCountUsecase: sl.get<GetUnreadCountUsecase>(),
      setNotificationPermissionUsecase: sl
          .get<SetNotificationPermissionUsecase>(),
      getNotificationPermissionUsecase: sl
          .get<GetNotificationPermissionUsecase>(),
      sendLocalNotificationUsecase: sl.get<SendLocalNotificationUsecase>(),
      setUserDataUsecase: sl.get<SetUserDataUsecase>(),
    ),
  );

  // Firebase Remote Config
  sl.registerSingleton<FirebaseRemoteConfig>(FirebaseRemoteConfig.instance);
  sl.registerFactory<RemoteConfigRemoteDatasource>(
    () => RemoteConfigRemoteDatasource(remoteConfig: sl()),
  );
  sl.registerFactory<RemoteConfigRepository>(
    () => RemoteConfigRepositoryImpl(
      remoteDatasource: sl.get<RemoteConfigRemoteDatasource>(),
    ),
  );

  sl.registerFactory<InitializeRemoteConfigUsecase>(
    () => InitializeRemoteConfigUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<FetchAndActivateUsecase>(
    () => FetchAndActivateUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetStringUsecase>(
    () => GetStringUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetBoolUsecase>(
    () => GetBoolUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetIntUsecase>(
    () => GetIntUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetDoubleUsecase>(
    () => GetDoubleUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetJsonUsecase>(
    () => GetJsonUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<GetAllParametersUsecase>(
    () => GetAllParametersUsecase(sl.get<RemoteConfigRepository>()),
  );
  sl.registerFactory<RemoteConfigBloc>(
    () => RemoteConfigBloc(
      initializeUsecase: sl.get<InitializeRemoteConfigUsecase>(),
      fetchAndActivateUsecase: sl.get<FetchAndActivateUsecase>(),
      getStringUsecase: sl.get<GetStringUsecase>(),
      getBoolUsecase: sl.get<GetBoolUsecase>(),
      getIntUsecase: sl.get<GetIntUsecase>(),
      getDoubleUsecase: sl.get<GetDoubleUsecase>(),
      getJsonUsecase: sl.get<GetJsonUsecase>(),
      getAllParametersUsecase: sl.get<GetAllParametersUsecase>(),
    ),
  );

  // --- Institutions ---
  sl.registerFactory<InstitutionLocalDatasource>(
    () => InstitutionLocalDatasource(localDB: sl<AppDataBase>()),
  );
  sl.registerFactory<InstitutionRemoteDatasource>(
    () => InstitutionRemoteDatasource(dioClient: sl(), flavor: flavor),
  );

  sl.registerFactory<InstitutionRepositoryImpl>(
    () => InstitutionRepositoryImpl(
      institutionLocalDatasource: sl(),
      institutionRemoteDatasource: sl(),
    ),
  );

  sl.registerFactory<GetAllUserAccountInstitutionsUsecase>(
    () => GetAllUserAccountInstitutionsUsecase(
      institutionRepository: sl<InstitutionRepositoryImpl>(),
    ),
  );

  sl.registerFactory<GetAllCachedInstitutionsUsecase>(
    () => GetAllCachedInstitutionsUsecase(
      institutionRepository: sl<InstitutionRepositoryImpl>(),
    ),
  );

  sl.registerFactory<AddAccountToInstitution>(
    () => AddAccountToInstitution(
      institutionRepository: sl<InstitutionRepositoryImpl>(),
    ),
  );

  sl.registerFactory<SearchForInstitutionByNameUsecase>(
    () => SearchForInstitutionByNameUsecase(
      institutionRepository: sl<InstitutionRepositoryImpl>(),
    ),
  );

  sl.registerFactory<InstitutionBloc>(
    () => InstitutionBloc(
      addAccountToInstitution: sl(),
      getAllCachedInstitutionsUsecase: sl(),
      searchForInstitutionByNameUsecase: sl(),
      getAllUserAccountInstitutionsUsecase: sl(),
    ),
  );

  // Exam Timetable
  // Data sources
  sl.registerFactory(() => ExamTimetableLocalDataSource(localDB: sl()));
  sl.registerFactory(
    () => ExamTimetableRemoteDatasource(dioClient: sl(), flavor: sl()),
  );

  // Repository
  sl.registerFactory<ExamTimetableRepository>(
    () => ExamTimetableRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerFactory(() => GetCachedExamsUseCase(sl()));
  sl.registerFactory(() => GetExamTimetableUseCase(sl()));
  sl.registerFactory(() => CacheExamsUseCase(sl()));
  sl.registerFactory(() => RefreshExamTimetableUseCase(sl()));
  sl.registerFactory(() => DeleteExamByCourseCodeUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => ExamTimetableBloc(
      getCachedExamsUseCase: sl(),
      getExamTimetableUseCase: sl(),
      cacheExamsUseCase: sl(),
      refreshExamTimetableUseCase: sl(),
      deleteExamByCourseCodeUseCase: sl(),
    ),
  );

  // Magnet
  sl.registerFactory<MagnetCredentialsLocalDatasource>(
    () => MagnetCredentialsLocalDatasource(localDB: sl()),
  );
  sl.registerFactory<MagnetStudentProfileLocalDatasource>(
    () => MagnetStudentProfileLocalDatasource(localDB: sl()),
  );
  sl.registerFactory<MagnetCourseLocalDataSource>(
    () => MagnetCourseLocalDataSource(localDB: sl()),
  );

  sl.registerFactory<MagnetRepositoryImpl>(
    () => MagnetRepositoryImpl(
      magnetCredentialsLocalDatasource: sl(),
      magnetStudentProfileLocalDatasource: sl(),
      magnetCourseLocalDataSource: sl(),
    ),
  );

  // -- Usecases
  sl.registerFactory<MagnetLoginUsecase>(
    () => MagnetLoginUsecase(magnetRepository: sl<MagnetRepositoryImpl>()),
  );
  sl.registerFactory<GetCachedMagnetCredentialUsecase>(
    () => GetCachedMagnetCredentialUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<GetMagnetAuthenticationStatusUsecase>(
    () => GetMagnetAuthenticationStatusUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<GetCachedMagnetStudentProfileUsecase>(
    () => GetCachedMagnetStudentProfileUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<FetchMagnetStudentProfileUsecase>(
    () => FetchMagnetStudentProfileUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<FetchMagnetStudentTimetableUsecase>(
    () => FetchMagnetStudentTimetableUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<GetCachedMagnetStudentTimetableUsecase>(
    () => GetCachedMagnetStudentTimetableUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );

  sl.registerFactory<DeleteMagentCourseByCourseCodeUsecase>(
    () => DeleteMagentCourseByCourseCodeUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );
  sl.registerFactory<FetchMagnetFinancialFeesStatementsUsecase>(
    () => FetchMagnetFinancialFeesStatementsUsecase(
      magnetRepository: sl<MagnetRepositoryImpl>(),
    ),
  );

  // -- Bloc
  sl.registerFactory<MagnetBloc>(
    () => MagnetBloc(
      magnetLoginUsecase: sl(),
      getCachedMagnetCredentialUsecase: sl(),
      getMagnetAuthenticationStatusUsecase: sl(),
      fetchMagnetStudentProfileUsecase: sl(),
      getCachedMagnetStudentProfileUsecase: sl(),
      fetchMagnetStudentTimetableUsecase: sl(),
      deleteMagentCourseByCourseCodeUsecase: sl(),
      getCachedMagnetStudentTimetableUsecase: sl(),
      fetchMagnetFinancialFeesStatementsUsecase: sl(),
    ),
  );

  // Permissions
  sl.registerFactory<PermissionDatasource>(() => PermissionDatasourceImpl());
  sl.registerFactory<PermissionRepository>(
    () => PermissionRepositoryImpl(permissionDatasource: sl()),
  );
  sl.registerFactory<RequestPermissionUsecase>(
    () => RequestPermissionUsecase(permissionRepository: sl()),
  );
  sl.registerFactory<CheckPermissionUsecase>(
    () => CheckPermissionUsecase(permissionRepository: sl()),
  );
  sl.registerFactory<PermissionCubit>(
    () => PermissionCubit(
      checkPermissionUsecase: sl(),
      requestPermissionUsecase: sl(),
    ),
  );

  /**********************************************************************
  *                               LEADERBOARD
  **********************************************************************/
  sl.registerFactory<LeaderboardLocalDataSource>(
    () => LeaderboardLocalDataSource(localDB: sl()),
  );
  sl.registerFactory<LeaderboardRemoteDataSource>(
    () => LeaderboardRemoteDataSource(dioClient: sl(), flavor: sl()),
  );
  sl.registerFactory<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(
      leaderboardRemoteDataSource: sl(),
      leaderboardLocalDataSource: sl(),
    ),
  );
  sl.registerFactory<GetGlobalLeaderboardUsecase>(
    () => GetGlobalLeaderboardUsecase(leaderboardRepository: sl()),
  );

  sl.registerFactory(() => LeaderboardBloc(getGlobalLeaderboardUsecase: sl()));

  /**********************************************************************
  *                               STREAKS
  **********************************************************************/
  sl.registerFactory<AchievementLocalDatasource>(
    () => AchievementLocalDatasource(localDB: sl<AppDataBase>()),
  );

  sl.registerFactory<AchievementRemoteDatasource>(
    () => AchievementRemoteDatasource(dioClient: sl(), flavor: sl()),
  );

  sl.registerFactory<AchievementRepository>(
    () => AchievementRepositoryImpl(
      remoteDatasource: sl<AchievementRemoteDatasource>(),
      localDatasource: sl<AchievementLocalDatasource>(),
    ),
  );

  sl.registerFactory<GetAchievements>(
    () => GetAchievements(sl<AchievementRepository>()),
  );

  sl.registerFactory<GetAchievementById>(
    () => GetAchievementById(sl<AchievementRepository>()),
  );

  sl.registerFactory<GetStreakActivities>(
    () => GetStreakActivities(sl<AchievementRepository>()),
  );

  sl.registerFactory<GetActivityById>(
    () => GetActivityById(sl<AchievementRepository>()),
  );

  sl.registerFactory<AchievementsBloc>(
    () => AchievementsBloc(getAchievements: sl<GetAchievements>()),
  );

  sl.registerFactory<ActivitiesBloc>(
    () => ActivitiesBloc(getStreakActivities: sl<GetStreakActivities>()),
  );

  sl.registerFactory<AchievementDetailBloc>(
    () => AchievementDetailBloc(
      getAchievementById: sl<GetAchievementById>(),
      getActivityById: sl<GetActivityById>(),
    ),
  );

  sl.registerFactory<ActivityDetailBloc>(
    () => ActivityDetailBloc(getActivityById: sl<GetActivityById>()),
  );
}
