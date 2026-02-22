import 'package:academia/core/error/failures.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Repository contract for Course operations.
/// This layer works exclusively with [CourseEntity].
abstract class CourseRepository {
  /// Stream of courses for real-time UI updates.
  Stream<Either<Failure, List<CourseEntity>>> watchAllCourses();

  /// Creates a new course or updates an existing one.
  Future<Either<Failure, Unit>> saveCourse(CourseEntity course);

  /// Triggers a soft delete (mark for deletion) to support offline sync.
  Future<Either<Failure, Unit>> deleteCourse(String id);

  /// Retrieves a single course by its local UUID.
  Future<Either<Failure, CourseEntity>> getCourse(String id);


  /// Watches courses specifically linked to one institution.
  Stream<Either<Failure, List<CourseEntity>>> watchCoursesByInstitution(
    int institutionId,
  );
}
