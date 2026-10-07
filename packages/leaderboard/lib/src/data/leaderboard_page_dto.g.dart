// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardPageDto _$LeaderboardPageDtoFromJson(Map<String, dynamic> json) =>
    _LeaderboardPageDto(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <LeaderboardEntryDto>[],
    );

Map<String, dynamic> _$LeaderboardPageDtoToJson(_LeaderboardPageDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
