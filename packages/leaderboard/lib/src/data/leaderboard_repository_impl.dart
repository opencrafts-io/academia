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
        entries: dto.results
            .asMap()
            .entries
            .map(
              (row) => row.value.toDomain(
                displayPosition: ((page - 1) * pageSize) + row.key + 1,
              ),
            )
            .toList(growable: false),
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
      final rows = dto.results;
      return LeaderboardPage(
        entries: rows
            .map(
              (row) => row.toDomain(
                displayPosition:
                    row.id == accountId && row.position == null
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
