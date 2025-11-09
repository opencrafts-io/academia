import 'package:academia/core/error/failures.dart';
import 'package:academia/features/leaderboard/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, PaginatedLeaderboard>> getGlobalLeaderBoard({
    required int page,
    int pageSize = 100,
    bool forceRefresh = false,
  });
}
