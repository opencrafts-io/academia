import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/data/datasources/achievement_remote_datasource.dart';
import 'package:dartz/dartz.dart';

abstract class AchievementRepository {
  Future<Either<Failure, PaginatedAchievements>> getAchievements(
      {int page = 1, int pageSize = 100, bool forceRefresh = false});

  Future<Either<Failure, StreakMilestoneData>> getAchievementById(String id);

  Future<Either<Failure, PaginatedActivities>> getStreakActivities(
      {int page = 1, int pageSize = 200, bool forceRefresh = false});

  Future<Either<Failure, StreakActivityData>> getActivityById(String id);
}
