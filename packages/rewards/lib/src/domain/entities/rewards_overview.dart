import 'package:freezed_annotation/freezed_annotation.dart';

import 'account.dart';
import 'activity.dart';
import 'activity_history.dart';
import 'milestone.dart';
import 'user_streak.dart';

part 'rewards_overview.freezed.dart';

@freezed
abstract class RewardsOverview with _$RewardsOverview {
  const factory RewardsOverview({
    required RewardAccount account,
    required List<EarnableActivity> activities,
    required List<UserStreak> streaks,
    required List<RewardMilestone> milestones,
    required List<ActivityHistory> history,
  }) = _RewardsOverview;
}
