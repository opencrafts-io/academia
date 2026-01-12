part of 'achievements_bloc.dart';

abstract class AchievementsState extends Equatable {
  const AchievementsState();

  @override
  List<Object> get props => [];
}

class AchievementsInitial extends AchievementsState {}

class AchievementsLoading extends AchievementsState {}

class AchievementsLoadingMore extends AchievementsLoaded {
  const AchievementsLoadingMore({
    required super.achievements,
    required super.totalCount,
    required super.hasMore,
    required super.currentPage,
  });
}

class AchievementsLoaded extends AchievementsState {
  final List<StreakMilestoneData> achievements;
  final int totalCount;
  final bool hasMore;
  final int currentPage;

  const AchievementsLoaded({
    required this.achievements,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object> get props => [achievements, totalCount, hasMore, currentPage];
}

class AchievementsError extends AchievementsState {
  final String message;

  const AchievementsError({required this.message});

  @override
  List<Object> get props => [message];
}
