import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../data/api_paths.dart';
import '../data/rewards_remote_data_source.dart';
import '../data/rewards_repository_impl.dart';
import '../domain/domain.dart';
import '../presentation/rewards_cubit.dart';

void configureRewardsDependencies(GetIt getIt) {
  getIt.registerLazySingleton(() => RewardsApiPaths(getIt<FlavorConfig>()));
  getIt.registerLazySingleton<RewardsRemoteDataSource>(
    () => RewardsRemoteDataSourceImpl(
      getIt<ApiClient>(),
      getIt<RewardsApiPaths>(),
    ),
  );
  getIt.registerLazySingleton<RewardsRepository>(
    () => RewardsRepositoryImpl(getIt<RewardsRemoteDataSource>()),
  );
  getIt.registerFactory(() => GetRewardsOverview(getIt<RewardsRepository>()));
  getIt.registerFactory(() => GetRewardAccount(getIt<RewardsRepository>()));
  getIt.registerFactory(
    () => RecordAppLaunch(
      getIt<RewardsRepository>(),
      configuredActivityId: const String.fromEnvironment(
        'VERISAFE_APP_LAUNCH_ACTIVITY_ID',
      ),
    ),
  );
  getIt.registerFactory(() => RewardsCubit(getIt<GetRewardsOverview>()));
}
