import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

/// An abstract contract for interacting with the local SQLite database via Drift
/// for Course-related data operations.
///
/// This datasource is responsible for the "Local" part of the offline-first
/// architecture, ensuring that the UI remains responsive even without a
/// network connection.
abstract class CourseLocalDatasource {
  /// Persists a course to the local database.
  ///
  /// If a course with the same primary key already exists, it updates the record.
  /// This is used both for initial local creation and for caching data
  /// returned from the remote server.
  ///
  /// Returns [Unit] on success or a [Failure] on database write errors.
  Future<Either<Failure, Unit>> createOrUpdateCourse({
    required CourseData course,
  });

  /// Provides a real-time [Stream] of all courses currently stored in the
  /// local database.
  ///
  /// Useful for populating global course lists that update automatically
  /// when data is synced or modified.
  Stream<Either<Failure, List<CourseData>>> watchAllCourses();

  /// Watches a filtered list of courses belonging to a specific institution.
  ///
  /// [institutionId] is the remote server identifier for the institution.
  /// This stream emits a new list whenever any course matching this
  /// ID is modified.
  Stream<Either<Failure, List<CourseData>>> watchCoursesByInstitutionId({
    required int institutionId,
  });

  /// Retrieves a specific course by its local unique identifier (UUID).
  ///
  /// [id] refers to the `cache_id` (primary key) used for local tracking.
  /// Returns [CourseData] if found, otherwise returns a [Failure].
  Future<Either<Failure, CourseData>> getCourseById({required String id});

  /// Marks a course for deletion or removes it from the local database.
  ///
  /// [course] is the identifier for the course to be removed.
  /// Note: In an offline-first system, this may trigger a "soft delete"
  /// flag to ensure the deletion is eventually synced to the server.
  Future<Either<Failure, Unit>> deleteCourseById({required String course});

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  Future<Either<Failure, Unit>> hardDeleteCourse(String id);
}

class CourseLocalDatasourceImpl extends CourseLocalDatasource {
  final AppDataBase appDataBase;

  CourseLocalDatasourceImpl({required this.appDataBase});

  @override
  Future<Either<Failure, Unit>> createOrUpdateCourse({
    required CourseData course,
  }) async {
    try {
      // into() creates an insert statement.
      // insertOnConflictUpdate handles the "Create or Update" logic.
      await appDataBase.into(appDataBase.course).insertOnConflictUpdate(course);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }

  @override
  Stream<Either<Failure, List<CourseData>>> watchAllCourses() {
    return (appDataBase.select(appDataBase.course)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<CourseData>>>((courses) => Right(courses))
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to retrieve courses please try again later",
            ),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<CourseData>>> watchCoursesByInstitutionId({
    required int institutionId,
  }) {
    return (appDataBase.select(appDataBase.course)
          ..where((t) => t.institution.equals(institutionId))
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map<Either<Failure, List<CourseData>>>((courses) => Right(courses))
        .handleError(
          (error) => Left(
            CacheFailure(
              error: error,
              message: "Failed to filter courses for institution",
            ),
          ),
        );
  }

  @override
  Future<Either<Failure, CourseData>> getCourseById({
    required String id,
  }) async {
    try {
      final query = appDataBase.select(appDataBase.course)
        ..where((t) => t.id.equals(id))
        ..where((t) => t.isDeleted.equals(false));

      final result = await query.getSingle();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: "Course not found!", error: e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCourseById({
    required String course,
  }) async {
    try {
      final wasMarked = await _markForDeletion(course);

      return wasMarked.fold(
        (failure) => Left(failure),
        (_) => const Right(unit),
      );
    } catch (e) {
      return Left(
        CacheFailure(message: "Failed to delete specified course!", error: e),
      );
    }
  }

  /// Soft Delete: Updates the isDeleted flag.
  /// This is what the UI calls when a user hits "Delete".
  Future<Either<Failure, Unit>> _markForDeletion(String id) async {
    try {
      await (appDataBase.update(appDataBase.course)
            ..where((t) => t.id.equals(id)))
          .write(CourseCompanion(isDeleted: Value(true)));
      return const Right(unit);
    } catch (e) {
      return Left(
        CacheFailure(message: "Could not mark course for deletion", error: e),
      );
    }
  }

  /// Hard Delete: Actually removes the row from SQLite.
  /// Call this ONLY after the server confirms deletion OR for
  /// local-only cache cleanup.
  Future<Either<Failure, Unit>> hardDeleteCourse(String id) async {
    try {
      await (appDataBase.delete(
        appDataBase.course,
      )..where((t) => t.id.equals(id))).go();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(message: "Permanent deletion failed", error: e));
    }
  }
}
