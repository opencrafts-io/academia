part of 'achievement_detail_bloc.dart';

abstract class AchievementDetailState extends Equatable {
  const AchievementDetailState();

  @override
  List<Object?> get props => [];
}

class AchievementDetailInitial extends AchievementDetailState {}

class AchievementDetailLoading extends AchievementDetailState {}

class AchievementDetailLoaded extends AchievementDetailState {
  final StreakMilestoneData achievement;
  final StreakActivityData? activity;

  const AchievementDetailLoaded(this.achievement, {this.activity});

  @override
  List<Object?> get props => [achievement, activity];
}

class AchievementDetailError extends AchievementDetailState {
  final String message;

  const AchievementDetailError(this.message);

  @override
  List<Object> get props => [message];
}
