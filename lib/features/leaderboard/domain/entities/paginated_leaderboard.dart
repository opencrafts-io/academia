import 'package:equatable/equatable.dart';
import './leaderboard_rank.dart';

class PaginatedLeaderboard extends Equatable {
  final int totalCount;
  final bool hasNext;
  final bool hasPrevious;
  final List<LeaderboardRank> entries;
  final int currentPage;

  const PaginatedLeaderboard({
    required this.totalCount,
    required this.hasNext,
    required this.hasPrevious,
    required this.entries,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
    totalCount,
    hasNext,
    hasPrevious,
    entries,
    currentPage,
  ];
}
