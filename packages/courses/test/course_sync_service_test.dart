import 'package:core/core.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/data/services/course_sync_service.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabaseV2 database;
  late CourseDao courseDao;
  late _RecordingCourseRemote remote;
  late CourseSyncService syncService;
  final now = DateTime(2026, 9, 29);

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    courseDao = CourseDao(database);
    remote = _RecordingCourseRemote();
    syncService = CourseSyncService(remote: remote, courseDao: courseDao);
  });

  tearDown(() => database.close());

  test(
    'syncs an entry only after its pending parent course succeeds',
    () async {
      await _insertCourse(database, now);
      await database
          .into(database.scheduleEntries)
          .insert(
            ScheduleEntriesCompanion.insert(
              id: 'entry-local',
              studentCourseId: 'course-local',
              idempotencyKey: const Value('entry-key'),
              syncStatus: const Value('pending'),
              dayOfWeek: 'monday',
              startTime: '09:00',
              endTime: '10:00',
              createdAt: now,
              updatedAt: now,
              cachedAt: now,
            ),
          );
      remote.courseResults.addAll([
        const Left(NetworkFailure(message: 'offline')),
        Right(_courseDto('course-server')),
      ]);

      await syncService.syncPending();
      expect(remote.calls, ['course:course-local']);

      await syncService.syncPending();
      expect(remote.calls, [
        'course:course-local',
        'course:course-local',
        'schedule:course-server',
      ]);
    },
  );

  test('reuses a course idempotency key after a network retry', () async {
    await _insertCourse(database, now);
    remote.courseResults.addAll([
      const Left(NetworkFailure(message: 'offline')),
      Right(_courseDto('course-server')),
    ]);

    await syncService.syncPending();
    await syncService.syncPending();

    expect(remote.courseIdempotencyKeys, ['course-key', 'course-key']);
  });

  test('archives synced courses after their term end date', () async {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    await _insertCourse(
      database,
      now,
      serverId: 'course-server',
      termEndDate: yesterday,
    );
    remote.archiveResults.add(
      Right(_courseDto('course-server').copyWith(archivedAt: today)),
    );

    await syncService.syncPending();

    expect(remote.archiveCalls, ['course-server']);
    final archivedAt = (await courseDao.archivedCourses()).single.archivedAt;
    expect(archivedAt, isNotNull);
    expect(archivedAt!.year, today.year);
    expect(archivedAt.month, today.month);
    expect(archivedAt.day, today.day);
  });

  test('keeps a course active through its term end date', () async {
    final today = DateTime.now();
    final endOfToday = DateTime(today.year, today.month, today.day);
    await _insertCourse(
      database,
      now,
      serverId: 'course-server',
      termEndDate: endOfToday,
    );

    await syncService.syncPending();

    expect(remote.archiveCalls, isEmpty);
    expect((await courseDao.activeCourses()).single.archivedAt, isNull);
  });
}

Future<void> _insertCourse(
  AppDatabaseV2 database,
  DateTime now, {
  String? serverId,
  DateTime? termEndDate,
}) {
  return database
      .into(database.courses)
      .insert(
        CoursesCompanion.insert(
          id: 'course-local',
          serverId: Value(serverId),
          institutionId: 1,
          title: 'Algorithms',
          idempotencyKey: const Value('course-key'),
          syncStatus: Value(serverId == null ? 'pending' : 'synced'),
          termEndDate: Value(termEndDate),
          createdAt: now,
          updatedAt: now,
          cachedAt: now,
        ),
      );
}

CourseDto _courseDto(String id) => CourseDto(
  id: id,
  institution: 1,
  title: 'Algorithms',
  createdAt: DateTime(2026, 9, 29),
  updatedAt: DateTime(2026, 9, 29),
);

class _RecordingCourseRemote implements CourseRemoteDatasource {
  final calls = <String>[];
  final courseIdempotencyKeys = <String?>[];
  final archiveCalls = <String>[];
  final courseResults = <Either<Failure, CourseDto>>[];
  final archiveResults = <Either<Failure, CourseDto>>[];

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
  }) async {
    calls.add('course:course-local');
    courseIdempotencyKeys.add(idempotencyKey);
    return courseResults.removeAt(0);
  }

  @override
  Future<Either<Failure, ScheduleEntryDto>> createScheduleEntry({
    required String courseId,
    required ScheduleEntryDto entry,
    String? idempotencyKey,
  }) async {
    calls.add('schedule:$courseId');
    return Right(entry.copyWith(id: 'entry-server'));
  }

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>> activeCourses() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, PaginatedResponse<CourseDto>>> archivedCourses() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, CourseDto>> getCourse(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, CourseDto>> updateCourse(CourseDto course) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, CourseDto>> archiveCourse(String id) async {
    archiveCalls.add(id);
    return archiveResults.removeAt(0);
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, LecturerDto>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, LecturerDto>> updateLecturer(LecturerDto lecturer) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> deleteLecturer(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, ScheduleEntryDto>> updateScheduleEntry(
    ScheduleEntryDto entry,
  ) => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> deleteScheduleEntry(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, List<ScheduleEntryDto>>> studentSchedule() =>
      throw UnimplementedError();
}
