// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_around_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardAroundDto _$LeaderboardAroundDtoFromJson(
  Map<String, dynamic> json,
) => _LeaderboardAroundDto(
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LeaderboardEntryDto>[],
  userId: json['user_id'] as String?,
  userPosition: (json['user_position'] as num?)?.toInt(),
  totalUsers: (json['total_users'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LeaderboardAroundDtoToJson(
  _LeaderboardAroundDto instance,
) => <String, dynamic>{
  'results': instance.results,
  'user_id': instance.userId,
  'user_position': instance.userPosition,
  'total_users': instance.totalUsers,
};
