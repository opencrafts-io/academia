import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../domain/domain.dart';
import 'leaderboard_remote_data_source.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  const LeaderboardRepositoryImpl(this._remoteDataSource);

  final LeaderboardRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, LeaderboardPage>> getGlobalPage({
    required int page,
    int pageSize = 20,
  }) async {
    final result = await _remoteDataSource.getGlobalPage(
      page: page,
      pageSize: pageSize,
    );
    return result.map((dto) {
      return LeaderboardPage(
        entries: dto.results.map((entry) => entry.toDomain()).toList(),
        totalUsers: dto.count,
        userPosition: null,
        hasNext: dto.next != null || page * pageSize < dto.count,
        currentPage: page,
      );
    });
  }

  @override
  Future<Either<Failure, LeaderboardPage>> getAroundUser({
    required String accountId,
    int limit = 20,
  }) async {
    final result = await _remoteDataSource.getAroundUser(
      accountId: accountId,
      limit: limit,
    );
    return result.map((dto) {
      final position = dto.userPosition;
      final rows = dto.rows;
      return LeaderboardPage(
        entries: rows
            .map(
              (row) => row.toDomain(
                displayPosition:
                    (row.id == accountId || row.accountId == accountId) &&
                        row.position == 0
                    ? position
                    : null,
              ),
            )
            .toList(growable: false),
        totalUsers: dto.totalUsers,
        userPosition: position,
        hasNext: false,
        currentPage: 1,
      );
    });
  }
}
