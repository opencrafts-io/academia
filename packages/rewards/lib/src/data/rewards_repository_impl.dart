import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../domain/domain.dart';
import 'dtos/complete_activity_request_dto.dart';
import 'rewards_remote_data_source.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  const RewardsRepositoryImpl(this._remoteDataSource);

  final RewardsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, RewardAccount>> getAccount() async {
    final result = await _remoteDataSource.getAccount();
    return result.fold((failure) => Left(failure), (dto) {
      if (dto.id.isEmpty) {
        return Left(
          Failure.validation(
            message: 'The account response did not include an account ID.',
            code: 'ACCOUNT_ID_MISSING',
          ),
        );
      }
      return Right(dto.toDomain());
    });
  }

  @override
  Future<Either<Failure, List<EarnableActivity>>> getActiveActivities() async {
    final result = await _remoteDataSource.getActiveActivities();
    return result.map(
      (page) => page.results
          .where((activity) => activity.id.isNotEmpty)
          .map((activity) => activity.toDomain())
          .toList(growable: false),
    );
  }

  @override
  Future<Either<Failure, ActivityCompletion>> completeActivity({
    required String accountId,
    required String activityId,
    required String idempotencyKey,
  }) async {
    final result = await _remoteDataSource.completeActivity(
      CompleteActivityRequestDto(
        accountId: accountId,
        activityId: activityId,
        idempotencyKey: idempotencyKey,
        metadata: const CompletionMetadataDto(
          source: 'android',
          event: 'app_launch',
        ),
      ),
    );
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, List<UserStreak>>> getStreaks() async {
    final result = await _remoteDataSource.getStreaks();
    return result.map(
      (streaks) => streaks.map((streak) => streak.toDomain()).toList(),
    );
  }

  @override
  Future<Either<Failure, List<RewardMilestone>>> getActiveMilestones() async {
    final result = await _remoteDataSource.getActiveMilestones();
    return result.map(
      (page) => page.results.map((milestone) => milestone.toDomain()).toList(),
    );
  }

  @override
  Future<Either<Failure, List<ActivityHistory>>> getActivityHistory(
    String accountId,
  ) async {
    final result = await _remoteDataSource.getActivityHistory(accountId);
    return result.map(
      (page) =>
          page.results.map((completion) => completion.toDomain()).toList(),
    );
  }
}
