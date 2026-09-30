import 'dart:async';

import 'package:core/core.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/data/mappers/course_mapper.dart';
import 'package:courses/src/data/services/course_sync_service.dart';
import 'package:courses/src/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl(this._remote, this._courseDao, this._sync) {
    _sync.startListening();
  }

  final CourseRemoteDatasource _remote;
  final CourseDao _courseDao;
  final CourseSyncService _sync;
  final _uuid = const Uuid();

  @override
  Stream<SyncStatusUpdate> get syncStatusUpdates => _sync.changes;

  @override
  Future<Either<Failure, List<CourseEntity>>> listActiveCourses() => _list(
    _remote.activeCourses,
    _courseDao.activeCourses,
    archiveExpiredCourses: true,
  );

  @override
  Future<Either<Failure, List<CourseEntity>>> listArchivedCourses() =>
      _list(_remote.archivedCourses, _courseDao.archivedCourses);

  @override
  Future<Either<Failure, CourseEntity>> getCourse(String id) async {
    final cached = await _courseDao.courseById(id);
    final serverId = cached?.serverId ?? id;
    final result = await _remote.getCourse(serverId);
    return result.fold(
      (failure) async {
        final local = cached ?? await _courseDao.courseByServerId(id);
        if (local == null) return left(failure);
        return right(await _cachedCourse(local));
      },
      (course) async {
        final localId = await _cache(course);
        return right(await _cachedCourseById(localId));
      },
    );
  }

  @override
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
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _courseDao.saveCourse(
      CoursesCompanion.insert(
        id: id,
        idempotencyKey: Value(_uuid.v4()),
        syncStatus: const Value('pending'),
        institutionId: institutionId,
        title: title,
        code: Value(code),
        color: Value(color),
        termLabel: Value(termLabel),
        academicYear: Value(academicYear),
        termStartDate: Value(termStartDate),
        termEndDate: Value(termEndDate),
        previousCourseId: Value(previousCourseId),
        createdAt: now,
        updatedAt: now,
        cachedAt: now,
      ),
    );
    unawaited(_sync.syncPending());
    return right(await _cachedCourseById(id));
  }

  @override
  Future<Either<Failure, CourseEntity>> updateCourse(
    CourseEntity course,
  ) async {
    final cached = await _courseDao.courseById(course.id);
    if (cached == null) {
      return left(
        Failure.cache(message: 'This course is not available locally.'),
      );
    }
    if (cached.serverId == null) {
      await _courseDao.saveCourse(_localCourseCompanion(course, cached));
      unawaited(_sync.syncPending());
      return right(await _cachedCourseById(course.id));
    }

    final previousCourseId = await _serverCourseId(course.previousCourseId);
    final result = await _remote.updateCourse(
      course.toDto().copyWith(
        id: cached.serverId!,
        previousCourse: previousCourseId,
      ),
    );
    return _cacheResult(result);
  }

  @override
  Future<Either<Failure, CourseEntity>> archiveCourse(String id) async {
    final cached = await _courseDao.courseById(id);
    if (cached?.serverId == null) {
      return left(
        Failure.validation(
          message: 'This course must sync before it can be archived.',
        ),
      );
    }
    return _cacheResult(await _remote.archiveCourse(cached!.serverId!));
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) async {
    final cached = await _courseDao.courseById(id);
    if (cached == null || cached.serverId == null) {
      await _courseDao.deleteCourse(id);
      return right(unit);
    }
    final result = await _remote.deleteCourse(cached.serverId!);
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
    final serverId = await _serverCourseId(courseId);
    if (serverId == null) return _courseNotSynced();
    final result = await _remote.addLecturer(
      courseId: serverId,
      name: name,
      email: email,
      phone: phone,
      office: office,
    );
    return result.fold(left, (lecturer) async {
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

  @override
  Future<Either<Failure, List<ScheduleEntryEntity>>>
  listStudentSchedule() async {
    // The timetable endpoint includes only a compact nested course summary.
    // Cache active courses first so every schedule FK can use the local ID.
    final activeCourses = await _remote.activeCourses();
    await activeCourses.fold((_) async {}, (page) async {
      for (final course in page.results) {
        await _cache(course);
      }
    });
    await _sync.syncPending();

    final result = await _remote.studentSchedule();
    return result.fold(
      (failure) async {
        try {
          return right(await _cachedStudentSchedule());
        } catch (error, stackTrace) {
          return left(
            Failure.cache(
              message: 'Failed to read the saved timetable.',
              error: error,
              stackTrace: stackTrace,
            ),
          );
        }
      },
      (entries) async {
        final local = <ScheduleEntryEntity>[];
        for (final entry in entries) {
          final courseServerId = entry.course?.id;
          if (courseServerId == null) continue;
          final course =
              await _courseDao.courseByServerId(courseServerId) ??
              await _courseDao.courseById(courseServerId);
          if (course != null &&
              (course.archivedAt != null ||
                  hasCourseTermEnded(course.termEndDate))) {
            continue;
          }
          if (course == null) {
            local.add(entry.toDomain(courseId: courseServerId));
            continue;
          }
          final localId = await _cacheScheduleEntry(entry, course.id);
          final cachedEntry = await _courseDao.scheduleEntryById(localId);
          if (cachedEntry != null) {
            local.add(
              cachedEntry.toDomain(
                courseTitle: entry.course?.title,
                courseCode: entry.course?.code,
                courseColor: entry.course?.color,
                courseTermEndDate: course.termEndDate,
              ),
            );
          }
        }
        final cached = await _cachedStudentSchedule();
        final cachedIds = cached
            .map((entry) => entry.serverId ?? entry.id)
            .toSet();
        cached.addAll(
          local.where(
            (entry) => !cachedIds.contains(entry.serverId ?? entry.id),
          ),
        );
        _sortSchedule(cached);
        return right(cached);
      },
    );
  }

  @override
  Future<Either<Failure, List<ScheduleEntryEntity>>>
  listCachedStudentSchedule() async {
    try {
      return right(await _cachedStudentSchedule());
    } catch (error, stackTrace) {
      return left(
        Failure.cache(
          message: 'Failed to read the saved timetable.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ScheduleEntryEntity>> createScheduleEntry(
    ScheduleEntryEntity entry,
  ) async {
    final parent = await _courseDao.courseById(entry.studentCourseId);
    if (parent == null) {
      return left(Failure.validation(message: 'Choose a valid course.'));
    }
    final now = DateTime.now();
    final id = _uuid.v4();
    await _courseDao.saveScheduleEntry(
      _entryCompanion(
        entry,
        id: id,
        idempotencyKey: _uuid.v4(),
        syncStatus: 'pending',
        createdAt: now,
        updatedAt: now,
        cachedAt: now,
      ),
    );
    unawaited(_sync.syncPending());
    return right(await _cachedEntryById(id));
  }

  @override
  Future<Either<Failure, ScheduleEntryEntity>> updateScheduleEntry(
    ScheduleEntryEntity entry,
  ) async {
    final cached = await _courseDao.scheduleEntryById(entry.id);
    if (cached == null) {
      return left(
        Failure.cache(message: 'This schedule entry is not saved locally.'),
      );
    }
    if (cached.serverId == null) {
      await _courseDao.saveScheduleEntry(
        _entryCompanion(
          entry,
          id: cached.id,
          serverId: null,
          idempotencyKey: cached.idempotencyKey,
          syncStatus: 'pending',
          createdAt: cached.createdAt,
          updatedAt: DateTime.now(),
          cachedAt: DateTime.now(),
        ),
      );
      unawaited(_sync.syncPending());
      return right(await _cachedEntryById(entry.id));
    }

    final result = await _remote.updateScheduleEntry(
      entry.toDto().copyWith(id: cached.serverId!),
    );
    return result.fold((failure) async => left(failure), (updated) async {
      await _courseDao.saveScheduleEntry(
        updated
            .toCompanion(
              cached.studentCourseId,
              DateTime.now(),
              localId: cached.id,
            )
            .copyWith(
              idempotencyKey: Value(cached.idempotencyKey),
              syncStatus: const Value('synced'),
              lastSyncError: const Value(null),
            ),
      );
      return right(await _cachedEntryById(cached.id));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteScheduleEntry(String id) async {
    final cached = await _courseDao.scheduleEntryById(id);
    if (cached == null || cached.serverId == null) {
      await _courseDao.deleteScheduleEntry(id);
      return right(unit);
    }
    final result = await _remote.deleteScheduleEntry(cached.serverId!);
    if (result.isRight()) await _courseDao.deleteScheduleEntry(id);
    return result;
  }

  Future<Either<Failure, List<CourseEntity>>> _list(
    Future<Either<Failure, PaginatedResponse<CourseDto>>> Function() remote,
    Future<List<Course>> Function() cached, {
    bool archiveExpiredCourses = false,
  }) async {
    final result = await remote();
    return result.fold(
      (failure) async {
        try {
          if (archiveExpiredCourses) await _sync.syncPending();
          return right(
            await _cachedCourses(cached, activeOnly: archiveExpiredCourses),
          );
        } catch (error, stackTrace) {
          return left(
            Failure.cache(
              message: 'Failed to read cached courses.',
              error: error,
              stackTrace: stackTrace,
            ),
          );
        }
      },
      (page) async {
        for (final course in page.results) {
          await _cache(course);
        }
        if (archiveExpiredCourses) await _sync.syncPending();
        return right(
          await _cachedCourses(cached, activeOnly: archiveExpiredCourses),
        );
      },
    );
  }

  Future<List<CourseEntity>> _cachedCourses(
    Future<List<Course>> Function() load, {
    required bool activeOnly,
  }) async {
    final courses = await load();
    final visibleCourses = activeOnly
        ? courses.where((course) => !hasCourseTermEnded(course.termEndDate))
        : courses;
    return Future.wait(visibleCourses.map(_cachedCourse));
  }

  Future<Either<Failure, CourseEntity>> _cacheResult(
    Either<Failure, CourseDto> result,
  ) {
    return result.fold(
      (failure) async => left<Failure, CourseEntity>(failure),
      (course) async {
        final id = await _cache(course);
        return right(await _cachedCourseById(id));
      },
    );
  }

  Future<String> _cache(CourseDto course) async {
    final existing =
        await _courseDao.courseByServerId(course.id) ??
        await _courseDao.courseById(course.id);
    final localId = existing?.id ?? course.id;
    String? previousCourseId;
    if (course.previousCourse != null) {
      final previous =
          await _courseDao.courseByServerId(course.previousCourse!) ??
          await _courseDao.courseById(course.previousCourse!);
      previousCourseId = previous?.id ?? course.previousCourse;
    }
    final cachedAt = DateTime.now();
    await _courseDao.replaceCourse(
      course: course
          .toCompanion(cachedAt, localId: localId)
          .copyWith(
            idempotencyKey: Value(existing?.idempotencyKey ?? ''),
            previousCourseId: Value(previousCourseId),
          ),
      lecturers: course.lecturers
          .map((lecturer) => lecturer.toCompanion(localId))
          .toList(),
    );
    for (final entry in course.scheduleEntries) {
      if (entry.id.isNotEmpty) await _cacheScheduleEntry(entry, localId);
    }
    return localId;
  }

  Future<String> _cacheScheduleEntry(
    ScheduleEntryDto entry,
    String courseId,
  ) async {
    final existing = await _courseDao.scheduleEntryByServerId(entry.id);
    final localId = existing?.id ?? entry.id;
    final cachedAt = DateTime.now();
    await _courseDao.saveScheduleEntry(
      entry
          .toCompanion(courseId, cachedAt, localId: localId)
          .copyWith(idempotencyKey: Value(existing?.idempotencyKey ?? '')),
    );
    return localId;
  }

  Future<CourseEntity> _cachedCourseById(String id) async {
    final course = await _courseDao.courseById(id);
    if (course == null) throw StateError('Course $id was not saved locally.');
    return _cachedCourse(course);
  }

  Future<CourseEntity> _cachedCourse(Course course) async {
    final lecturers = await _courseDao.lecturersForCourse(course.id);
    final entries = await _cachedEntriesForCourse(course.id);
    return course.toDomain(lecturers, entries);
  }

  Future<List<ScheduleEntryEntity>> _cachedEntriesForCourse(
    String courseId,
  ) async {
    final course = await _courseDao.courseById(courseId);
    final rows = await _courseDao.scheduleEntriesForCourse(courseId);
    final entries = rows
        .map(
          (entry) => entry.toDomain(
            courseTitle: course?.title,
            courseCode: course?.code,
            courseColor: course?.color,
            courseTermEndDate: course?.termEndDate,
          ),
        )
        .toList();
    _sortSchedule(entries);
    return entries;
  }

  Future<ScheduleEntryEntity> _cachedEntryById(String id) async {
    final entry = await _courseDao.scheduleEntryById(id);
    if (entry == null) throw StateError('Schedule entry $id was not saved.');
    final course = await _courseDao.courseById(entry.studentCourseId);
    return entry.toDomain(
      courseTitle: course?.title,
      courseCode: course?.code,
      courseColor: course?.color,
      courseTermEndDate: course?.termEndDate,
    );
  }

  Future<List<ScheduleEntryEntity>> _cachedStudentSchedule() async {
    final rows = await _courseDao.allScheduleEntries();
    final entries = <ScheduleEntryEntity>[];
    for (final entry in rows) {
      final course = await _courseDao.courseById(entry.studentCourseId);
      if (course == null ||
          course.archivedAt != null ||
          hasCourseTermEnded(course.termEndDate)) {
        continue;
      }
      entries.add(
        entry.toDomain(
          courseTitle: course.title,
          courseCode: course.code,
          courseColor: course.color,
          courseTermEndDate: course.termEndDate,
        ),
      );
    }
    _sortSchedule(entries);
    return entries;
  }

  CoursesCompanion _localCourseCompanion(CourseEntity course, Course cached) {
    return CoursesCompanion.insert(
      id: cached.id,
      serverId: const Value(null),
      idempotencyKey: Value(cached.idempotencyKey),
      syncStatus: const Value('pending'),
      lastSyncError: const Value(null),
      institutionId: course.institutionId,
      title: course.title,
      code: Value(course.code),
      color: Value(course.color),
      termLabel: Value(course.termLabel),
      academicYear: Value(course.academicYear),
      termStartDate: Value(course.termStartDate),
      termEndDate: Value(course.termEndDate),
      previousCourseId: Value(course.previousCourseId),
      archivedAt: Value(course.archivedAt),
      createdAt: cached.createdAt,
      updatedAt: DateTime.now(),
      cachedAt: DateTime.now(),
    );
  }

  ScheduleEntriesCompanion _entryCompanion(
    ScheduleEntryEntity entry, {
    required String id,
    String? serverId,
    required String idempotencyKey,
    required String syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime cachedAt,
  }) {
    return ScheduleEntriesCompanion.insert(
      id: id,
      serverId: Value(serverId),
      idempotencyKey: Value(idempotencyKey),
      syncStatus: Value(syncStatus),
      lastSyncError: const Value(null),
      studentCourseId: entry.studentCourseId,
      dayOfWeek: entry.dayOfWeek,
      startTime: entry.startTime,
      endTime: entry.endTime,
      venue: Value(entry.venue),
      campus: Value(entry.campus),
      section: Value(entry.section),
      label: Value(entry.label),
      color: Value(entry.color),
      isRecurring: Value(entry.isRecurring),
      specificDate: Value(entry.specificDate),
      createdAt: createdAt,
      updatedAt: updatedAt,
      cachedAt: cachedAt,
    );
  }

  Future<String?> _serverCourseId(String? localId) async {
    if (localId == null) return null;
    final course = await _courseDao.courseById(localId);
    return course?.serverId ?? localId;
  }

  Future<void> _refreshCourse(String localId) async {
    final serverId = await _serverCourseId(localId);
    if (serverId == null) return;
    final result = await _remote.getCourse(serverId);
    await result.fold((_) async {}, _cache);
  }

  static void _sortSchedule(List<ScheduleEntryEntity> entries) {
    const days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    entries.sort((a, b) {
      final dayOrder = days
          .indexOf(a.dayOfWeek)
          .compareTo(days.indexOf(b.dayOfWeek));
      return dayOrder == 0 ? a.startTime.compareTo(b.startTime) : dayOrder;
    });
  }

  static Either<Failure, T> _courseNotSynced<T>() => left(
    Failure.validation(message: 'This course must sync before this action.'),
  );
}
