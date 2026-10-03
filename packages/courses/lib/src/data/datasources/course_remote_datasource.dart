import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'course_api_paths.dart';
import '../dtos/dtos.dart';

abstract interface class CourseRemoteDatasource {
  Future<Either<Failure, CourseDto>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? color,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
    String? idempotencyKey,
  });

  Future<Either<Failure, PaginatedResponse<CourseDto>>> activeCourses();
  Future<Either<Failure, PaginatedResponse<CourseDto>>> archivedCourses();
  Future<Either<Failure, CourseDto>> getCourse(String id);
  Future<Either<Failure, CourseDto>> updateCourse(CourseDto course);
  Future<Either<Failure, CourseDto>> archiveCourse(String id);
  Future<Either<Failure, Unit>> deleteCourse(String id);
  Future<Either<Failure, LecturerDto>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  });
  Future<Either<Failure, LecturerDto>> updateLecturer(LecturerDto lecturer);
  Future<Either<Failure, Unit>> deleteLecturer(String id);
  Future<Either<Failure, ScheduleEntryDto>> createScheduleEntry({
    required String courseId,
    required ScheduleEntryDto entry,
    String? idempotencyKey,
  });
  Future<Either<Failure, ScheduleEntryDto>> updateScheduleEntry(
    ScheduleEntryDto entry,
  );
  Future<Either<Failure, Unit>> deleteScheduleEntry(String id);
  Future<Either<Failure, List<ScheduleEntryDto>>> studentSchedule();
}

@LazySingleton(as: CourseRemoteDatasource)
class CourseRemoteDatasourceImpl implements CourseRemoteDatasource {
  CourseRemoteDatasourceImpl(this._apiClient, this._paths);

  final ApiClient _apiClient;
  final CourseApiPaths _paths;

  @override
  Future<Either<Failure, CourseDto>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? color,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
    String? idempotencyKey,
  }) {
    return _apiClient.post(
      _paths.create,
      data: _withoutNulls({
        'institution': institutionId,
        'title': title,
        'code': code,
        'color': color,
        'term_label': termLabel,
        'academic_year': academicYear,
        'term_start_date': termStartDate?.toIso8601String().split('T').first,
        'term_end_date': termEndDate?.toIso8601String().split('T').first,
        'previous_course': previousCourseId,
        'idempotency_key': idempotencyKey,
      }),
      decoder: (json) => CourseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>> activeCourses() {
    return _list(_paths.active);
  }

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>> archivedCourses() {
    return _list(_paths.archived);
  }

  @override
  Future<Either<Failure, CourseDto>> getCourse(String id) {
    return _apiClient.get(
      _paths.course(id),
      decoder: (json) => CourseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, CourseDto>> updateCourse(CourseDto course) {
    return _apiClient.patch(
      _paths.course(course.id),
      data: {
        'institution': course.institution,
        'title': course.title,
        'code': course.code,
        'color': course.color,
        'term_label': course.termLabel,
        'academic_year': course.academicYear,
        'term_start_date': course.termStartDate
            ?.toIso8601String()
            .split('T')
            .first,
        'term_end_date': course.termEndDate?.toIso8601String().split('T').first,
        'previous_course': course.previousCourse,
      },
      decoder: (json) => CourseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, CourseDto>> archiveCourse(String id) {
    return _apiClient.post(
      _paths.archive(id),
      decoder: (json) => CourseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) {
    return _apiClient.delete(_paths.course(id), decoder: (_) => unit);
  }

  @override
  Future<Either<Failure, LecturerDto>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) {
    return _apiClient.post(
      _paths.lecturers(courseId),
      data: _withoutNulls({
        'name': name,
        'email': email,
        'phone': phone,
        'office': office,
      }),
      decoder: (json) => LecturerDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, LecturerDto>> updateLecturer(LecturerDto lecturer) {
    return _apiClient.patch(
      _paths.lecturer(lecturer.id),
      data: _withoutNulls({
        'name': lecturer.name,
        'email': lecturer.email,
        'phone': lecturer.phone,
        'office': lecturer.office,
      }),
      decoder: (json) => LecturerDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteLecturer(String id) {
    return _apiClient.delete(_paths.lecturer(id), decoder: (_) => unit);
  }

  @override
  Future<Either<Failure, ScheduleEntryDto>> createScheduleEntry({
    required String courseId,
    required ScheduleEntryDto entry,
    String? idempotencyKey,
  }) {
    return _apiClient.post(
      _paths.schedule(courseId),
      data: _scheduleBody(entry, idempotencyKey: idempotencyKey),
      decoder: (json) =>
          ScheduleEntryDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, ScheduleEntryDto>> updateScheduleEntry(
    ScheduleEntryDto entry,
  ) {
    return _apiClient.patch(
      _paths.scheduleEntry(entry.id),
      data: _scheduleBody(entry, includeNulls: true),
      decoder: (json) =>
          ScheduleEntryDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteScheduleEntry(String id) {
    return _apiClient.delete(_paths.scheduleEntry(id), decoder: (_) => unit);
  }

  @override
  Future<Either<Failure, List<ScheduleEntryDto>>> studentSchedule() {
    return _apiClient.get(
      _paths.studentSchedule,
      decoder: (json) => (json as List<dynamic>)
          .map(
            (item) => ScheduleEntryDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Future<Either<Failure, PaginatedResponse<CourseDto>>> _list(String path) {
    return _apiClient.get(
      path,
      decoder: (json) => PaginatedResponse<CourseDto>.fromJson(
        json as Map<String, dynamic>,
        (item) => CourseDto.fromJson(item! as Map<String, dynamic>),
      ),
    );
  }
}

Map<String, dynamic> _scheduleBody(
  ScheduleEntryDto entry, {
  String? idempotencyKey,
  bool includeNulls = false,
}) {
  final values = <String, dynamic>{
    'day_of_week': entry.dayOfWeek,
    'start_time': entry.startTime.substring(0, 5),
    'end_time': entry.endTime.substring(0, 5),
    'venue': entry.venue,
    'campus': entry.campus,
    'section': entry.section,
    'label': entry.label,
    'color': entry.color,
    'is_recurring': entry.isRecurring,
    'specific_date': entry.isRecurring
        ? null
        : entry.specificDate?.toIso8601String().split('T').first,
  };
  if (idempotencyKey != null) values['idempotency_key'] = idempotencyKey;
  if (!includeNulls) values.removeWhere((_, value) => value == null);
  return values;
}

Map<String, dynamic> _withoutNulls(Map<String, dynamic> values) {
  values.removeWhere((_, value) => value == null);
  return values;
}
