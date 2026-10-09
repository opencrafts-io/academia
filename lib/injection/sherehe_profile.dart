part of '../injection_container.dart';

void _registerShereheAndProfile(
  GetIt sl,
  FlavorConfig flavor,
  AppDataBase cacheDB,
) {
  //sherehe
  sl.registerFactory<ShereheRemoteDataSource>(
    () => ShereheRemoteDataSource(dioClient: sl.get<DioClient>(), flavor: sl()),
  );
  sl.registerFactory(() => CreateEventUseCase(sl.get<ShereheRepository>()));
  sl.registerFactory<ShereheLocalDataSource>(
    () => ShereheLocalDataSource(localDB: cacheDB),
  );

  sl.registerFactory<ShereheRepository>(
    () => ShereheRepositoryImpl(
      remoteDataSource: sl.get<ShereheRemoteDataSource>(),
      localDataSource: sl.get<ShereheLocalDataSource>(),
    ),
  );

  sl.registerFactory<GetEvent>(() => GetEvent(sl()));
  sl.registerFactory(() => GetSpecificEvent(sl()));
  sl.registerFactory(() => GetEventsByOrganizerIdUseCase(sl()));
  sl.registerFactory(() => GetAttendee(sl()));
  sl.registerFactory(() => GetAllAttendees(sl()));
  sl.registerFactory(() => CacheEventsUseCase(sl()));
  sl.registerFactory(() => GetTicketsByEventIdUseCase(sl()));
  sl.registerFactory(() => PurchaseTicketUseCase(sl()));
  sl.registerFactory(() => ConfirmPaymentUseCase(sl()));
  sl.registerFactory(() => GetAllUserPurchasedTicketsUseCase(sl()));
  sl.registerFactory(() => SearchUserAttendedEventsUseCase(sl()));
  sl.registerFactory(() => GetTicketByInviteUsecase(sl()));
  sl.registerFactory(() => GetEventByInviteUsecase(sl()));

  sl.registerFactory(() => GetUserPurchasedTicketsForEventUseCase(sl()));

  sl.registerFactory(() => ValidateAttendeeUseCase(sl()));

  sl.registerFactory(() => SearchEventsUseCase(sl()));

  sl.registerFactory(() => GetAttendeesAndScannersUsecase(sl()));

  sl.registerFactory(() => GetDashboardTicketStatsUsecase(sl()));

  sl.registerFactory(() => UpdateTicketUsecase(sl()));
  sl.registerFactory(() => GetAllEventScannersUsecase(sl()));
  sl.registerFactory(() => SearchUsersByUsernameUsecase(sl()));
  sl.registerFactory(() => AddEventScannerUsecase(sl()));
  sl.registerFactory(() => DeleteEventScannerUsecase(sl()));
  sl.registerFactory(() => GetEventScannerByUserIdUsecase(sl()));

  sl.registerLazySingleton(() => GetEventInvitesUsecase(sl()));
  sl.registerLazySingleton(() => CreateEventInviteUsecase(sl()));
  sl.registerLazySingleton(() => UpdateEventInviteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteEventInviteUsecase(sl()));
  sl.registerLazySingleton(() => GetTicketInvitesUsecase(sl()));
  sl.registerLazySingleton(() => CreateTicketInviteUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTicketInviteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTicketInviteUsecase(sl()));
  sl.registerLazySingleton(() => CreateTicketUsecase(sl()));

  sl.registerLazySingleton(() => ShereheHomeBloc(getEvent: sl()));

  sl.registerFactory(
    () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(),
      getEventByInviteUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => GetEventScannerByUserIdBloc(getEventScannerByUserId: sl()),
  );

  sl.registerFactory(
    () => OrganizedEventsBloc(getEventsByOrganizerIdUseCase: sl()),
  );

  sl.registerFactory(() => CreateEventBloc(createEventUseCase: sl()));
  sl.registerFactory(
    () => UserTicketSelectionBloc(
      getTicketsByEventId: sl(),
      getTicketsByInvite: sl(),
    ),
  );
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
  sl.registerFactory(
    () => AttendeesAndScannerStatsBloc(getAttendeesAndScanners: sl()),
  );
  sl.registerFactory(
    () => TicketStatsBloc(
      getDashboardTicketStats: sl(),
      updateTicket: sl(),
      createTicket: sl(),
    ),
  );
  sl.registerFactory(() => AllAttendeesBloc(getAllAttendees: sl()));
  sl.registerFactory(() => AllScannersBloc(getAllScanners: sl()));
  sl.registerFactory(
    () => ScannerActionsBloc(
      searchUsersByUsername: sl(),
      addEventScanner: sl(),
      deleteEventScanner: sl(),
    ),
  );
  sl.registerFactory(
    () => EventLinkBloc(
      getEventInvites: sl(),
      createEventInvite: sl(),
      updateEventInvite: sl(),
      deleteEventInvite: sl(),
    ),
  );
  sl.registerFactory<TicketLinkBloc>(
    () => TicketLinkBloc(
      getTicketInvites: sl(),
      createTicketInvite: sl(),
      updateTicketInvite: sl(),
      deleteTicketInvite: sl(),
    ),
  );
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

  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      getCachedProfileUsecase: sl.get<GetCachedProfileUsecase>(),
      refreshCurrentUserProfileUsecase: sl
          .get<RefreshCurrentUserProfileUsecase>(),
      updateUserProfile: sl.get<UpdateUserProfile>(),
      updateUserPhone: sl.get<UpdateUserPhone>(),
      requestAccountDeletionUsecase: sl.get<RequestAccountDeletionUsecase>(),
      requestAccountRecoveryUsecase: sl.get<RequestAccountRecoveryUsecase>(),
      analyticsTracker: sl(),
      notificationIdentityService: sl(),
    ),
  );
}
