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

    final remoteResult = await remoteDatasource.getAchievements(page: page, pageSize: pageSize);

    return remoteResult.fold(
      (failure) {
        return Left(failure);
      },
      (paginatedData) {
        if (page == 1) {
          localDatasource.deleteAll();
        }
        localDatasource.cacheAchievements(paginatedData.entries);
        return Right(paginatedData);
      },
    );
  }

  @override
  Future<Either<Failure, StreakMilestoneData>> getAchievementById(String id) async {
    return await localDatasource.getAchievementById(id);
  }

  @override
  Future<Either<Failure, StreakActivityData>> getActivityById(String id) async {
    return await localDatasource.getActivityById(id);
  }

  @override
  Future<Either<Failure, PaginatedActivities>> getStreakActivities(
      {int page = 1, int pageSize = 200, bool forceRefresh = false}) async {
    if (page == 1 && !forceRefresh) {
      final localResult = await localDatasource.getActivities();
      if (localResult.isRight() && localResult.getOrElse(() => []).isNotEmpty) {
        final activities = localResult.getOrElse(() => []);
        return Right((
          entries: activities,
          hasNext: false, // Cannot determine from cache
          totalCount: activities.length,
        ));
      }
    }

    final remoteResult = await remoteDatasource.getStreakActivities(page: page, pageSize: pageSize);

    return remoteResult.fold(
      (failure) {
        return Left(failure);
      },
      (paginatedData) {
        if (page == 1) {
          localDatasource.deleteAllActivities();
        }
        localDatasource.cacheActivities(paginatedData.entries);
        return Right(paginatedData);
      },
    );
  }
}
