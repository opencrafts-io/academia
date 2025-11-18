import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class StreakActivityLocalDatasource {
  final AppDataBase localDB;

  StreakActivityLocalDatasource({required this.localDB});

  Future<Either<Failure, StreakActivityData>> createOrUpdateEntry(
    StreakActivityData entry,
  ) async {
    try {
      final created = await localDB
          .into(localDB.streakActivity)
          .insertReturning(entry, onConflict: DoUpdate((old) => entry));

      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Under Pressure" - Queen & David Bowie
              "Under pressure! We couldn't save that streak activity entry locally. The database is feeling the squeeze!",
        ),
      );
    }
  }

  Future<Either<Failure, List<StreakActivityData>>>
  getCachedStreakActivities() async {
    try {
      final entries =
          await (localDB.select(localDB.streakActivity)..orderBy([
                (t) => OrderingTerm(
                  expression: t.pointsAwarded,
                  mode: OrderingMode.asc,
                ),
              ]))
              .get();

      return right(entries.map((e) => e).toList());
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Stairway to Heaven" - Led Zeppelin
              "Looks like we hit a stairway to nowhere! We couldn't retrieve streak activities from local cache. The database is having a mystical moment!",
        ),
      );
    }
  }

  /// Get count of cached entries
  Future<Either<Failure, int>> getEntriesCount() async {
    try {
      final countExp = localDB.streakActivity.id.count();
      final query = localDB.selectOnly(localDB.streakActivity)
        ..addColumns([countExp]);
      final result = await query.getSingle();

      return right(result.read(countExp) ?? 0);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Count on Me" - Bruno Mars
              "You can count on me... but I can't count the streak activity entries right now!",
        ),
      );
    }
  }

  Future<Either<Failure, int>> deleteExpiredEntries() async {
    try {
      final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));

      final deletedCount = await (localDB.delete(
        localDB.streakActivity,
      )..where((t) => t.cachedAt.isSmallerThanValue(oneDayAgo))).go();

      return right(deletedCount);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Time After Time" - Cyndi Lauper
              "Time after time, we try to clean up expired entries but something went wrong!",
        ),
      );
    }
  }
}
