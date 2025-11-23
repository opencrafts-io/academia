import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/data/data.dart';
import 'package:academia/features/streaks/domain/domain.dart';
import 'package:dartz/dartz.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  final AchievementRemoteDatasource remoteDatasource;
  final AchievementLocalDatasource localDatasource;

  AchievementRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, PaginatedAchievements>> getAchievements(
      {int page = 1, int pageSize = 100, bool forceRefresh = false}) async {
    // For the initial load, try the local cache first.
    if (page == 1 && !forceRefresh) {
      final localResult = await localDatasource.getAchievements();
      if (localResult.isRight() && localResult.getOrElse(() => []).isNotEmpty) {
        final achievements = localResult.getOrElse(() => []);
        return Right((
          entries: achievements,
          hasNext: false, // Cannot determine from cache
          totalCount: achievements.length,
        ));
      }
    }

    // If it's a refresh, pagination, or the cache is empty, fetch from remote.
    final remoteResult = await remoteDatasource.getAchievements(page: page, pageSize: pageSize);

    return remoteResult.fold(
      (failure) {
        // If remote fetch fails, return the error.
        return Left(failure);
      },
      (paginatedData) {
        // On successful remote fetch, update the cache.
        // This handles cache invalidation on page 1 or refresh.
        if (page == 1) {
          localDatasource.deleteAll();
          localDatasource.cacheAchievements(paginatedData.entries);
        }
        return Right(paginatedData);
      },
    );
  }

  @override
  Future<Either<Failure, StreakMilestoneData>> getAchievementById(String id) async {
    return await localDatasource.getAchievementById(id);
  }
}
