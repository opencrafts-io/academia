part of '../injection_container.dart';

void _registerCommunities(GetIt sl, FlavorConfig flavor) {
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
}
