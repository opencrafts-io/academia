part of 'achievement_detail_bloc.dart';

abstract class AchievementDetailEvent extends Equatable {
  const AchievementDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadAchievementDetail extends AchievementDetailEvent {
  final String id;

  const LoadAchievementDetail(this.id);

  @override
  List<Object> get props => [id];
}
