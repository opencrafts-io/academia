import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/streaks/data/datasources/achievement_remote_datasource.dart';
import 'package:academia/features/streaks/domain/repositories/achievement_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetStreakActivities implements UseCase<PaginatedActivities, GetStreakActivitiesParams> {
  final AchievementRepository repository;

  GetStreakActivities(this.repository);

  @override
  Future<Either<Failure, PaginatedActivities>> call(GetStreakActivitiesParams params) async {
    return await repository.getStreakActivities(
      page: params.page,
      pageSize: params.pageSize,
      forceRefresh: params.forceRefresh,
    );
  }
}

class GetStreakActivitiesParams extends Equatable {
  final int page;
  final int pageSize;
  final bool forceRefresh;

  const GetStreakActivitiesParams({
    required this.page,
    required this.pageSize,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [page, pageSize, forceRefresh];
}
