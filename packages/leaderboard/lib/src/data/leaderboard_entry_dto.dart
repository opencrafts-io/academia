import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/domain.dart';

part 'leaderboard_entry_dto.freezed.dart';
part 'leaderboard_entry_dto.g.dart';

@freezed
abstract class LeaderboardEntryDto with _$LeaderboardEntryDto {
  const LeaderboardEntryDto._();

  const factory LeaderboardEntryDto({
    @Default('') String id,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    int? position,
    @JsonKey(name: 'vibe_rank') @Default(0) int vibeRank,
    @JsonKey(name: 'vibe_points') @Default(0) int vibePoints,
  }) = _LeaderboardEntryDto;

  factory LeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryDtoFromJson(json);

  LeaderboardEntry toDomain({int? displayPosition}) => LeaderboardEntry(
    id: id,
    username: username,
    avatarUrl: avatarUrl,
    position: displayPosition ?? position ?? 0,
    vibeRank: vibeRank,
    vibePoints: vibePoints,
  );
}
