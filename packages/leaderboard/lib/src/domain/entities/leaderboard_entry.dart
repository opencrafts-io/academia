import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';

@freezed
abstract class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String id,
    String? username,
    String? avatarUrl,
    required int position,
    required int vibeRank,
    required int vibePoints,
  }) = _LeaderboardEntry;
}
