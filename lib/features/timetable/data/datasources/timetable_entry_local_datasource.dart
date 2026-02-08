import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

/// An abstract contract for interacting with the local SQLite database via Drift
/// for TimetableEntry-related data operations.
///
/// This datasource is responsible for the "Local" part of the offline-first
/// architecture, ensuring that the UI remains responsive even without a
/// network connection.
abstract class TimetableEntryLocalDatasource {
  /// Persists a timetable entry to the local database.
  ///
  /// If an entry with the same primary key already exists, it updates the record.
  /// This is used both for initial local creation and for caching data
  /// returned from the remote server.
  ///
  /// Returns [Unit] on success or a [Failure] on database write errors.
  Future<Either<Failure, Unit>> createOrUpdateTimetableEntry({
    required TimetableEntryCompanion entry,
  });

  /// Provides a real-time [Stream] of all timetable entries currently stored in the
  /// local database.
  ///
  /// Useful for populating global entry lists that update automatically
  /// when data is synced or modified.
  Stream<Either<Failure, List<TimetableEntryData>>> watchAllTimetableEntries();

  /// Watches a filtered list of timetable entries belonging to a specific timetable.
  ///
  /// [timetableId] is the local identifier for the timetable.
  /// This stream emits a new list whenever any entry matching this
  /// ID is modified.
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByTimetableId({required String timetableId});

  /// Watches a filtered list of timetable entries belonging to a specific course.
  ///
  /// [courseId] is the local identifier for the course.
  /// This stream emits a new list whenever any entry matching this
  /// ID is modified.
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByCourseId({required String courseId});

  /// Watches a filtered list of timetable entries belonging to a specific user.
  ///
  /// [userId] is the user identifier.
  /// This stream emits a new list whenever any entry matching this
  /// user ID is modified.
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByUserId({required String userId});

  /// Watches a filtered list of timetable entries belonging to a specific institution.
  ///
  /// [institutionId] is the remote server identifier for the institution.
  /// This stream emits a new list whenever any entry matching this
  /// ID is modified.
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByInstitutionId({required int institutionId});

  /// Retrieves a specific timetable entry by its local unique identifier (UUID).
  ///
  /// [id] refers to the `cache_id` (primary key) used for local tracking.
  /// Returns [TimetableEntryData] if found, otherwise returns a [Failure].
  Future<Either<Failure, TimetableEntryData>> getTimetableEntryById({
    required String id,
  });

  /// Marks a timetable entry for deletion (soft delete).
  ///
  /// [id] is the identifier for the entry to be removed.
  /// Note: In an offline-first system, this triggers a "soft delete"
  /// flag to ensure the deletion is eventually synced to the server.
  Future<Either<Failure, Unit>> deleteTimetableEntryById({required String id});

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  Future<Either<Failure, Unit>> hardDeleteTimetableEntry(String id);

  /// Batch operation: Creates or updates multiple timetable entries at once.
  ///
  /// Useful for syncing multiple entries from the server or bulk operations.
  /// Returns [Unit] on success or a [Failure] if any entry fails to save.
  Future<Either<Failure, Unit>> createOrUpdateTimetableEntries({
    required List<TimetableEntryCompanion> entries,
  });
}

class TimetableEntryLocalDatasourceImpl extends TimetableEntryLocalDatasource {
  final AppDataBase appDataBase;

  TimetableEntryLocalDatasourceImpl({required this.appDataBase});

  @override
  Future<Either<Failure, Unit>> createOrUpdateTimetableEntry({
    required TimetableEntryCompanion entry,
  }) async {
    try {
      // into() creates an insert statement.
      // insertOnConflictUpdate handles the "Create or Update" logic.
      await appDataBase
          .into(appDataBase.timetableEntry)
          .insertOnConflictUpdate(entry);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, Unit>> createOrUpdateTimetableEntries({
    required List<TimetableEntryCompanion> entries,
  }) async {
    try {
      // Use a batch operation for better performance
      await appDataBase.batch((batch) {
        batch.insertAllOnConflictUpdate(appDataBase.timetableEntry, entries);
      });
      return const Right(unit);
    } catch (e) {
      return Left(
        CacheFailure(
          message: "Failed to save timetable entries in batch",
          error: e,
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, List<TimetableEntryData>>> watchAllTimetableEntries() {
    return (appDataBase.select(appDataBase.timetableEntry)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableEntryData>>>(
          (entries) => Right(entries),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message:
                  "Failed to retrieve timetable entries please try again later",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByTimetableId({required String timetableId}) {
    return (appDataBase.select(appDataBase.timetableEntry)
          ..where((t) => t.timetableId.equals(timetableId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableEntryData>>>(
          (entries) => Right(entries),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetable entries for timetable",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByCourseId({required String courseId}) {
    return (appDataBase.select(appDataBase.timetableEntry)
          ..where((t) => t.courseId.equals(courseId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableEntryData>>>(
          (entries) => Right(entries),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetable entries for course",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByUserId({required String userId}) {
    return (appDataBase.select(appDataBase.timetableEntry)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableEntryData>>>(
          (entries) => Right(entries),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetable entries for user",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableEntryData>>>
  watchTimetableEntriesByInstitutionId({required int institutionId}) {
    return (appDataBase.select(appDataBase.timetableEntry)
          ..where((t) => t.institutionId.equals(institutionId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableEntryData>>>(
          (entries) => Right(entries),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetable entries for institution",
            ),
          ),
        );
  }

  @override
  Future<Either<Failure, TimetableEntryData>> getTimetableEntryById({
    required String id,
  }) async {
    try {
      final query = appDataBase.select(appDataBase.timetableEntry)
        ..where((t) => t.id.equals(id))
        ..where((t) => t.isDeleted.equals(false));

      final result = await query.getSingle();
      return Right(result);
    } catch (e) {
      return Left(
        CacheFailure(message: "Timetable entry not found!", error: e),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetableEntryById({
    required String id,
  }) async {
    try {
      final wasMarked = await _markForDeletion(id);

      return wasMarked.fold(
        (failure) => Left(failure),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(
        CacheFailure(
          message: "Failed to delete specified timetable entry!",
          error: e,
        ),
      );
    }
  }

  /// Soft Delete: Updates the isDeleted flag.
  /// This is what the UI calls when a user hits "Delete".
  Future<Either<Failure, Unit>> _markForDeletion(String id) async {
    try {
      await (appDataBase.update(appDataBase.timetableEntry)
            ..where((t) => t.id.equals(id)))
          .write(TimetableEntryCompanion(isDeleted: Value(true)));
      return const Right(unit);
    } catch (e) {
      return Left(
        CacheFailure(
          message: "Could not mark timetable entry for deletion",
          error: e,
        ),
      );
    }
  }

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  @override
  Future<Either<Failure, Unit>> hardDeleteTimetableEntry(String id) async {
    try {
      await (appDataBase.delete(
        appDataBase.timetableEntry,
      )..where((t) => t.id.equals(id))).go();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: "Permanent deletion failed", error: e));
    }
  }
}

