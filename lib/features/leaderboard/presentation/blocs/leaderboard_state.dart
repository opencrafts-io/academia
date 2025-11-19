part of 'leaderboard_bloc.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardRank> entries;
  final int totalCount;
  final bool hasMore;
  final int currentPage;

  const LeaderboardLoaded({
    required this.entries,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object> get props => [entries, totalCount, hasMore, currentPage];

  LeaderboardLoaded copyWith({
    List<LeaderboardRank>? entries,
    int? totalCount,
    bool? hasMore,
    int? currentPage,
  }) {
    return LeaderboardLoaded(
      entries: entries ?? this.entries,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class LeaderboardLoadingMore extends LeaderboardLoaded {
  const LeaderboardLoadingMore({
    required super.entries,
    required super.totalCount,
    required super.hasMore,
    required super.currentPage,
  });
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError({required this.message});

  @override
  List<Object> get props => [message];
}
