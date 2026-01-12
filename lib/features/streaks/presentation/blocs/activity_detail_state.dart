part of 'activity_detail_bloc.dart';

abstract class ActivityDetailState extends Equatable {
  const ActivityDetailState();

  @override
  List<Object> get props => [];
}

class ActivityDetailInitial extends ActivityDetailState {}

class ActivityDetailLoading extends ActivityDetailState {}

class ActivityDetailLoaded extends ActivityDetailState {
  final StreakActivityData activity;

  const ActivityDetailLoaded(this.activity);

  @override
  List<Object> get props => [activity];
}

class ActivityDetailError extends ActivityDetailState {
  final String message;

  const ActivityDetailError(this.message);

  @override
  List<Object> get props => [message];
}
