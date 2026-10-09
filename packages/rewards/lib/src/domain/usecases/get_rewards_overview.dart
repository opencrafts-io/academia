import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/rewards_overview.dart';
import '../repositories/rewards_repository.dart';

class GetRewardsOverview {
  const GetRewardsOverview(this._repository);

  final RewardsRepository _repository;

  Future<Either<Failure, RewardsOverview>> call() async {
    final accountResult = await _repository.getAccount();
    return accountResult.fold((failure) async => Left(failure), (
      account,
    ) async {
      final activitiesResult = await _repository.getActiveActivities();
      final streaksResult = await _repository.getStreaks();
      final milestonesResult = await _repository.getActiveMilestones();
      final historyResult = await _repository.getActivityHistory(account.id);
      final activities = activitiesResult.fold(
        (failure) => null,
        (value) => value,
      );
      final streaks = streaksResult.fold((failure) => null, (value) => value);
      final milestones = milestonesResult.fold(
        (failure) => null,
        (value) => value,
      );
      final history = historyResult.fold((failure) => null, (value) => value);
      final failure =
          activitiesResult.fold((value) => value, (_) => null) ??
          streaksResult.fold((value) => value, (_) => null) ??
          milestonesResult.fold((value) => value, (_) => null) ??
          historyResult.fold((value) => value, (_) => null);
      if (failure != null) return Left(failure);
      return Right(
        RewardsOverview(
          account: account,
          activities: activities!,
          streaks: streaks!,
          milestones: milestones!,
          history: history!,
        ),
      );
    });
  }
}
