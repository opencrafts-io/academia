import 'package:academia/database/database.dart';
import 'package:academia/features/leaderboard/domain/entities/leaderboard_rank.dart';

extension LeaderboardRankHelper on LeaderboardRankData {
  // Return the entity equivalent of the data object
  LeaderboardRank toEntity() => LeaderboardRank(
    id: id,
    avatarUrl: avatarUrl,
    email: email,
    name: name,
    username: username,
    vibePoints: vibePoints,
    vibeRank: vibeRank,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
