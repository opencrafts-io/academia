import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class LeaderboardLocalDataSource {
  final AppDataBase localDB;

  LeaderboardLocalDataSource({required this.localDB});

  /// Watch all leaderboard entries (real-time updates)
  Stream<List<LeaderboardRankData>> watchLeaderboard() {
    return (localDB.select(localDB.leaderboardRank)..orderBy([
          (t) => OrderingTerm(expression: t.vibeRank, mode: OrderingMode.asc),
        ]))
        .watch()
        .map((entries) => entries.map((e) => e).toList());
  }

  /// Watch single entry by id
  Stream<LeaderboardRankData?> watchEntryById(String id) {
    return (localDB.select(
      localDB.leaderboardRank,
    )..where((t) => t.id.equals(id))).watchSingleOrNull().map((entry) => entry);
  }

  /// Get all cached leaderboard entries
  Future<Either<Failure, List<LeaderboardRankData>>>
  getCachedLeaderboard() async {
    try {
      final entries =
          await (localDB.select(localDB.leaderboardRank)..orderBy([
                (t) => OrderingTerm(
                  expression: t.vibeRank,
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
              "Looks like we hit a stairway to nowhere! We couldn't retrieve the leaderboard from local cache. The database is having a mystical moment!",
        ),
      );
    }
  }

  /// Get paginated cached entries
  Future<Either<Failure, List<LeaderboardRankData>>>
  getPaginatedCachedLeaderboard({
    required int limit,
    required int offset,
  }) async {
    try {
      final entries =
          await (localDB.select(localDB.leaderboardRank)
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.vibeRank,
                    mode: OrderingMode.asc,
                  ),
                ])
                ..limit(limit, offset: offset))
              .get();

      return right(entries.map((e) => e).toList());
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Don't Stop Believin'" - Journey
              "Don't stop believin'! We couldn't load that page of the leaderboard. Hold on to that feeling and try again!",
        ),
      );
    }
  }

  /// Get top N entries
  Future<Either<Failure, List<LeaderboardRankData>>> getTopEntries(
    int limit,
  ) async {
    try {
      final entries =
          await (localDB.select(localDB.leaderboardRank)
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.vibeRank,
                    mode: OrderingMode.asc,
                  ),
                ])
                ..limit(limit))
              .get();

      return right(entries.map((e) => e).toList());
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "We Are the Champions" - Queen
              "We are the champions, but we can't show them! Failed to fetch the top players from cache.",
        ),
      );
    }
  }

  /// Get entry by id
  Future<Either<Failure, LeaderboardRankData?>> getEntryById(String id) async {
    try {
      final entry = await (localDB.select(
        localDB.leaderboardRank,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      return right(entry);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Where Is My Mind?" - Pixies
              "Where is my mind? We couldn't find that user in the leaderboard cache!",
        ),
      );
    }
  }

  /// Search by username
  Future<Either<Failure, List<LeaderboardRankData>>> searchByUsername(
    String query,
  ) async {
    try {
      final entries =
          await (localDB.select(localDB.leaderboardRank)
                ..where((t) => t.username.like('%$query%'))
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.vibeRank,
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
              // "Somebody That I Used to Know" - Gotye
              "Now you're just somebody that I used to know! Search failed in the local cache.",
        ),
      );
    }
  }

  /// Create or update single leaderboard entry
  Future<Either<Failure, LeaderboardRankData>> createOrUpdateEntry(
    LeaderboardRankData entry,
  ) async {
    try {
      final created = await localDB
          .into(localDB.leaderboardRank)
          .insertReturning(entry, onConflict: DoUpdate((old) => entry));

      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Under Pressure" - Queen & David Bowie
              "Under pressure! We couldn't save that leaderboard entry locally. The database is feeling the squeeze!",
        ),
      );
    }
  }

  /// Cache multiple leaderboard entries (batch insert/update)
  Future<Either<Failure, void>> cacheLeaderboard(
    List<LeaderboardRankCompanion> entries,
  ) async {
    try {
      // Delete expired entries first
      await deleteExpiredEntries();

      // Batch insert with timestamp
      final entriesWithTimestamp = entries.map((entry) {
        return entry.copyWith(cachedAt: Value(DateTime.now()));
      }).toList();

      await localDB.batch((batch) {
        batch.insertAll(
          localDB.leaderboardRank,
          entriesWithTimestamp,
          mode: InsertMode.replace,
        );
      });

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Highway to Hell" - AC/DC
              "We're on a highway to hell! Couldn't cache the leaderboard. The database is having a hard time!",
        ),
      );
    }
  }

  /// Update vibe points and rank for a user
  Future<Either<Failure, int>> updateVibePoints({
    required String id,
    required int newPoints,
    required int newRank,
  }) async {
    try {
      final updated =
          await (localDB.update(
            localDB.leaderboardRank,
          )..where((t) => t.id.equals(id))).write(
            LeaderboardRankCompanion(
              vibePoints: Value(newPoints),
              vibeRank: Value(newRank),
              updatedAt: Value(DateTime.now()),
            ),
          );

      return right(updated);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Changes" - David Bowie
              "Ch-ch-ch-changes! We couldn't update those vibe points. The database is stuck in time!",
        ),
      );
    }
  }

  /// Delete entry by id
  Future<Either<Failure, void>> deleteEntry(String id) async {
    try {
      await (localDB.delete(
        localDB.leaderboardRank,
      )..where((t) => t.id.equals(id))).go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Another One Bites the Dust" - Queen
              "Another one bites the dust... but not this one! Failed to delete the leaderboard entry.",
        ),
      );
    }
  }

  /// Clear all cached leaderboard entries
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDB.delete(localDB.leaderboardRank).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Wipe Out" - The Surfaris
              "Wipe out! We tried to clear the cache but crashed on the beach instead!",
        ),
      );
    }
  }

  /// Delete expired entries (older than 2 hours)
  Future<Either<Failure, int>> deleteExpiredEntries() async {
    try {
      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));

      final deletedCount = await (localDB.delete(
        localDB.leaderboardRank,
      )..where((t) => t.cachedAt.isSmallerThanValue(twoHoursAgo))).go();

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

  /// Check if cache is expired (older than 2 hours)
  Future<Either<Failure, bool>> isCacheExpired() async {
    try {
      final entries = await (localDB.select(
        localDB.leaderboardRank,
      )..limit(1)).get();

      if (entries.isEmpty) return right(true);

      final cacheTime = entries.first.cachedAt;
      if (cacheTime == null) return right(true);

      final now = DateTime.now();
      final difference = now.difference(cacheTime);

      return right(difference.inHours >= 2);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Time Is On My Side" - The Rolling Stones
              "Time is on my side... but we can't tell if the cache expired! Database hiccup!",
        ),
      );
    }
  }

  /// Get cache age in minutes
  Future<Either<Failure, int?>> getCacheAgeInMinutes() async {
    try {
      final entries = await (localDB.select(
        localDB.leaderboardRank,
      )..limit(1)).get();

      if (entries.isEmpty || entries.first.cachedAt == null) {
        return right(null);
      }

      final now = DateTime.now();
      final difference = now.difference(entries.first.cachedAt!);

      return right(difference.inMinutes);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Does Anybody Really Know What Time It Is?" - Chicago
              "Does anybody really know what time it is? We can't figure out the cache age!",
        ),
      );
    }
  }

  /// Get last cache time
  Future<Either<Failure, DateTime?>> getLastCacheTime() async {
    try {
      final entries = await (localDB.select(
        localDB.leaderboardRank,
      )..limit(1)).get();

      if (entries.isEmpty) return right(null);

      return right(entries.first.cachedAt);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Yesterday" - The Beatles
              "Yesterday, all my troubles seemed so far away... but we can't retrieve the cache time today!",
        ),
      );
    }
  }

  /// Get count of cached entries
  Future<Either<Failure, int>> getEntriesCount() async {
    try {
      final countExp = localDB.leaderboardRank.id.count();
      final query = localDB.selectOnly(localDB.leaderboardRank)
        ..addColumns([countExp]);
      final result = await query.getSingle();

      return right(result.read(countExp) ?? 0);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Count on Me" - Bruno Mars
              "You can count on me... but I can't count the leaderboard entries right now!",
        ),
      );
    }
  }

  /// Get user rank by id
  Future<Either<Failure, int?>> getUserRank(String userId) async {
    try {
      final user = await (localDB.select(
        localDB.leaderboardRank,
      )..where((t) => t.id.equals(userId))).getSingleOrNull();

      return right(user?.vibeRank);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Lose Yourself" - Eminem
              "You only get one shot, one opportunity... and we lost it trying to find your rank!",
        ),
      );
    }
  }
}
