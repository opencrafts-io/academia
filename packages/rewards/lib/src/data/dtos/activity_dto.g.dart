// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityDto _$ActivityDtoFromJson(Map<String, dynamic> json) => _ActivityDto(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  category: json['category'] as String? ?? '',
  pointsAwarded: (json['points_awarded'] as num?)?.toInt() ?? 0,
  maxDailyCompletions: (json['max_daily_completions'] as num?)?.toInt() ?? 0,
  streakEligible: json['streak_eligible'] as bool? ?? false,
  code: json['code'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ActivityDtoToJson(_ActivityDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'points_awarded': instance.pointsAwarded,
      'max_daily_completions': instance.maxDailyCompletions,
      'streak_eligible': instance.streakEligible,
      'code': instance.code,
      'slug': instance.slug,
      'description': instance.description,
    };
