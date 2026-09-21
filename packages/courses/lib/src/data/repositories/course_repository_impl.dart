import 'package:core/core.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/data/mappers/course_mapper.dart';
import 'package:courses/src/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl(this._remote, this._courseDao);

  final CourseRemoteDatasource _remote;
  final CourseDao _courseDao;

  @override
  Future<Either<Failure, List<CourseEntity>>> listActiveCourses() {
    return _list(_remote.activeCourses, _courseDao.activeCourses);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> listArchivedCourses() {
    return _list(_remote.archivedCourses, _courseDao.archivedCourses);
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourse(String id) async {
    final result = await _remote.getCourse(id);
    return result.fold(
      (failure) async {
        try {
          final cached = await _courseDao.courseById(id);
          if (cached == null) return left(failure);
          return right(await _cachedCourse(cached));
        } catch (error, stackTrace) {
          return left(
            Failure.cache(
              message: 'Failed to read cached course',
              error: error,
              stackTrace: stackTrace,
            ),
          );
        }
      },
      (course) async {
        await _cache(course);
        return right(course.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, CourseEntity>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
  }) async {
    final result = await _remote.createCourse(
      institutionId: institutionId,
      title: title,
      code: code,
      termLabel: termLabel,
      academicYear: academicYear,
      termStartDate: termStartDate,
      termEndDate: termEndDate,
      previousCourseId: previousCourseId,
    );
    return _cacheResult(result);
  }

  @override
  Future<Either<Failure, CourseEntity>> updateCourse(
    CourseEntity course,
  ) async {
    return _cacheResult(await _remote.updateCourse(course.toDto()));
  }

  @override
  Future<Either<Failure, CourseEntity>> archiveCourse(String id) async {
    return _cacheResult(await _remote.archiveCourse(id));
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) async {
    final result = await _remote.deleteCourse(id);
    if (result.isRight()) await _courseDao.deleteCourse(id);
    return result;
  }

  @override
  Future<Either<Failure, LecturerEntity>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) async {
    final result = await _remote.addLecturer(
      courseId: courseId,
      name: name,
      email: email,
      phone: phone,
      office: office,
    );
    return result.fold((failure) => left(failure), (lecturer) async {
      await _refreshCourse(courseId);
      return right(lecturer.toDomain(courseId: courseId));
    });
  }

  @override
  Future<Either<Failure, LecturerEntity>> updateLecturer(
    LecturerEntity lecturer,
  ) async {
    final result = await _remote.updateLecturer(lecturer.toDto());
    return result.fold(left, (updated) async {
      await _refreshCourse(lecturer.courseId);
      return right(updated.toDomain(courseId: lecturer.courseId));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteLecturer(LecturerEntity lecturer) async {
    final result = await _remote.deleteLecturer(lecturer.id);
    if (result.isRight()) await _refreshCourse(lecturer.courseId);
    return result;
  }

  Future<Either<Failure, List<CourseEntity>>> _list(
    Future<Either<Failure, PaginatedResponse<CourseDto>>> Function() remote,
    Future<List<Course>> Function() cached,
  ) async {
    final result = await remote();
    return result.fold(
      (failure) async {
        try {
          final courses = await cached();
          return right(await Future.wait(courses.map(_cachedCourse)));
        } catch (error, stackTrace) {
          return left(
            Failure.cache(
              message: 'Failed to read cached courses',
              error: error,
              stackTrace: stackTrace,
            ),
          );
        }
      },
      (page) async {
        await Future.wait(page.results.map(_cache));
        return right(page.results.map((course) => course.toDomain()).toList());
      },
    );
  }

  Future<Either<Failure, CourseEntity>> _cacheResult(
    Either<Failure, CourseDto> result,
  ) {
    return result.fold(
      (failure) async => left<Failure, CourseEntity>(failure),
      (course) async {
        await _cache(course);
        return right(course.toDomain());
      },
    );
  }

  Future<void> _cache(CourseDto course) {
    final cachedAt = DateTime.now();
    return _courseDao.replaceCourse(
      course: course.toCompanion(cachedAt),
      lecturers: course.lecturers
          .map((lecturer) => lecturer.toCompanion(course.id))
          .toList(),
    );
  }

  Future<void> _refreshCourse(String id) async {
    final result = await _remote.getCourse(id);
    await result.fold((_) async {}, _cache);
  }

  Future<CourseEntity> _cachedCourse(Course course) async {
    return course.toDomain(await _courseDao.lecturersForCourse(course.id));
  }
}
