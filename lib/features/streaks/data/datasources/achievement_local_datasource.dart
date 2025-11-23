import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:drift/drift.dart';

class AchievementLocalDatasource {
  final AppDataBase localDB;

  AchievementLocalDatasource({required this.localDB});

  Future<Either<Failure, List<StreakMilestoneData>>> getAchievements() async {
    try {
      final achievements = await localDB.select(localDB.streakMilestone).get();
      return right(achievements);
    } catch (e) {
      return left(CacheFailure(message: "Failed to get cached achievements", error: e));
    }
  }

  Future<Either<Failure, StreakMilestoneData>> getAchievementById(String id) async {
    try {
      final achievement = await (localDB.select(localDB.streakMilestone)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return right(achievement);
    } catch (e) {
      return left(CacheFailure(message: "Achievement not found in cache", error: e));
    }
  }

  Future<Either<Failure, void>> cacheAchievements(
      List<StreakMilestoneData> achievements) async {
    try {
      await localDB.batch((batch) {
        batch.insertAll(
          localDB.streakMilestone,
          achievements,
          mode: InsertMode.insertOrReplace,
        );
      });
      return right(null);
    } catch (e) {
      return left(CacheFailure(message: "Failed to cache achievements", error: e));
    }
  }

  Future<Either<Failure, void>> deleteAll() async {
    try {
      await localDB.delete(localDB.streakMilestone).go();
      return right(null);
    } catch (e) {
      return left(CacheFailure(message: "Failed to clear cached achievements", error: e));
    }
  }
}
