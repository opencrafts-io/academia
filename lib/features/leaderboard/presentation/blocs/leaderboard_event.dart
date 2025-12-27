part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaderboard extends LeaderboardEvent {
  const LoadLeaderboard();
}

class LoadMoreLeaderboard extends LeaderboardEvent {
  const LoadMoreLeaderboard();
}

class RefreshLeaderboard extends LeaderboardEvent {
  const RefreshLeaderboard();
}
