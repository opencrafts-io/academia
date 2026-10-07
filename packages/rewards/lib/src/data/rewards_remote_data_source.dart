import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'api_paths.dart';
import 'dtos/account_dto.dart';
import 'dtos/activity_completion_dto.dart';
import 'dtos/activity_history_page_dto.dart';
import 'dtos/activity_page_dto.dart';
import 'dtos/complete_activity_request_dto.dart';
import 'dtos/milestone_page_dto.dart';
import 'dtos/user_streaks_dto.dart';

abstract interface class RewardsRemoteDataSource {
  Future<Either<Failure, AccountDto>> getAccount();
  Future<Either<Failure, ActivityPageDto>> getActiveActivities();
  Future<Either<Failure, ActivityCompletionDto>> completeActivity(
    CompleteActivityRequestDto request,
  );
  Future<Either<Failure, UserStreaksDto>> getStreaks();
  Future<Either<Failure, MilestonePageDto>> getActiveMilestones();
  Future<Either<Failure, ActivityHistoryPageDto>> getActivityHistory(
    String accountId,
  );
}

class RewardsRemoteDataSourceImpl implements RewardsRemoteDataSource {
  const RewardsRemoteDataSourceImpl(this._apiClient, this._paths);

  final ApiClient _apiClient;
  final RewardsApiPaths _paths;

  @override
  Future<Either<Failure, AccountDto>> getAccount() => _apiClient.get(
    _paths.account,
    decoder: (json) => AccountDto.fromJson(json as Map<String, dynamic>),
  );

  @override
  Future<Either<Failure, ActivityPageDto>> getActiveActivities() =>
      _apiClient.get(
        _paths.activities,
        queryParameters: const {'page': 1, 'page_size': 100},
        decoder: (json) =>
            ActivityPageDto.fromJson(json as Map<String, dynamic>),
      );

  @override
  Future<Either<Failure, ActivityCompletionDto>> completeActivity(
    CompleteActivityRequestDto request,
  ) => _apiClient.post(
    _paths.completeActivity,
    data: request.toJson(),
    decoder: (json) =>
        ActivityCompletionDto.fromJson(json as Map<String, dynamic>),
  );

  @override
  Future<Either<Failure, UserStreaksDto>> getStreaks() => _apiClient.get(
    _paths.streaks,
    decoder: (json) => UserStreaksDto.fromJson(json as Map<String, dynamic>),
  );

  @override
  Future<Either<Failure, MilestonePageDto>> getActiveMilestones() =>
      _apiClient.get(
        _paths.milestones,
        queryParameters: const {'page': 1, 'page_size': 100},
        decoder: (json) =>
            MilestonePageDto.fromJson(json as Map<String, dynamic>),
      );

  @override
  Future<Either<Failure, ActivityHistoryPageDto>> getActivityHistory(
    String accountId,
  ) => _apiClient.get(
    _paths.activityHistory(accountId),
    queryParameters: const {'page': 1, 'page_size': 20},
    decoder: (json) =>
        ActivityHistoryPageDto.fromJson(json as Map<String, dynamic>),
  );
}
