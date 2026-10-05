import 'package:core/core.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/data/repositories/course_repository_impl.dart';
import 'package:courses/src/data/services/course_sync_service.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabaseV2 database;
  late CourseDao courseDao;
  late _CourseRemote remote;
  late CourseRepositoryImpl repository;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    courseDao = CourseDao(database);
    remote = _CourseRemote();
    repository = CourseRepositoryImpl(
      remote,
      courseDao,
      _NoopCourseSyncService(remote: remote, courseDao: courseDao),
    );
  });

  tearDown(() => database.close());

  test('omits live schedule entries after their course term ends', () async {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    final now = DateTime.now();
    remote.activeCoursesResult = Right(
      PaginatedResponse<CourseDto>(
        count: 1,
        next: null,
        previous: null,
        results: [
          CourseDto(
            id: 'course-server',
            institution: 1,
            title: 'Finished course',
            termEndDate: yesterday,
            createdAt: now,
            updatedAt: now,
          ),
        ],
      ),
    );
    remote.studentScheduleResult = Right([
      ScheduleEntryDto(
        id: 'entry-server',
        dayOfWeek: 'monday',
        startTime: '09:00',
        endTime: '10:00',
        course: const ScheduleCourseDto(
          id: 'course-server',
          title: 'Finished course',
        ),
      ),
    ]);

    final result = await repository.listStudentSchedule();

    result.fold(
      (failure) => fail(failure.message),
      (entries) => expect(entries, isEmpty),
    );
  });

  test('keeps the course end date on weekly schedule entries', () async {
    final today = DateTime.now();
    final termEndDate = DateTime(today.year, today.month, today.day + 7);
    final now = DateTime.now();
    remote.activeCoursesResult = Right(
      PaginatedResponse<CourseDto>(
        count: 1,
        next: null,
        previous: null,
        results: [
          CourseDto(
            id: 'course-server',
            institution: 1,
            title: 'Current course',
            termEndDate: termEndDate,
            createdAt: now,
            updatedAt: now,
          ),
        ],
      ),
    );
    remote.studentScheduleResult = Right([
      ScheduleEntryDto(
        id: 'entry-server',
        dayOfWeek: 'monday',
        startTime: '09:00',
        endTime: '10:00',
        course: const ScheduleCourseDto(
          id: 'course-server',
          title: 'Current course',
        ),
      ),
    ]);

    final result = await repository.listStudentSchedule();

    result.fold((failure) => fail(failure.message), (entries) {
      expect(entries, hasLength(1));
      expect(entries.single.courseTermEndDate, termEndDate);
    });
  });

  test('keeps ended courses visible in the archive list', () async {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    final now = DateTime.now();
    remote.archivedCoursesResult = Right(
      PaginatedResponse<CourseDto>(
        count: 1,
        next: null,
        previous: null,
        results: [
          CourseDto(
            id: 'course-server',
            institution: 1,
            title: 'Archived course',
            termEndDate: yesterday,
            archivedAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        ],
      ),
    );

    final result = await repository.listArchivedCourses();

    result.fold(
      (failure) => fail(failure.message),
      (courses) =>
          expect(courses.map((course) => course.title), ['Archived course']),
    );
  });
}

class _NoopCourseSyncService extends CourseSyncService {
  _NoopCourseSyncService({required super.remote, required super.courseDao});

  @override
  void startListening() {}

  @override
  Future<void> syncPending() async {}
}

class _CourseRemote implements CourseRemoteDatasource {
  late Either<Failure, PaginatedResponse<CourseDto>> activeCoursesResult;
  late Either<Failure, PaginatedResponse<CourseDto>> archivedCoursesResult;
  late Either<Failure, List<ScheduleEntryDto>> studentScheduleResult;

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>> activeCourses() async =>
      activeCoursesResult;

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>>
  archivedCourses() async => archivedCoursesResult;

  @override
  Future<Either<Failure, List<ScheduleEntryDto>>> studentSchedule() async =>
      studentScheduleResult;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
