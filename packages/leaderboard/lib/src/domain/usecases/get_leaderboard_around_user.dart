import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/leaderboard_page.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboardAroundUser {
  const GetLeaderboardAroundUser(this._repository);

  final LeaderboardRepository _repository;

  Future<Either<Failure, LeaderboardPage>> call({
    required String accountId,
    int limit = 20,
  }) => _repository.getAroundUser(accountId: accountId, limit: limit);
}
