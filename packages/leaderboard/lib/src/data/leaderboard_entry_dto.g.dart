// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardEntryDto _$LeaderboardEntryDtoFromJson(Map<String, dynamic> json) =>
    _LeaderboardEntryDto(
      id: json['id'] as String? ?? '',
      accountId: json['account_id'] as String?,
      username: json['username'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      position: (json['position'] as num?)?.toInt() ?? 0,
      vibeRank: (json['vibe_rank'] as num?)?.toInt() ?? 0,
      vibePoints: (json['vibe_points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LeaderboardEntryDtoToJson(
  _LeaderboardEntryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'account_id': instance.accountId,
  'username': instance.username,
  'avatar_url': instance.avatarUrl,
  'position': instance.position,
  'vibe_rank': instance.vibeRank,
  'vibe_points': instance.vibePoints,
};
