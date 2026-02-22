import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

/// An abstract contract for interacting with the local SQLite database via Drift
/// for Timetable-related data operations.
///
/// This datasource is responsible for the "Local" part of the offline-first
/// architecture, ensuring that the UI remains responsive even without a
/// network connection.
abstract class TimetableLocalDatasource {
  /// Persists a timetable to the local database.
  ///
  /// If a timetable with the same primary key already exists, it updates the record.
  /// This is used both for initial local creation and for caching data
  /// returned from the remote server.
  ///
  /// Returns [Unit] on success or a [Failure] on database write errors.
  Future<Either<Failure, Unit>> createOrUpdateTimetable({
    required TimetableCompanion timetable,
  });

  /// Provides a real-time [Stream] of all timetables currently stored in the
  /// local database.
  ///
  /// Useful for populating global timetable lists that update automatically
  /// when data is synced or modified.
  Stream<Either<Failure, List<TimetableData>>> watchAllTimetables();

  /// Watches a filtered list of timetables belonging to a specific user.
  ///
  /// [userId] is the user identifier.
  /// This stream emits a new list whenever any timetable matching this
  /// user ID is modified.
  Stream<Either<Failure, List<TimetableData>>> watchTimetablesByUserId({
    required String userId,
  });

  /// Watches a filtered list of timetables belonging to a specific institution.
  ///
  /// [institutionId] is the remote server identifier for the institution.
  /// This stream emits a new list whenever any timetable matching this
  /// ID is modified.
  Stream<Either<Failure, List<TimetableData>>> watchTimetablesByInstitutionId({
    required int institutionId,
  });

  /// Retrieves a specific timetable by its local unique identifier (UUID).
  ///
  /// [id] refers to the `cache_id` (primary key) used for local tracking.
  /// Returns [TimetableData] if found, otherwise returns a [Failure].
  Future<Either<Failure, TimetableData>> getTimetableById({required String id});

  /// Marks a timetable for deletion (soft delete).
  ///
  /// [id] is the identifier for the timetable to be removed.
  /// Note: In an offline-first system, this triggers a "soft delete"
  /// flag to ensure the deletion is eventually synced to the server.
  Future<Either<Failure, Unit>> deleteTimetableById({required String id});

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  Future<Either<Failure, Unit>> hardDeleteTimetable(String id);
}

class TimetableLocalDatasourceImpl extends TimetableLocalDatasource {
  final AppDataBase appDataBase;

  TimetableLocalDatasourceImpl({required this.appDataBase});

  @override
  Future<Either<Failure, Unit>> createOrUpdateTimetable({
    required TimetableCompanion timetable,
  }) async {
    try {
      // into() creates an insert statement.
      // insertOnConflictUpdate handles the "Create or Update" logic.
      await appDataBase
          .into(appDataBase.timetable)
          .insertOnConflictUpdate(timetable);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }

  @override
  Stream<Either<Failure, List<TimetableData>>> watchAllTimetables() {
    return (appDataBase.select(appDataBase.timetable)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableData>>>(
          (timetables) => Right(timetables),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to retrieve timetables please try again later",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableData>>> watchTimetablesByUserId({
    required String userId,
  }) {
    return (appDataBase.select(appDataBase.timetable)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableData>>>(
          (timetables) => Right(timetables),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetables for user",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<TimetableData>>> watchTimetablesByInstitutionId({
    required int institutionId,
  }) {
    return (appDataBase.select(appDataBase.timetable)
          ..where((t) => t.institution.equals(institutionId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<TimetableData>>>(
          (timetables) => Right(timetables),
        )
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter timetables for institution",
            ),
          ),
        );
  }

  @override
  Future<Either<Failure, TimetableData>> getTimetableById({
    required String id,
  }) async {
    try {
      final query = appDataBase.select(appDataBase.timetable)
        ..where((t) => t.id.equals(id))
        ..where((t) => t.isDeleted.equals(false));

      final result = await query.getSingle();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: "Timetable not found!", error: e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetableById({
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
          message: "Failed to delete specified timetable!",
          error: e,
        ),
      );
    }
  }

  /// Soft Delete: Updates the isDeleted flag.
  /// This is what the UI calls when a user hits "Delete".
  Future<Either<Failure, Unit>> _markForDeletion(String id) async {
    try {
      await (appDataBase.update(appDataBase.timetable)
            ..where((t) => t.id.equals(id)))
          .write(TimetableCompanion(isDeleted: Value(true)));
      return const Right(unit);
    } catch (e) {
      return Left(
        CacheFailure(
          message: "Could not mark timetable for deletion",
          error: e,
        ),
      );
    }
  }

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  @override
  Future<Either<Failure, Unit>> hardDeleteTimetable(String id) async {
    try {
      await (appDataBase.delete(
        appDataBase.timetable,
      )..where((t) => t.id.equals(id))).go();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: "Permanent deletion failed", error: e));
    }
  }
}
