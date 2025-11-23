part of 'achievement_detail_bloc.dart';

abstract class AchievementDetailState extends Equatable {
  const AchievementDetailState();

  @override
  List<Object> get props => [];
}

class AchievementDetailInitial extends AchievementDetailState {}

class AchievementDetailLoading extends AchievementDetailState {}

class AchievementDetailLoaded extends AchievementDetailState {
  final StreakMilestoneData achievement;

  const AchievementDetailLoaded(this.achievement);

  @override
  List<Object> get props => [achievement];
}

class AchievementDetailError extends AchievementDetailState {
  final String message;

  const AchievementDetailError(this.message);

  @override
  List<Object> get props => [message];
}
