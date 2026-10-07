import 'package:freezed_annotation/freezed_annotation.dart';

import 'milestone.dart';
import 'user_streak.dart';

part 'activity_completion.freezed.dart';

@freezed
abstract class ActivityCompletion with _$ActivityCompletion {
  const factory ActivityCompletion({
    required String id,
    required String activityId,
    required int pointsEarned,
    DateTime? createdAt,
    required bool alreadyProcessed,
    UserStreak? streak,
    @Default(<RewardMilestone>[]) List<RewardMilestone> milestones,
  }) = _ActivityCompletion;
}
