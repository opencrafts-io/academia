part of 'achievements_bloc.dart';

abstract class AchievementsEvent extends Equatable {
  const AchievementsEvent();

  @override
  List<Object> get props => [];
}

class LoadAchievements extends AchievementsEvent {}

class LoadMoreAchievements extends AchievementsEvent {}

class RefreshAchievements extends AchievementsEvent {}
