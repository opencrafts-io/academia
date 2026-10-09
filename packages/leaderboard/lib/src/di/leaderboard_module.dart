import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../data/api_paths.dart';
import '../data/leaderboard_remote_data_source.dart';
import '../data/leaderboard_repository_impl.dart';
import '../domain/domain.dart';
import '../presentation/leaderboard_bloc.dart';

void configureLeaderboardDependencies(GetIt getIt) {
  getIt.registerLazySingleton(() => LeaderboardApiPaths(getIt<FlavorConfig>()));
  getIt.registerLazySingleton<LeaderboardRemoteDataSource>(
    () => LeaderboardRemoteDataSourceImpl(
      getIt<ApiClient>(),
      getIt<LeaderboardApiPaths>(),
    ),
  );
  getIt.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(getIt<LeaderboardRemoteDataSource>()),
  );
  getIt.registerFactory(
    () => GetGlobalLeaderboard(getIt<LeaderboardRepository>()),
  );
  getIt.registerFactory(
    () => GetLeaderboardAroundUser(getIt<LeaderboardRepository>()),
  );
  getIt.registerFactory(
    () => LeaderboardBloc(
      getGlobalLeaderboard: getIt<GetGlobalLeaderboard>(),
      getLeaderboardAroundUser: getIt<GetLeaderboardAroundUser>(),
    ),
  );
}
