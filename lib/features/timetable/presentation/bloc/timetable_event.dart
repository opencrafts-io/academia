part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();

  @override
  List<Object?> get props => [];
}

class WatchAllTimetablesEvent extends TimetableEvent {
  const WatchAllTimetablesEvent();
}

class WatchTimetablesByUserIdEvent extends TimetableEvent {
  final String userId;

  const WatchTimetablesByUserIdEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class WatchTimetablesByInstitutionIdEvent extends TimetableEvent {
  final int institutionId;

  const WatchTimetablesByInstitutionIdEvent({required this.institutionId});

  @override
  List<Object?> get props => [institutionId];
}

class CreateOrUpdateTimetableEvent extends TimetableEvent {
  final TimetableEntity timetable;

  const CreateOrUpdateTimetableEvent({required this.timetable});

  @override
  List<Object?> get props => [timetable];
}

class GetTimetableByIdEvent extends TimetableEvent {
  final String id;

  const GetTimetableByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTimetableEvent extends TimetableEvent {
  final String id;

  const DeleteTimetableEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SyncTimetablesEvent extends TimetableEvent {
  const SyncTimetablesEvent();
}

class FetchTimetablesFromRemoteEvent extends TimetableEvent {
  const FetchTimetablesFromRemoteEvent();
}
