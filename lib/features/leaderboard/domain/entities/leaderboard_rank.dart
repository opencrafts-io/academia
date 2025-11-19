import 'package:academia/database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'leaderboard_rank.freezed.dart';

@immutable
@freezed
abstract class LeaderboardRank with _$LeaderboardRank {
  const LeaderboardRank._();

  const factory LeaderboardRank({
    required String id,
    required String? avatarUrl,
    required String email,
    required String name,
    required String? username,
    required int vibePoints,
    required int vibeRank,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LeaderboardRank;

  /// Converts the model to a data layer model [LeaderboardRankData]
  LeaderboardRankData toData() => LeaderboardRankData(
    id: id,
    avatarUrl: avatarUrl,
    email: email,
    name: name,
    username: username,
    vibePoints: vibePoints,
    vibeRank: vibeRank,
    createdAt: createdAt,
    updatedAt: updatedAt,
    cachedAt: DateTime.now(),
  );
}
