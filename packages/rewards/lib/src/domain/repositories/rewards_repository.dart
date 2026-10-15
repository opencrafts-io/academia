import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/account.dart';
import '../entities/activity.dart';
import '../entities/activity_completion.dart';
import '../entities/activity_history.dart';
import '../entities/milestone.dart';
import '../entities/user_streak.dart';

abstract interface class RewardsRepository {
  Future<Either<Failure, RewardAccount>> getAccount();
  Future<Either<Failure, List<EarnableActivity>>> getActiveActivities();
  Future<Either<Failure, ActivityCompletion>> completeActivity({
    required String accountId,
    required String activityId,
    required String idempotencyKey,
  });
  Future<Either<Failure, List<UserStreak>>> getStreaks();
  Future<Either<Failure, List<RewardMilestone>>> getActiveMilestones();
  Future<Either<Failure, List<ActivityHistory>>> getActivityHistory(
    String accountId,
  );
}
