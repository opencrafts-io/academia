part of 'activity_detail_bloc.dart';

abstract class ActivityDetailEvent extends Equatable {
  const ActivityDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadActivityDetail extends ActivityDetailEvent {
  final String id;

  const LoadActivityDetail(this.id);

  @override
  List<Object> get props => [id];
}
