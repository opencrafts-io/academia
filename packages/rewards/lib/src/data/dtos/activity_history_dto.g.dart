// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityHistoryDto _$ActivityHistoryDtoFromJson(Map<String, dynamic> json) =>
    _ActivityHistoryDto(
      id: json['id'] as String? ?? '',
      activityId: json['activity_id'] as String? ?? '',
      activityName: json['activity_name'] as String?,
      pointsEarned: (json['points_earned'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ActivityHistoryDtoToJson(_ActivityHistoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity_id': instance.activityId,
      'activity_name': instance.activityName,
      'points_earned': instance.pointsEarned,
      'created_at': instance.createdAt?.toIso8601String(),
    };
