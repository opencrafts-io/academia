// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_around_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardAroundDto _$LeaderboardAroundDtoFromJson(
  Map<String, dynamic> json,
) => _LeaderboardAroundDto(
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LeaderboardEntryDto>[],
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LeaderboardEntryDto>[],
  leaderboard:
      (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LeaderboardEntryDto>[],
  user: json['user'] == null
      ? null
      : LeaderboardEntryDto.fromJson(json['user'] as Map<String, dynamic>),
  userPosition: (json['user_position'] as num?)?.toInt(),
  totalUsers: (json['total_users'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LeaderboardAroundDtoToJson(
  _LeaderboardAroundDto instance,
) => <String, dynamic>{
  'entries': instance.entries,
  'results': instance.results,
  'leaderboard': instance.leaderboard,
  'user': instance.user,
  'user_position': instance.userPosition,
  'total_users': instance.totalUsers,
};
