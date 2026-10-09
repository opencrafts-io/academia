part of '../injection_container.dart';

void _registerAcademics(GetIt sl) {
  // Exam Timetable
  sl.registerLazySingleton<ExamNotificationService>(
    () => ExamNotificationServiceImpl(sl()),
  );

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
      examNotificationService: sl(),
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

  sl.registerFactory<MagnetBloc>(
    () => MagnetBloc(
      createScheduleEntry: sl<courses.CreateScheduleEntry>(),
      createCourse: sl<courses.CreateCourse>(),
      syncInstitutionProfileUsecase: sl(),
      saveFeeTransaction: sl(),
    ),
  );
}
