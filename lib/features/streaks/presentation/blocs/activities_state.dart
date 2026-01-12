part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesLoadingMore extends ActivitiesLoaded {
  const ActivitiesLoadingMore({
    required super.activities,
    required super.totalCount,
    required super.hasMore,
    required super.currentPage,
  });
}

class ActivitiesLoaded extends ActivitiesState {
  final List<StreakActivityData> activities;
  final int totalCount;
  final bool hasMore;
  final int currentPage;

  const ActivitiesLoaded({
    required this.activities,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object> get props => [activities, totalCount, hasMore, currentPage];
}

class ActivitiesError extends ActivitiesState {
  final String message;

  const ActivitiesError({required this.message});

  @override
  List<Object> get props => [message];
}
