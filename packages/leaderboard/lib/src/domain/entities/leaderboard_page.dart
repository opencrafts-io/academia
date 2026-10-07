import 'package:freezed_annotation/freezed_annotation.dart';

import 'leaderboard_entry.dart';

part 'leaderboard_page.freezed.dart';

@freezed
abstract class LeaderboardPage with _$LeaderboardPage {
  const factory LeaderboardPage({
    required List<LeaderboardEntry> entries,
    required int totalUsers,
    int? userPosition,
    required bool hasNext,
    required int currentPage,
  }) = _LeaderboardPage;
}
