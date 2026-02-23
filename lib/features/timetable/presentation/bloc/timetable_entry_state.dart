part of 'timetable_entry_bloc.dart';

abstract class TimetableEntryState extends Equatable {
  const TimetableEntryState();

  @override
  List<Object?> get props => [];
}

class TimetableEntryInitial extends TimetableEntryState {
  const TimetableEntryInitial();
}

class TimetableEntryLoading extends TimetableEntryState {
  const TimetableEntryLoading();
}

class TimetableEntriesLoaded extends TimetableEntryState {
  final List<TimetableEntryEntity> entries;

  const TimetableEntriesLoaded({required this.entries});

  @override
  List<Object?> get props => [entries];
}

class TimetableEntryLoaded extends TimetableEntryState {
  final TimetableEntryEntity entry;

  const TimetableEntryLoaded({required this.entry});

  @override
  List<Object?> get props => [entry];
}

class TimetableEntryOperationSuccess extends TimetableEntryState {
  final String message;

  const TimetableEntryOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class TimetableEntryError extends TimetableEntryState {
  final String message;

  const TimetableEntryError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TimetableEntrySyncing extends TimetableEntryState {
  const TimetableEntrySyncing();
}

class TimetableEntrySyncSuccess extends TimetableEntryState {
  const TimetableEntrySyncSuccess();
}
