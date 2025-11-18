import 'package:academia/database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'streak_milestone.freezed.dart';

@freezed
abstract class StreakMilestone with _$StreakMilestone {
  StreakMilestone._();
  const factory StreakMilestone({
    required String id,
    required String activityID,
    required int daysRequired,
    required int bonusPoints,
    required String title,
    required String description,
    required bool isActive,
    DateTime? cachedAt,
  }) = _StreakMilestone;

  StreakMilestoneData toData() => StreakMilestoneData(
    id: id,
    activityID: activityID,
    daysRequired: daysRequired,
    bonusPoints: bonusPoints,
    title: title,
    description: description,
    isActive: isActive,
    cachedAt: cachedAt,
  );
}
