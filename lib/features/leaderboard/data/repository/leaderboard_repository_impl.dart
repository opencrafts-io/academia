import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/leaderboard/data/data.dart';
import 'package:academia/features/leaderboard/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardLocalDataSource leaderboardLocalDataSource;
  final LeaderboardRemoteDataSource leaderboardRemoteDataSource;

  LeaderboardRepositoryImpl({
    required this.leaderboardRemoteDataSource,
    required this.leaderboardLocalDataSource,
  });

  @override
  Future<Either<Failure, PaginatedLeaderboard>> getGlobalLeaderBoard({
    required int page,
    int pageSize = 100,
    bool forceRefresh = false,
  }) async {
    // Check if cache is expired
    final cacheExpiredResult = await leaderboardLocalDataSource
        .isCacheExpired();
    final isCacheExpired = cacheExpiredResult.fold(
      (failure) => true, // Assume expired on cache check error
      (expired) => expired,
    );

    // Cache-first approach: Try cache for page 1 if not expired and not force refresh
    if (page == 1 && !forceRefresh && !isCacheExpired) {
      final cachedResult = await leaderboardLocalDataSource
          .getCachedLeaderboard();

      return cachedResult.fold(
        (failure) {
          // Cache failed, fetch from remote
          return _fetchFromRemoteAndCache(page, pageSize);
        },
        (cachedEntries) {
          if (cachedEntries.isNotEmpty) {
            // Convert cached data to domain entities
            final leaderboardRanks = cachedEntries
                .map((data) => data.toEntity())
                .toList();

            // Return cached data
            return Right(
              PaginatedLeaderboard(
                totalCount: cachedEntries.length,
                hasNext: false,
                hasPrevious: false,
                entries: leaderboardRanks,
                currentPage: 1,
              ),
            );
          }
          // Cache is empty, fetch from remote
          return _fetchFromRemoteAndCache(page, pageSize);
        },
      );
    }

    // For other pages, expired cache, or force refresh: fetch from remote
    if (page == 1) {
      return _fetchFromRemoteAndCache(page, pageSize);
    } else {
      // For pages > 1, just fetch without caching
      return _fetchFromRemote(page, pageSize);
    }
  }

  /// Fetch from remote and cache the results (for page 1 only)
  Future<Either<Failure, PaginatedLeaderboard>> _fetchFromRemoteAndCache(
    int page,
    int pageSize,
  ) async {
    final remoteResult = await leaderboardRemoteDataSource.getGlobalLeaderboard(
      page: page,
      pageSize: pageSize,
    );

    return remoteResult.fold(
      (failure) async {
        // Network failed, try to return cached data as fallback (even if expired)
        final cachedResult = await leaderboardLocalDataSource
            .getCachedLeaderboard();

        return cachedResult.fold(
          (cacheFailure) =>
              Left(failure), // Both failed, return network failure
          (cachedEntries) {
            if (cachedEntries.isNotEmpty) {
              // Convert cached data to domain entities
              final leaderboardRanks = cachedEntries
                  .map((data) => data.toEntity())
                  .toList();

              // Return stale cache data
              return Right(
                PaginatedLeaderboard(
                  totalCount: cachedEntries.length,
                  hasNext: false,
                  hasPrevious: false,
                  entries: leaderboardRanks,
                  currentPage: 1,
                ),
              );
            }
            return Left(failure); // No cache available, return network failure
          },
        );
      },
      (paginatedResponse) async {
        // Successfully fetched from remote, now cache it
        final companions = paginatedResponse.results.map((data) {
          return LeaderboardRankCompanion(
            id: Value(data.id),
            avatarUrl: Value(data.avatarUrl),
            email: Value(data.email),
            name: Value(data.name),
            username: Value(data.username),
            vibePoints: Value(data.vibePoints),
            vibeRank: Value(data.vibeRank),
            createdAt: Value(data.createdAt),
            updatedAt: Value(data.updatedAt),
            cachedAt: Value(DateTime.now()),
          );
        }).toList();

        // Clear old cache and insert new data
        await leaderboardLocalDataSource.clearCache();
        await leaderboardLocalDataSource.cacheLeaderboard(companions);

        // Convert remote data to domain entities
        final leaderboardRanks = paginatedResponse.results
            .map((data) => data.toEntity())
            .toList();

        // Calculate total pages for hasNext/hasPrevious
        final totalPages = (paginatedResponse.count / pageSize).ceil();

        return Right(
          PaginatedLeaderboard(
            totalCount: paginatedResponse.count,
            hasNext: paginatedResponse.next != null || page < totalPages,
            hasPrevious: paginatedResponse.previous != null || page > 1,
            entries: leaderboardRanks,
            currentPage: page,
          ),
        );
      },
    );
  }

  /// Fetch from remote without caching (for pages > 1)
  Future<Either<Failure, PaginatedLeaderboard>> _fetchFromRemote(
    int page,
    int pageSize,
  ) async {
    final remoteResult = await leaderboardRemoteDataSource.getGlobalLeaderboard(
      page: page,
      pageSize: pageSize,
    );

    return remoteResult.fold((failure) => Left(failure), (paginatedResponse) {
      // Convert remote data to domain entities
      final leaderboardRanks = paginatedResponse.results
          .map((data) => data.toEntity())
          .toList();

      // Calculate total pages for hasNext/hasPrevious
      final totalPages = (paginatedResponse.count / pageSize).ceil();

      return Right(
        PaginatedLeaderboard(
          totalCount: paginatedResponse.count,
          hasNext: paginatedResponse.next != null || page < totalPages,
          hasPrevious: paginatedResponse.previous != null || page > 1,
          entries: leaderboardRanks,
          currentPage: page,
        ),
      );
    });
  }
}
