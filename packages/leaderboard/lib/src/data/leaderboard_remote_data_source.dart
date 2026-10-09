import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'api_paths.dart';
import 'leaderboard_around_dto.dart';
import 'leaderboard_page_dto.dart';

abstract interface class LeaderboardRemoteDataSource {
  Future<Either<Failure, LeaderboardPageDto>> getGlobalPage({
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, LeaderboardAroundDto>> getAroundUser({
    required String accountId,
    required int limit,
  });
}

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  const LeaderboardRemoteDataSourceImpl(this._apiClient, this._paths);

  final ApiClient _apiClient;
  final LeaderboardApiPaths _paths;

  @override
  Future<Either<Failure, LeaderboardPageDto>> getGlobalPage({
    required int page,
    required int pageSize,
  }) => _apiClient.get(
    _paths.global,
    queryParameters: {'page': page, 'page_size': pageSize},
    decoder: (json) =>
        LeaderboardPageDto.fromJson(json as Map<String, dynamic>),
  );

  @override
  Future<Either<Failure, LeaderboardAroundDto>> getAroundUser({
    required String accountId,
    required int limit,
  }) => _apiClient.get(
    _paths.around(accountId),
    queryParameters: {'limit': limit.clamp(1, 50).toInt()},
    decoder: (json) =>
        LeaderboardAroundDto.fromJson(json as Map<String, dynamic>),
  );
}
