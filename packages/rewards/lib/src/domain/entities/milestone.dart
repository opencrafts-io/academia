import 'package:freezed_annotation/freezed_annotation.dart';

part 'milestone.freezed.dart';

@freezed
abstract class RewardMilestone with _$RewardMilestone {
  const factory RewardMilestone({
    required String id,
    required String activityId,
    required int daysRequired,
    required int bonusPoints,
    required String title,
    required String description,
  }) = _RewardMilestone;
}
