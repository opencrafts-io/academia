import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/milestone.dart';

part 'milestone_dto.freezed.dart';
part 'milestone_dto.g.dart';

@freezed
abstract class MilestoneDto with _$MilestoneDto {
  const MilestoneDto._();

  const factory MilestoneDto({
    @Default('') String id,
    @JsonKey(name: 'activity_id') @Default('') String activityId,
    @JsonKey(name: 'days_required') @Default(0) int daysRequired,
    @JsonKey(name: 'bonus_points') @Default(0) int bonusPoints,
    @Default('') String title,
    @Default('') String description,
  }) = _MilestoneDto;

  factory MilestoneDto.fromJson(Map<String, dynamic> json) =>
      _$MilestoneDtoFromJson(json);

  RewardMilestone toDomain() => RewardMilestone(
    id: id,
    activityId: activityId,
    daysRequired: daysRequired,
    bonusPoints: bonusPoints,
    title: title,
    description: description,
  );
}
