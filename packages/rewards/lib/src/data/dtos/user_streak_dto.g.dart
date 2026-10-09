// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_streak_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStreakDto _$UserStreakDtoFromJson(Map<String, dynamic> json) =>
    _UserStreakDto(
      activityName: json['activity_name'] as String? ?? '',
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
      daysUntilNextMilestone:
          (json['days_until_next_milestone'] as num?)?.toInt() ?? 0,
      totalCompletions: (json['total_completions'] as num?)?.toInt() ?? 0,
      lastCompletionDate: json['last_completion_date'] as String?,
    );

Map<String, dynamic> _$UserStreakDtoToJson(_UserStreakDto instance) =>
    <String, dynamic>{
      'activity_name': instance.activityName,
      'current_streak': instance.currentStreak,
      'longest_streak': instance.longestStreak,
      'days_until_next_milestone': instance.daysUntilNextMilestone,
      'total_completions': instance.totalCompletions,
      'last_completion_date': instance.lastCompletionDate,
    };
