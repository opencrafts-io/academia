// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilestoneDto _$MilestoneDtoFromJson(Map<String, dynamic> json) =>
    _MilestoneDto(
      id: json['id'] as String? ?? '',
      activityId: json['activity_id'] as String? ?? '',
      daysRequired: (json['days_required'] as num?)?.toInt() ?? 0,
      bonusPoints: (json['bonus_points'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$MilestoneDtoToJson(_MilestoneDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity_id': instance.activityId,
      'days_required': instance.daysRequired,
      'bonus_points': instance.bonusPoints,
      'title': instance.title,
      'description': instance.description,
    };
