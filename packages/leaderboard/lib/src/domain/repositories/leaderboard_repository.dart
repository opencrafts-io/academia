import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/leaderboard_page.dart';

abstract interface class LeaderboardRepository {
  Future<Either<Failure, LeaderboardPage>> getGlobalPage({
    required int page,
    int pageSize = 20,
  });

  Future<Either<Failure, LeaderboardPage>> getAroundUser({
    required String accountId,
    int limit = 20,
  });
}
