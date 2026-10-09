import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/activity.dart';
import '../entities/activity_completion.dart';
import '../repositories/rewards_repository.dart';

class RecordAppLaunch {
  const RecordAppLaunch(this._repository, {this.configuredActivityId});

  final RewardsRepository _repository;
  final String? configuredActivityId;

  Future<Either<Failure, ActivityCompletion>> call({DateTime? now}) async {
    final accountResult = await _repository.getAccount();
    return accountResult.fold((failure) async => Left(failure), (
      account,
    ) async {
      final activitiesResult = await _repository.getActiveActivities();
      return activitiesResult.fold((failure) async => Left(failure), (
        activities,
      ) async {
        final activity = _resolveActivity(activities);
        if (activity == null) {
          return Left(
            Failure.validation(
              message: 'No active app launch reward is configured.',
              code: 'APP_LAUNCH_ACTIVITY_NOT_CONFIGURED',
            ),
          );
        }
        final date = (now ?? DateTime.now());
        final rewardDate =
            '${date.year.toString().padLeft(4, '0')}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}';
        return _repository.completeActivity(
          accountId: account.id,
          activityId: activity.id,
          idempotencyKey: 'app-launch:${account.id}:$rewardDate',
        );
      });
    });
  }

  EarnableActivity? _resolveActivity(List<EarnableActivity> activities) {
    if (configuredActivityId != null && configuredActivityId!.isNotEmpty) {
      for (final activity in activities) {
        if (activity.id == configuredActivityId) return activity;
      }
      return null;
    }
    for (final activity in activities) {
      final markers =
          [
            activity.code,
            activity.slug,
            activity.category,
            activity.name,
          ].whereType<String>().map(
            (value) => value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ''),
          );
      if (markers.any((value) => value == 'applaunch')) return activity;
    }
    return null;
  }
}
