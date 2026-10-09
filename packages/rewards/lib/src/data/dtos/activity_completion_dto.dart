import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/activity_completion.dart';
import 'milestone_dto.dart';
import 'user_streak_dto.dart';

part 'activity_completion_dto.freezed.dart';
part 'activity_completion_dto.g.dart';

@freezed
abstract class ActivityCompletionDto with _$ActivityCompletionDto {
  const ActivityCompletionDto._();

  const factory ActivityCompletionDto({
    @Default('') String id,
    @JsonKey(name: 'completion_id') int? completionId,
    @JsonKey(name: 'activity_id') @Default('') String activityId,
    @JsonKey(name: 'points_earned') @Default(0) int pointsEarned,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'already_processed') @Default(false) bool alreadyProcessed,
    @JsonKey(name: 'current_streak') int? currentStreak,
    @JsonKey(name: 'milestone_achieved') bool? milestoneAchieved,
    @JsonKey(name: 'milestone_bonus') int? milestoneBonus,
    UserStreakDto? streak,
    @JsonKey(name: 'streak_details') UserStreakDto? streakDetails,
    @JsonKey(name: 'milestones')
    @Default(<MilestoneDto>[])
    List<MilestoneDto> milestones,
    @JsonKey(name: 'milestone_details')
    @Default(<MilestoneDto>[])
    List<MilestoneDto> milestoneDetails,
  }) = _ActivityCompletionDto;

  factory ActivityCompletionDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityCompletionDtoFromJson(json);

  ActivityCompletion toDomain() => ActivityCompletion(
    id: id.isNotEmpty ? id : completionId?.toString() ?? '',
    activityId: activityId,
    pointsEarned: pointsEarned,
    createdAt: createdAt,
    alreadyProcessed: alreadyProcessed,
    currentStreak: currentStreak,
    milestoneAchieved: milestoneAchieved,
    milestoneBonus: milestoneBonus,
    streak: (streak ?? streakDetails)?.toDomain(),
    milestones: (milestones.isNotEmpty ? milestones : milestoneDetails)
        .map((milestone) => milestone.toDomain())
        .toList(),
  );
}
