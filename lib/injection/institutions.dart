part of '../injection_container.dart';

void _registerInstitutions(GetIt sl, FlavorConfig flavor) {
  // --- Institutions ---
  sl.registerFactory<InstitutionLocalDatasource>(
    () => InstitutionLocalDatasource(localDB: sl<AppDataBase>()),
  );
  sl.registerFactory<InstitutionRemoteDatasource>(
    () => InstitutionRemoteDatasource(dioClient: sl(), flavor: flavor),
  );
  courses.configureCoursesDependencies(
    sl,
    institutionLookup: VerisafeInstitutionLookup(
      sl<InstitutionRemoteDatasource>(),
    ),
  );
  study_tools.configureStudyToolsDependencies(
    sl,
    flavor,
    accountId: () {
      final state = sl<ProfileBloc>().state;
      return state is ProfileLoadedState ? state.profile.id : null;
    },
  );
  study_tools.StudyToolsHost.loadCourses = () async {
    final cubit = sl<courses.CourseCubit>();
    await cubit.loadActive();
    final options = cubit.state.courses
        .map(
          (course) => study_tools.StudyCourseOption(
            id: course.serverId ?? 'local:${course.id}',
            title: course.title,
            professorId: course.serverId,
          ),
        )
        .toList(growable: false);
    await cubit.close();
    return options;
  };
  study_tools.StudyToolsHost.openPaywall = (context) async {
    await const billing.PaywallRoute(featureName: 'Study Tools').push(context);
    await sl<AdService>().refreshEligibility();
  };
  courses.CourseHost.openMaterials = (context, course) async {
    await study_tools.StudyToolsRoute(
      courseId: course.serverId,
      courseLabel: course.title,
      courseLocalId: course.id,
    ).push(context);
  };
  study_tools.StudyToolsHost.openPodcastPlayer = (podcast) {
    AppRouter.router.push(
      study_tools.StudyPodcastPlayerRoute(
        materialId: podcast.noteId,
        episodeKey: study_tools.PodcastLocalStore.episodeKey(podcast),
      ).location,
    );
  };
  sl.registerLazySingleton<courses.CourseReminderRefresher>(
    () => CourseScheduleReminderService(
      repository: sl<courses.CourseRepository>(),
      scheduler: sl<LocalNotificationScheduler>(),
      permissions: sl<PermissionGateway>(),
    ),
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

  sl.registerLazySingleton<InstitutionKeySecureDatasource>(
    () => InstitutionKeySecureDatasource(),
  );

  sl.registerFactory<InstitutionKeyRepository>(
    () => InstitutionKeyRepositoryImpl(
      localDataSource: sl(),
      secureDataSource: sl(),
    ),
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

  sl.registerFactory<RemoveAccountFromInstitutionUsecase>(
    () => RemoveAccountFromInstitutionUsecase(
      repository: sl<InstitutionRepositoryImpl>(),
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
  sl.registerFactory<FetchInstitutionScrappingCommandUsecase>(
    () => FetchInstitutionScrappingCommandUsecase(repository: sl()),
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
      removeAccountFromInstitutionUsecase: sl(),
      addAccountToInstitution: sl(),
      getAllCachedInstitutionsUsecase: sl(),
      searchForInstitutionByNameUsecase: sl(),
      getAllUserAccountInstitutionsUsecase: sl(),
      analyticsTracker: sl(),
    ),
  );

  sl.registerFactory<ScrappingCommandBloc>(
    () => ScrappingCommandBloc(getInstitutionScrappingCommandUsecase: sl()),
  );
}
