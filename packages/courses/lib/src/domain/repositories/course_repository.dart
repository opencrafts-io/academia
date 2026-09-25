import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract interface class CourseRepository {
  Future<Either<Failure, List<CourseEntity>>> listActiveCourses();
  Future<Either<Failure, List<CourseEntity>>> listArchivedCourses();
  Future<Either<Failure, CourseEntity>> getCourse(String id);
  Future<Either<Failure, CourseEntity>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
  });
  Future<Either<Failure, CourseEntity>> updateCourse(CourseEntity course);
  Future<Either<Failure, CourseEntity>> archiveCourse(String id);
  Future<Either<Failure, Unit>> deleteCourse(String id);
  Future<Either<Failure, LecturerEntity>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  });
  Future<Either<Failure, LecturerEntity>> updateLecturer(
    LecturerEntity lecturer,
  );
  Future<Either<Failure, Unit>> deleteLecturer(LecturerEntity lecturer);
}
