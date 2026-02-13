import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init(FlavorConfig flavor, {bool isBackground = false}) async {
  if (!isBackground) {
    final DioRequestInspector inspector = DioRequestInspector(
      isInspectorEnabled: kDebugMode,
      showSummary: false,
    );
    sl.registerSingleton<DioRequestInspector>(inspector);
  }

  // Register the flavor
  sl.registerSingleton<FlavorConfig>(flavor);

  final cacheDB = sl.registerSingleton<AppDataBase>(AppDataBase());

  if (!isBackground) {
    final AdService adService = AdService();
    await adService.initialize();
    adService.loadInterstitialAd();

    sl.registerSingleton<AdService>(adService);
  }

  sl.registerFactory<AuthLocalDatasource>(
    () => AuthLocalDatasource(localDB: cacheDB),
  );

  sl.registerFactory<DioClient>(
    () => DioClient(
      flavor,
      authLocalDatasource: sl.get<AuthLocalDatasource>(),
      requestInspector: isBackground ? null : sl<DioRequestInspector>(),
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

  sl.registerSingleton<ShereheRepository>(
    ShereheRepositoryImpl(
      remoteDataSource: sl.get<ShereheRemoteDataSource>(),
      localDataSource: sl.get<ShereheLocalDataSource>(),
    ),
  );

  sl.registerSingleton<GetEvent>(GetEvent(sl()));
  sl.registerLazySingleton(() => GetSpecificEvent(sl()));
  sl.registerLazySingleton(() => GetEventsByOrganizerIdUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendee(sl()));
  sl.registerLazySingleton(() => CacheEventsUseCase(sl()));
  sl.registerLazySingleton(() => GetTicketsByEventIdUseCase(sl()));
  sl.registerLazySingleton(() => PurchaseTicketUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmPaymentUseCase(sl()));
  sl.registerLazySingleton(() => GetAllUserPurchasedTicketsUseCase(sl()));
  sl.registerLazySingleton(() => SearchUserAttendedEventsUseCase(sl()));

  sl.registerLazySingleton(() => GetUserPurchasedTicketsForEventUseCase(sl()));

  sl.registerLazySingleton(() => ValidateAttendeeUseCase(sl()));

  sl.registerLazySingleton(() => SearchEventsUseCase(sl()));

  sl.registerFactory(() => ShereheHomeBloc(getEvent: sl()));

  sl.registerFactory(() => ShereheDetailsBloc(getSpecificEventUseCase: sl()));

  sl.registerFactory(
    () => OrganizedEventsBloc(getEventsByOrganizerIdUseCase: sl()),
  );

  sl.registerFactory(() => CreateEventBloc(createEventUseCase: sl()));
  sl.registerFactory(() => UserTicketSelectionBloc(getTicketsByEventId: sl()));
  sl.registerFactory(
    () => TicketPaymentBloc(purchaseTicket: sl(), confirmPayment: sl()),
  );
  sl.registerFactory(
    () => AllUserEventTicketsBloc(
      getUserTicketsForEvent: sl(),
      searchUserAttendedEvents: sl(),
    ),
  );
  sl.registerFactory(
    () => UserEventTicketsBloc(getUserPurchasedTicketsForEvent: sl()),
  );
  sl.registerFactory(() => ValidateAttendeeBloc(validateAttendeeUseCase: sl()));
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
  sl.registerFactory<RequestAccountDeletionUsecase>(
    () => RequestAccountDeletionUsecase(
      profileRepository: sl.get<ProfileRepositoryImpl>(),
    ),
  );
  sl.registerFactory<RequestAccountRecoveryUsecase>(
    () => RequestAccountRecoveryUsecase(
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

  //     ---Block and Report----

  sl.registerFactory(
    () => BlockBloc(
      blockUser: sl(),
      blockCommunity: sl(),
      unblockById: sl(),
      getBlocks: sl(),
      checkBlockStatus: sl(),
    ),
  );

  sl.registerFactory(() => ReportBloc(reportContent: sl(), getReports: sl()));

  //Use Cases
  sl.registerFactory(() => BlockUser(sl()));
  sl.registerFactory(() => BlockCommunity(sl()));
  sl.registerFactory(() => UnblockById(sl()));
  sl.registerFactory(() => GetBlocks(sl()));
  sl.registerFactory(() => CheckBlockStatus(sl()));
  sl.registerFactory(() => ReportContent(sl()));
  sl.registerFactory(() => GetReports(sl()));

  // Repository
  sl.registerFactory<InteractionsRepository>(
    () => InteractionsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  //Data Sources
  sl.registerFactory<InteractionsRemoteDataSource>(
    () => InteractionsRemoteDataSource(dioClient: sl(), flavor: sl()),
  );

  sl.registerFactory<InteractionsLocalDataSource>(
    () => InteractionsLocalDataSource(db: sl()),
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
  if(!isBackground) {
    sl.registerSingleton<FirebaseRemoteConfig>(FirebaseRemoteConfig.instance);
    sl.registerFactory<RemoteConfigRemoteDatasource>(
          () => RemoteConfigRemoteDatasource(remoteConfig: sl()),
    );
    sl.registerFactory<RemoteConfigRepository>(
          () =>
          RemoteConfigRepositoryImpl(
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
          () =>
          RemoteConfigBloc(
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
  }

  // --- Institutions ---
  sl.registerFactory<InstitutionLocalDatasource>(
    () => InstitutionLocalDatasource(localDB: sl<AppDataBase>()),
  );
  sl.registerFactory<InstitutionRemoteDatasource>(
    () => InstitutionRemoteDatasource(dioClient: sl(), flavor: flavor),
  );

  sl.registerFactory<InstitutionCommandLocalDatasource>(
    () => InstitutionCommandLocalDatasource(appDataBase: sl()),
  );
  sl.registerFactory<InstitutionCommandRemoteDatasource>(
    () => InstitutionCommandRemoteDatasource(flavor: flavor, dioClient: sl()),
  );

  sl.registerFactory<InstitutionKeyLocalDatasource>(
    () => InstitutionKeyLocalDatasource(appDataBase: sl()),
  );

  sl.registerFactory<InstitutionKeyRepository>(
    () => InstitutionKeyRepositoryImpl(localDataSource: sl()),
  );
  // --- Student Profile Datasources ---
  sl.registerFactory<InstitutionProfileLocalDatasource>(
    () => InstitutionProfileLocalDatasource(appDataBase: sl<AppDataBase>()),
  );

  sl.registerFactory<InstitutionProfileRemoteDatasource>(
    () => InstitutionProfileRemoteDatasource(
      dioClient: sl<DioClient>(),
      flavor: flavor,
    ),
  );

  sl.registerFactory<InstitutionFeesLocalDatasource>(
    () => InstitutionFeesLocalDatasourceImpl(sl()),
  );

  sl.registerFactory<InstitutionFeesRepository>(
    () => InstitutionFeesRepositoryImpl(localDatasource: sl()),
  );

  // --- Student Profile Repository ---
  sl.registerFactory<StudentProfileRepository>(
    () => StudentProfileRepositoryImpl(
      remoteDatasource: sl<InstitutionProfileRemoteDatasource>(),
      localDatasource: sl<InstitutionProfileLocalDatasource>(),
    ),
  );

  sl.registerFactory<InstitutionRepositoryImpl>(
    () => InstitutionRepositoryImpl(
      institutionLocalDatasource: sl(),
      institutionRemoteDatasource: sl(),
    ),
  );

  sl.registerFactory<InstitutionCommandRepository>(
    () => InstitutionScrappingCommandRepositoryImpl(
      institutionCommandLocalDatasource: sl(),
      institutionCommandRemoteDatasource: sl(),
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

  sl.registerFactory<GetInstitutionKeyUsecase>(
    () => GetInstitutionKeyUsecase(repository: sl()),
  );
  sl.registerFactory<SaveInstitutionKeyUsecase>(
    () => SaveInstitutionKeyUsecase(repository: sl()),
  );

  sl.registerFactory<GetInstitutionScrappingCommandUsecase>(
    () => GetInstitutionScrappingCommandUsecase(repository: sl()),
  );

  // --- Student Profile Usecases ---
  // Watch Usecases
  sl.registerFactory<WatchProfileByIdUsecase>(
    () => WatchProfileByIdUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<WatchProfileByUserAndInstitutionUsecase>(
    () => WatchProfileByUserAndInstitutionUsecase(
      repository: sl<StudentProfileRepository>(),
    ),
  );

  sl.registerFactory<WatchProfilesByUserUsecase>(
    () =>
        WatchProfilesByUserUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<WatchLatestProfileByStudentUsecase>(
    () => WatchLatestProfileByStudentUsecase(
      repository: sl<StudentProfileRepository>(),
    ),
  );

  // Fetch Usecases
  sl.registerFactory<FetchProfileByIdUsecase>(
    () => FetchProfileByIdUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<FetchProfilesUsecase>(
    () => FetchProfilesUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<FetchCurrentUserProfileUsecase>(
    () => FetchCurrentUserProfileUsecase(
      repository: sl<StudentProfileRepository>(),
    ),
  );

  // Create Usecase
  sl.registerFactory<CreateProfileUsecase>(
    () => CreateProfileUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<SyncInstitutionProfileUsecase>(
    () => SyncInstitutionProfileUsecase(createProfileUsecase: sl()),
  );

  // Update Usecases
  sl.registerFactory<UpdateProfileUsecase>(
    () => UpdateProfileUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<PartialUpdateProfileUsecase>(
    () =>
        PartialUpdateProfileUsecase(repository: sl<StudentProfileRepository>()),
  );

  // Delete Usecases
  sl.registerFactory<DeleteProfileUsecase>(
    () => DeleteProfileUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<DeleteUserProfilesUsecase>(
    () => DeleteUserProfilesUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<ClearProfileCacheUsecase>(
    () => ClearProfileCacheUsecase(repository: sl<StudentProfileRepository>()),
  );

  sl.registerFactory<WatchInstitutionFees>(() => WatchInstitutionFees(sl()));

  sl.registerFactory<WatchAllFees>(() => WatchAllFees(sl()));

  sl.registerFactory<SaveFeeTransaction>(() => SaveFeeTransaction(sl()));

  sl.registerFactory<InstitutionFeesBloc>(
    () => InstitutionFeesBloc(
      watchInstitutionFees: sl(),
      saveFeeTransaction: sl(),
    ),
  );

  sl.registerFactory<InstitutionKeyBloc>(
    () => InstitutionKeyBloc(
      getInstitutionKeyUsecase: sl(),
      saveInstitutionKeyUsecase: sl(),
    ),
  );

  sl.registerFactory<StudentProfileBloc>(
    () => StudentProfileBloc(
      watchProfileByIdUsecase: sl<WatchProfileByIdUsecase>(),
      watchProfilesByUserAndInstitutionUsecase:
          sl<WatchProfileByUserAndInstitutionUsecase>(),
      watchProfilesByUserUsecase: sl<WatchProfilesByUserUsecase>(),
      watchLatestProfileByStudentUsecase:
          sl<WatchLatestProfileByStudentUsecase>(),
      fetchProfileByIdUsecase: sl<FetchProfileByIdUsecase>(),
      fetchProfilesUsecase: sl<FetchProfilesUsecase>(),
      fetchCurrentUserProfileUsecase: sl<FetchCurrentUserProfileUsecase>(),
      createProfileUsecase: sl<CreateProfileUsecase>(),
      updateProfileUsecase: sl<UpdateProfileUsecase>(),
      partialUpdateProfileUsecase: sl<PartialUpdateProfileUsecase>(),
      deleteProfileUsecase: sl<DeleteProfileUsecase>(),
      deleteUserProfilesUsecase: sl<DeleteUserProfilesUsecase>(),
      clearProfileCacheUsecase: sl<ClearProfileCacheUsecase>(),
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

  sl.registerFactory<ScrappingCommandBloc>(
    () => ScrappingCommandBloc(getInstitutionScrappingCommandUsecase: sl()),
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

  /***************************************************************************************
   *                                     SEMESTER
   ***************************************************************************************/
  sl.registerFactory<SemesterLocalDatasource>(
    () => SemesterLocalDatasourceImpl(appDataBase: sl()),
  );

  sl.registerFactory<SemesterRepository>(
    () => SemesterRepositoryImpl(semesterLocalDatasource: sl()),
  );

  sl.registerFactory<CreateSemesterUsecase>(
    () => CreateSemesterUsecase(semesterRepository: sl()),
  );
  sl.registerFactory<DeleteSemesterUsecase>(
    () => DeleteSemesterUsecase(semesterRepository: sl()),
  );
  sl.registerFactory<UpdateSemesterUsecase>(
    () => UpdateSemesterUsecase(semesterRepository: sl()),
  );
  sl.registerFactory<WatchAllSemestersUsecase>(
    () => WatchAllSemestersUsecase(semesterRepository: sl()),
  );
  sl.registerFactory<GetSemestersForInstituionUsecase>(
    () => GetSemestersForInstituionUsecase(semesterRepository: sl()),
  );

  sl.registerFactory<GetSemesterByIdUsecase>(
    () => GetSemesterByIdUsecase(semesterRepository: sl()),
  );

  sl.registerFactory<SemesterCubit>(
    () => SemesterCubit(
      createSemesterUsecase: sl(),
      getSemesterByIdUsecase: sl(),
      deleteSemesterUsecase: sl(),
      getSemestersForInstitutionUsecase: sl(),
      updateSemesterUsecase: sl(),
      watchAllSemestersUsecase: sl(),
    ),
  );

  /**********************************************************************
   *                               Courses
   **********************************************************************/

  sl.registerFactory<CourseLocalDatasource>(
    () => CourseLocalDatasourceImpl(appDataBase: sl()),
  );

  sl.registerFactory<CourseRepository>(
    () => CourseRepositoryImpl(localDatasource: sl()),
  );

  sl.registerFactory<WatchAllCoursesUsecase>(
    () => WatchAllCoursesUsecase(sl()),
  );
  sl.registerFactory<SaveCourseUsecase>(() => SaveCourseUsecase(sl()));
  sl.registerFactory<DeleteCourseUsecase>(() => DeleteCourseUsecase(sl()));
  sl.registerFactory<WatchInstitutionCoursesUsecase>(
    () => WatchInstitutionCoursesUsecase(sl()),
  );
  sl.registerFactory<GetCourseUsecase>(() => GetCourseUsecase(sl()));

  sl.registerFactory<CourseCubit>(
    () => CourseCubit(
      getCourse: sl(),
      watchInstitutionCourses: sl(),
      watchAllCourses: sl(),
      saveCourse: sl(),
      deleteCourse: sl(),
    ),
  );

  /***************************************************************
   *                       Timetable
   ***************************************************************/

  sl.registerFactory<TimetableEntryLocalDatasource>(
    () => TimetableEntryLocalDatasourceImpl(appDataBase: sl()),
  );

  sl.registerFactory<TimetableLocalDatasource>(
    () => TimetableLocalDatasourceImpl(appDataBase: sl()),
  );

  sl.registerFactory<TimetableRepository>(
    () => TimetableRepositoryImpl(localDatasource: sl()),
  );

  sl.registerFactory<TimetableEntryRepository>(
    () => TimetableEntryRepositoryImpl(localDatasource: sl()),
  );

  sl.registerFactory<CreateOrUpdateTimetableEntry>(
    () => CreateOrUpdateTimetableEntry(sl()),
  );
  sl.registerFactory<CreateOrUpdateTimetableEntries>(
    () => CreateOrUpdateTimetableEntries(sl()),
  );
  sl.registerFactory<GetTimetableEntryById>(() => GetTimetableEntryById(sl()));
  sl.registerFactory<WatchAllTimetableEntries>(
    () => WatchAllTimetableEntries(sl()),
  );
  sl.registerFactory<WatchTimetableEntriesByTimetableId>(
    () => WatchTimetableEntriesByTimetableId(sl()),
  );
  sl.registerFactory<WatchTimetableEntriesByCourseId>(
    () => WatchTimetableEntriesByCourseId(sl()),
  );
  sl.registerFactory<WatchTimetableEntriesByUserId>(
    () => WatchTimetableEntriesByUserId(sl()),
  );
  sl.registerFactory<WatchTimetableEntriesByInstitutionId>(
    () => WatchTimetableEntriesByInstitutionId(sl()),
  );
  sl.registerFactory<DeleteTimetableEntry>(() => DeleteTimetableEntry(sl()));
  sl.registerFactory<DeleteTimetableEntries>(
    () => DeleteTimetableEntries(sl()),
  );
  sl.registerFactory<SyncTimetableEntries>(() => SyncTimetableEntries(sl()));
  sl.registerFactory<FetchTimetableEntriesFromRemote>(
    () => FetchTimetableEntriesFromRemote(sl()),
  );

  sl.registerFactory<CreateOrUpdateTimetable>(
    () => CreateOrUpdateTimetable(sl()),
  );
  sl.registerFactory<GetTimetableById>(() => GetTimetableById(sl()));
  sl.registerFactory<WatchAllTimetables>(() => WatchAllTimetables(sl()));
  sl.registerFactory<WatchTimetablesByUserId>(
    () => WatchTimetablesByUserId(sl()),
  );
  sl.registerFactory<WatchTimetablesByInstitutionId>(
    () => WatchTimetablesByInstitutionId(sl()),
  );
  sl.registerFactory<DeleteTimetable>(() => DeleteTimetable(sl()));
  sl.registerFactory<SyncTimetables>(() => SyncTimetables(sl()));
  sl.registerFactory<FetchTimetablesFromRemote>(
    () => FetchTimetablesFromRemote(sl()),
  );

  sl.registerFactory<TimetableBloc>(
    () => TimetableBloc(
      watchAllTimetables: sl(),
      watchTimetablesByUserId: sl(),
      watchTimetablesByInstitutionId: sl(),
      createOrUpdateTimetable: sl(),
      getTimetableById: sl(),
      deleteTimetable: sl(),
      syncTimetables: sl(),
      fetchTimetablesFromRemote: sl(),
    ),
  );

  sl.registerFactory<TimetableEntryBloc>(
    () => TimetableEntryBloc(
      watchAllTimetableEntries: sl(),
      watchTimetableEntriesByTimetableId: sl(),
      watchTimetableEntriesByCourseId: sl(),
      watchTimetableEntriesByUserId: sl(),
      watchTimetableEntriesByInstitutionId: sl(),
      createOrUpdateTimetableEntry: sl(),
      createOrUpdateTimetableEntries: sl(),
      getTimetableEntryById: sl(),
      deleteTimetableEntry: sl(),
      deleteTimetableEntries: sl(),
      syncTimetableEntries: sl(),
      fetchTimetableEntriesFromRemote: sl(),
    ),
  );

  sl.registerFactory<MagnetBloc>(
    () => MagnetBloc(
      createOrUpdateTimetableEntries: sl(),
      saveCourseUsecase: sl(),
      syncInstitutionProfileUsecase: sl(),
      saveFeeTransaction: sl(),
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

  sl.registerFactory(() => SettingsCubit());
}
