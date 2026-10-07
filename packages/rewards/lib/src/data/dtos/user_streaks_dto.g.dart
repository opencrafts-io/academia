// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_streaks_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStreaksDto _$UserStreaksDtoFromJson(Map<String, dynamic> json) =>
    _UserStreaksDto(
      streaks:
          (json['streaks'] as List<dynamic>?)
              ?.map((e) => UserStreakDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserStreakDto>[],
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => UserStreakDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserStreakDto>[],
    );

Map<String, dynamic> _$UserStreaksDtoToJson(_UserStreaksDto instance) =>
    <String, dynamic>{'streaks': instance.streaks, 'results': instance.results};
