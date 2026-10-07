// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_completion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityCompletionDto _$ActivityCompletionDtoFromJson(
  Map<String, dynamic> json,
) => _ActivityCompletionDto(
  id: json['id'] as String? ?? '',
  activityId: json['activity_id'] as String? ?? '',
  pointsEarned: (json['points_earned'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  alreadyProcessed: json['already_processed'] as bool? ?? false,
  streak: json['streak'] == null
      ? null
      : UserStreakDto.fromJson(json['streak'] as Map<String, dynamic>),
  streakDetails: json['streak_details'] == null
      ? null
      : UserStreakDto.fromJson(json['streak_details'] as Map<String, dynamic>),
  milestones:
      (json['milestones'] as List<dynamic>?)
          ?.map((e) => MilestoneDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MilestoneDto>[],
  milestoneDetails:
      (json['milestone_details'] as List<dynamic>?)
          ?.map((e) => MilestoneDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MilestoneDto>[],
);

Map<String, dynamic> _$ActivityCompletionDtoToJson(
  _ActivityCompletionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'activity_id': instance.activityId,
  'points_earned': instance.pointsEarned,
  'created_at': instance.createdAt?.toIso8601String(),
  'already_processed': instance.alreadyProcessed,
  'streak': instance.streak,
  'streak_details': instance.streakDetails,
  'milestones': instance.milestones,
  'milestone_details': instance.milestoneDetails,
};
