part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class LoadActivities extends ActivitiesEvent {}

class LoadMoreActivities extends ActivitiesEvent {}

class RefreshActivities extends ActivitiesEvent {}
