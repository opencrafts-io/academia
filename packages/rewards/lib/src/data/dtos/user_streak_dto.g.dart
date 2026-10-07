// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_streak_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStreakDto _$UserStreakDtoFromJson(Map<String, dynamic> json) =>
    _UserStreakDto(
      activityId: json['activity_id'] as String? ?? '',
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
      lastActivityDate: json['last_activity_date'] == null
          ? null
          : DateTime.parse(json['last_activity_date'] as String),
    );

Map<String, dynamic> _$UserStreakDtoToJson(_UserStreakDto instance) =>
    <String, dynamic>{
      'activity_id': instance.activityId,
      'current_streak': instance.currentStreak,
      'longest_streak': instance.longestStreak,
      'last_activity_date': instance.lastActivityDate?.toIso8601String(),
    };
