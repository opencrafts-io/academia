part of 'timetable_entry_bloc.dart';

abstract class TimetableEntryEvent extends Equatable {
  const TimetableEntryEvent();

  @override
  List<Object?> get props => [];
}

class WatchAllTimetableEntriesEvent extends TimetableEntryEvent {
  const WatchAllTimetableEntriesEvent();
}

class WatchTimetableEntriesByTimetableIdEvent extends TimetableEntryEvent {
  final String timetableId;

  const WatchTimetableEntriesByTimetableIdEvent({required this.timetableId});

  @override
  List<Object?> get props => [timetableId];
}

class WatchTimetableEntriesByCourseIdEvent extends TimetableEntryEvent {
  final String courseId;

  const WatchTimetableEntriesByCourseIdEvent({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

class WatchTimetableEntriesByUserIdEvent extends TimetableEntryEvent {
  final String userId;

  const WatchTimetableEntriesByUserIdEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class WatchTimetableEntriesByInstitutionIdEvent extends TimetableEntryEvent {
  final int institutionId;

  const WatchTimetableEntriesByInstitutionIdEvent({
    required this.institutionId,
  });

  @override
  List<Object?> get props => [institutionId];
}

class CreateOrUpdateTimetableEntryEvent extends TimetableEntryEvent {
  final TimetableEntryEntity entry;

  const CreateOrUpdateTimetableEntryEvent({required this.entry});

  @override
  List<Object?> get props => [entry];
}

class CreateOrUpdateTimetableEntriesEvent extends TimetableEntryEvent {
  final List<TimetableEntryEntity> entries;

  const CreateOrUpdateTimetableEntriesEvent({required this.entries});

  @override
  List<Object?> get props => [entries];
}

class GetTimetableEntryByIdEvent extends TimetableEntryEvent {
  final String id;

  const GetTimetableEntryByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTimetableEntryEvent extends TimetableEntryEvent {
  final String id;

  const DeleteTimetableEntryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTimetableEntriesEvent extends TimetableEntryEvent {
  final List<String> ids;

  const DeleteTimetableEntriesEvent({required this.ids});

  @override
  List<Object?> get props => [ids];
}

class SyncTimetableEntriesEvent extends TimetableEntryEvent {
  const SyncTimetableEntriesEvent();
}

class FetchTimetableEntriesFromRemoteEvent extends TimetableEntryEvent {
  final String? timetableId;

  const FetchTimetableEntriesFromRemoteEvent({this.timetableId});

  @override
  List<Object?> get props => [timetableId];
}
