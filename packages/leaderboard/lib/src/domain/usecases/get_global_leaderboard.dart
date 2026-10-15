import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/leaderboard_page.dart';
import '../repositories/leaderboard_repository.dart';

class GetGlobalLeaderboard {
  const GetGlobalLeaderboard(this._repository);

  final LeaderboardRepository _repository;

  Future<Either<Failure, LeaderboardPage>> call({
    required int page,
    int pageSize = 20,
  }) => _repository.getGlobalPage(page: page, pageSize: pageSize);
}
