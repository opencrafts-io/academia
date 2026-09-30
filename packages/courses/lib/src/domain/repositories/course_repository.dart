import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract interface class CourseRepository {
  Stream<SyncStatusUpdate> get syncStatusUpdates;
  Future<Either<Failure, List<CourseEntity>>> listActiveCourses();
  Future<Either<Failure, List<CourseEntity>>> listArchivedCourses();
  Future<Either<Failure, CourseEntity>> getCourse(String id);
  Future<Either<Failure, CourseEntity>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? color,
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
  Future<Either<Failure, List<ScheduleEntryEntity>>> listStudentSchedule();
  Future<Either<Failure, ScheduleEntryEntity>> createScheduleEntry(
    ScheduleEntryEntity entry,
  );
  Future<Either<Failure, ScheduleEntryEntity>> updateScheduleEntry(
    ScheduleEntryEntity entry,
  );
  Future<Either<Failure, Unit>> deleteScheduleEntry(String id);
}
