import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';

part 'course_dao.g.dart';

@injectable
@DriftAccessor(tables: [Courses, Lecturers, ScheduleEntries])
class CourseDao extends DatabaseAccessor<AppDatabaseV2> with _$CourseDaoMixin {
  CourseDao(super.db);

  Future<List<Course>> activeCourses() {
    return (select(
      courses,
    )..where((course) => course.archivedAt.isNull())).get();
  }

  Future<List<Course>> archivedCourses() {
    return (select(
      courses,
    )..where((course) => course.archivedAt.isNotNull())).get();
  }

  Future<Course?> courseById(String id) {
    return (select(
      courses,
    )..where((course) => course.id.equals(id))).getSingleOrNull();
  }

  Future<Course?> courseByServerId(String serverId) {
    return (select(
      courses,
    )..where((course) => course.serverId.equals(serverId))).getSingleOrNull();
  }

  Future<List<Course>> pendingCourses() {
    return (select(courses)
          ..where((course) => course.syncStatus.equals('pending'))
          ..orderBy([(course) => OrderingTerm.asc(course.createdAt)]))
        .get();
  }

  Future<void> saveCourse(CoursesCompanion course) async {
    await into(courses).insertOnConflictUpdate(course);
  }

  Future<void> setCourseSynced(
    String id,
    String serverId, {
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    await (update(courses)..where((course) => course.id.equals(id))).write(
      CoursesCompanion(
        serverId: Value(serverId),
        syncStatus: const Value('synced'),
        lastSyncError: const Value(null),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
        cachedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setCourseSyncFailed(String id, String message) async {
    await (update(courses)..where((course) => course.id.equals(id))).write(
      CoursesCompanion(
        syncStatus: const Value('failed'),
        lastSyncError: Value(message),
      ),
    );
  }

  Future<List<Lecturer>> lecturersForCourse(String courseId) {
    return (select(
      lecturers,
    )..where((lecturer) => lecturer.studentCourseId.equals(courseId))).get();
  }

  Future<List<ScheduleEntry>> scheduleEntriesForCourse(String courseId) {
    return (select(scheduleEntries)
          ..where((entry) => entry.studentCourseId.equals(courseId))
          ..orderBy([
            (entry) => OrderingTerm.asc(entry.dayOfWeek),
            (entry) => OrderingTerm.asc(entry.startTime),
          ]))
        .get();
  }

  Future<List<ScheduleEntry>> allScheduleEntries() {
    return (select(scheduleEntries)..orderBy([
          (entry) => OrderingTerm.asc(entry.dayOfWeek),
          (entry) => OrderingTerm.asc(entry.startTime),
        ]))
        .get();
  }

  Future<ScheduleEntry?> scheduleEntryById(String id) {
    return (select(
      scheduleEntries,
    )..where((entry) => entry.id.equals(id))).getSingleOrNull();
  }

  Future<ScheduleEntry?> scheduleEntryByServerId(String serverId) {
    return (select(
      scheduleEntries,
    )..where((entry) => entry.serverId.equals(serverId))).getSingleOrNull();
  }

  Future<List<ScheduleEntry>> pendingScheduleEntries() {
    return (select(scheduleEntries)
          ..where((entry) => entry.syncStatus.equals('pending'))
          ..orderBy([(entry) => OrderingTerm.asc(entry.createdAt)]))
        .get();
  }

  Future<void> saveScheduleEntry(ScheduleEntriesCompanion entry) async {
    await into(scheduleEntries).insertOnConflictUpdate(entry);
  }

  Future<void> setScheduleEntrySynced(String id, String serverId) async {
    await (update(
      scheduleEntries,
    )..where((entry) => entry.id.equals(id))).write(
      ScheduleEntriesCompanion(
        serverId: Value(serverId),
        syncStatus: const Value('synced'),
        lastSyncError: const Value(null),
        cachedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setScheduleEntrySyncFailed(String id, String message) async {
    await (update(
      scheduleEntries,
    )..where((entry) => entry.id.equals(id))).write(
      ScheduleEntriesCompanion(
        syncStatus: const Value('failed'),
        lastSyncError: Value(message),
      ),
    );
  }

  Future<void> deleteScheduleEntry(String id) async {
    await (delete(scheduleEntries)..where((entry) => entry.id.equals(id))).go();
  }

  Future<void> replaceCourse({
    required CoursesCompanion course,
    required List<LecturersCompanion> lecturers,
  }) {
    return transaction(() async {
      await into(courses).insertOnConflictUpdate(course);
      await (delete(this.lecturers)..where(
            (lecturer) => lecturer.studentCourseId.equals(course.id.value),
          ))
          .go();
      if (lecturers.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            this.lecturers,
            lecturers,
            mode: InsertMode.insertOrReplace,
          );
        });
      }
    });
  }

  Future<void> deleteCourse(String id) {
    return transaction(() async {
      await (delete(
        scheduleEntries,
      )..where((entry) => entry.studentCourseId.equals(id))).go();
      await (delete(
        lecturers,
      )..where((lecturer) => lecturer.studentCourseId.equals(id))).go();
      await (delete(courses)..where((course) => course.id.equals(id))).go();
    });
  }
}
