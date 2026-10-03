import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/study_tools_api_paths.dart';
import '../data/datasources/study_tools_local_datasource.dart';
import '../data/datasources/study_tools_remote_datasource.dart';
import '../data/repositories/study_tools_repository_impl.dart';
import '../domain/repositories/study_tools_repository.dart';
import '../presentation/cubit/study_tools_cubit.dart';

void configureStudyToolsDependencies(
  GetIt getIt,
  FlavorConfig flavor, {
  required String Function() accountId,
}) {
  getIt.registerLazySingleton(() => StudyToolsApiPaths(flavor));
  getIt.registerLazySingleton<StudyToolsRemoteDatasource>(
    () => StudyToolsRemoteDatasourceImpl(
      getIt<ApiClient>(),
      getIt<StudyToolsApiPaths>(),
    ),
  );
  getIt.registerLazySingleton<StudyToolsLocalDatasource>(
    () => SharedPreferencesStudyToolsDatasource(
      scope: () => '${flavor.flavorName}_${accountId()}',
    ),
  );
  getIt.registerLazySingleton<StudyToolsRepository>(
    () => StudyToolsRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerFactory(() => StudyToolsCubit(getIt<StudyToolsRepository>()));
}
