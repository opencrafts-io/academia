import 'package:academia/core/core.dart';
import 'package:academia/features/leaderboard/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetGlobalLeaderboardUsecaseParams {
  final int page;
  final int pageSize;
  final bool forceRefresh;

  GetGlobalLeaderboardUsecaseParams({
    required this.page,
    required this.pageSize,
    required this.forceRefresh,
  });
}

class GetGlobalLeaderboardUsecase
    extends UseCase<PaginatedLeaderboard, GetGlobalLeaderboardUsecaseParams> {
  final LeaderboardRepository leaderboardRepository;

  GetGlobalLeaderboardUsecase({required this.leaderboardRepository});

  @override
  Future<Either<Failure, PaginatedLeaderboard>> call(
    GetGlobalLeaderboardUsecaseParams params,
  ) async {
    return await leaderboardRepository.getGlobalLeaderBoard(
      page: params.page,
      pageSize: params.pageSize,
      forceRefresh: params.forceRefresh,
    );
  }
}
