import 'package:academia/core/core.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// =============================================================
// Create or Update Timetable Entry Use Case
// =============================================================

class CreateOrUpdateTimetableEntry
    extends UseCase<TimetableEntryEntity, CreateOrUpdateTimetableEntryParams> {
  final TimetableEntryRepository repository;

  CreateOrUpdateTimetableEntry(this.repository);

  @override
  Future<Either<Failure, TimetableEntryEntity>> call(
    CreateOrUpdateTimetableEntryParams params,
  ) async {
    return await repository.createOrUpdateTimetableEntry(entry: params.entry);
  }
}

class CreateOrUpdateTimetableEntryParams extends Equatable {
  final TimetableEntryEntity entry;

  const CreateOrUpdateTimetableEntryParams({required this.entry});

  @override
  List<Object?> get props => [entry];
}

// =============================================================
// Create or Update Multiple Timetable Entries Use Case (Batch)
// =============================================================

class CreateOrUpdateTimetableEntries
    extends
        UseCase<
          List<TimetableEntryEntity>,
          CreateOrUpdateTimetableEntriesParams
        > {
  final TimetableEntryRepository repository;

  CreateOrUpdateTimetableEntries(this.repository);

  @override
  Future<Either<Failure, List<TimetableEntryEntity>>> call(
    CreateOrUpdateTimetableEntriesParams params,
  ) async {
    return await repository.createOrUpdateTimetableEntries(
      entries: params.entries,
    );
  }
}

class CreateOrUpdateTimetableEntriesParams extends Equatable {
  final List<TimetableEntryEntity> entries;

  const CreateOrUpdateTimetableEntriesParams({required this.entries});

  @override
  List<Object?> get props => [entries];
}

// ===============================================================
// Get Timetable Entry By ID Use Case
// ===============================================================

class GetTimetableEntryById
    extends UseCase<TimetableEntryEntity, GetTimetableEntryByIdParams> {
  final TimetableEntryRepository repository;

  GetTimetableEntryById(this.repository);

  @override
  Future<Either<Failure, TimetableEntryEntity>> call(
    GetTimetableEntryByIdParams params,
  ) async {
    return await repository.getTimetableEntryById(id: params.id);
  }
}

class GetTimetableEntryByIdParams extends Equatable {
  final String id;

  const GetTimetableEntryByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

// =====================================================================
// Watch All Timetable Entries Use Case
// =====================================================================

class WatchAllTimetableEntries
    extends
        StreamUseCase<Either<Failure, List<TimetableEntryEntity>>, NoParams> {
  final TimetableEntryRepository repository;

  WatchAllTimetableEntries(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>> call(NoParams params) {
    return repository.watchAllTimetableEntries();
  }
}

// ===================================================================
// Watch Timetable Entries By Timetable ID Use Case
// ====================================================================

class WatchTimetableEntriesByTimetableId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntryEntity>>,
          WatchTimetableEntriesByTimetableIdParams
        > {
  final TimetableEntryRepository repository;

  WatchTimetableEntriesByTimetableId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>> call(
    WatchTimetableEntriesByTimetableIdParams params,
  ) {
    return repository.watchTimetableEntriesByTimetableId(
      timetableId: params.timetableId,
    );
  }
}

class WatchTimetableEntriesByTimetableIdParams extends Equatable {
  final String timetableId;

  const WatchTimetableEntriesByTimetableIdParams({required this.timetableId});

  @override
  List<Object?> get props => [timetableId];
}

// ====================================================================
// Watch Timetable Entries By Course ID Use Case
// =====================================================================

class WatchTimetableEntriesByCourseId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntryEntity>>,
          WatchTimetableEntriesByCourseIdParams
        > {
  final TimetableEntryRepository repository;

  WatchTimetableEntriesByCourseId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>> call(
    WatchTimetableEntriesByCourseIdParams params,
  ) {
    return repository.watchTimetableEntriesByCourseId(
      courseId: params.courseId,
    );
  }
}

class WatchTimetableEntriesByCourseIdParams extends Equatable {
  final String courseId;

  const WatchTimetableEntriesByCourseIdParams({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

// =====================================================================
// Watch Timetable Entries By User ID Use Case
// =====================================================================

class WatchTimetableEntriesByUserId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntryEntity>>,
          WatchTimetableEntriesByUserIdParams
        > {
  final TimetableEntryRepository repository;

  WatchTimetableEntriesByUserId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>> call(
    WatchTimetableEntriesByUserIdParams params,
  ) {
    return repository.watchTimetableEntriesByUserId(userId: params.userId);
  }
}

class WatchTimetableEntriesByUserIdParams extends Equatable {
  final String userId;

  const WatchTimetableEntriesByUserIdParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// =====================================================================
// Watch Timetable Entries By Institution ID Use Case
// =====================================================================

class WatchTimetableEntriesByInstitutionId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntryEntity>>,
          WatchTimetableEntriesByInstitutionIdParams
        > {
  final TimetableEntryRepository repository;

  WatchTimetableEntriesByInstitutionId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>> call(
    WatchTimetableEntriesByInstitutionIdParams params,
  ) {
    return repository.watchTimetableEntriesByInstitutionId(
      institutionId: params.institutionId,
    );
  }
}

class WatchTimetableEntriesByInstitutionIdParams extends Equatable {
  final int institutionId;

  const WatchTimetableEntriesByInstitutionIdParams({
    required this.institutionId,
  });

  @override
  List<Object?> get props => [institutionId];
}

// =====================================================================
// Delete Timetable Entry Use Case
// =====================================================================

class DeleteTimetableEntry extends UseCase<Unit, DeleteTimetableEntryParams> {
  final TimetableEntryRepository repository;

  DeleteTimetableEntry(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteTimetableEntryParams params) async {
    return await repository.deleteTimetableEntry(id: params.id);
  }
}

class DeleteTimetableEntryParams extends Equatable {
  final String id;

  const DeleteTimetableEntryParams({required this.id});

  @override
  List<Object?> get props => [id];
}

// =================================================================
// Delete Multiple Timetable Entries Use Case (Batch)
// =================================================================

class DeleteTimetableEntries
    extends UseCase<Unit, DeleteTimetableEntriesParams> {
  final TimetableEntryRepository repository;

  DeleteTimetableEntries(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
    DeleteTimetableEntriesParams params,
  ) async {
    return await repository.deleteTimetableEntries(ids: params.ids);
  }
}

class DeleteTimetableEntriesParams extends Equatable {
  final List<String> ids;

  const DeleteTimetableEntriesParams({required this.ids});

  @override
  List<Object?> get props => [ids];
}

// =================================================================
// Sync Timetable Entries Use Case
// =================================================================

class SyncTimetableEntries extends UseCase<Unit, NoParams> {
  final TimetableEntryRepository repository;

  SyncTimetableEntries(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.syncTimetableEntries();
  }
}

// ===================================================================
// Fetch Timetable Entries From Remote Use Case
// ===================================================================

class FetchTimetableEntriesFromRemote
    extends
        UseCase<
          List<TimetableEntryEntity>,
          FetchTimetableEntriesFromRemoteParams
        > {
  final TimetableEntryRepository repository;

  FetchTimetableEntriesFromRemote(this.repository);

  @override
  Future<Either<Failure, List<TimetableEntryEntity>>> call(
    FetchTimetableEntriesFromRemoteParams params,
  ) async {
    return await repository.fetchTimetableEntriesFromRemote(
      timetableId: params.timetableId,
    );
  }
}

class FetchTimetableEntriesFromRemoteParams extends Equatable {
  final String? timetableId;

  const FetchTimetableEntriesFromRemoteParams({this.timetableId});

  @override
  List<Object?> get props => [timetableId];
}
