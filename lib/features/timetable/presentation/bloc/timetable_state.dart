part of 'timetable_bloc.dart';
abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object?> get props => [];
}

class TimetableInitial extends TimetableState {
  const TimetableInitial();
}

class TimetableLoading extends TimetableState {
  const TimetableLoading();
}

class TimetablesLoaded extends TimetableState {
  final List<TimetableEntity> timetables;

  const TimetablesLoaded({required this.timetables});

  @override
  List<Object?> get props => [timetables];
}

class TimetableLoaded extends TimetableState {
  final TimetableEntity timetable;

  const TimetableLoaded({required this.timetable});

  @override
  List<Object?> get props => [timetable];
}

class TimetableOperationSuccess extends TimetableState {
  final String message;

  const TimetableOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class TimetableError extends TimetableState {
  final String message;

  const TimetableError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TimetableSyncing extends TimetableState {
  const TimetableSyncing();
}

class TimetableSyncSuccess extends TimetableState {
  const TimetableSyncSuccess();
}


