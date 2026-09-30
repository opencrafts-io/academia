import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/domain/entities/entities.dart';
import 'package:database/database.dart' as database;

extension CourseDtoMapper on CourseDto {
  CourseEntity toDomain({String? localId}) {
    return CourseEntity(
      id: localId ?? id,
      serverId: id,
      institutionId: institution,
      title: title,
      code: code,
      color: color,
      termLabel: termLabel,
      academicYear: academicYear,
      termStartDate: termStartDate,
      termEndDate: termEndDate,
      previousCourseId: previousCourse,
      archivedAt: archivedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lecturers: lecturers
          .map((lecturer) => lecturer.toDomain(courseId: localId ?? id))
          .toList(),
      scheduleEntries: scheduleEntries
          .map((entry) => entry.toDomain(courseId: localId ?? id))
          .toList(),
    );
  }

  database.CoursesCompanion toCompanion(DateTime cachedAt, {String? localId}) {
    return database.CoursesCompanion.insert(
      id: localId ?? id,
      serverId: database.Value(id),
      idempotencyKey: const database.Value(''),
      syncStatus: const database.Value('synced'),
      lastSyncError: const database.Value(null),
      institutionId: institution,
      title: title,
      code: database.Value(code),
      color: database.Value(color),
      termLabel: database.Value(termLabel),
      academicYear: database.Value(academicYear),
      termStartDate: database.Value(termStartDate),
      termEndDate: database.Value(termEndDate),
      previousCourseId: database.Value(previousCourse),
      archivedAt: database.Value(archivedAt),
      createdAt: createdAt,
      updatedAt: updatedAt,
      cachedAt: cachedAt,
    );
  }
}

extension ScheduleEntryDtoMapper on ScheduleEntryDto {
  ScheduleEntryEntity toDomain({required String courseId, String? localId}) {
    return ScheduleEntryEntity(
      id: localId ?? id,
      serverId: id.isEmpty ? null : id,
      studentCourseId: courseId,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      venue: venue,
      campus: campus,
      section: section,
      label: label,
      color: color,
      isRecurring: isRecurring,
      specificDate: specificDate,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      courseTitle: course?.title,
      courseCode: course?.code,
      courseColor: course?.color,
    );
  }

  database.ScheduleEntriesCompanion toCompanion(
    String courseId,
    DateTime cachedAt, {
    String? localId,
  }) {
    return database.ScheduleEntriesCompanion.insert(
      id: localId ?? id,
      serverId: database.Value(id.isEmpty ? null : id),
      studentCourseId: courseId,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      venue: database.Value(venue),
      campus: database.Value(campus),
      section: database.Value(section),
      label: database.Value(label),
      color: database.Value(color),
      isRecurring: database.Value(isRecurring),
      specificDate: database.Value(specificDate),
      createdAt: createdAt ?? cachedAt,
      updatedAt: updatedAt ?? cachedAt,
      cachedAt: cachedAt,
    );
  }
}

extension LecturerDtoMapper on LecturerDto {
  LecturerEntity toDomain({required String courseId}) {
    return LecturerEntity(
      id: id,
      courseId: courseId,
      name: name,
      email: email,
      phone: phone,
      office: office,
    );
  }

  database.LecturersCompanion toCompanion(String courseId) {
    return database.LecturersCompanion.insert(
      id: id,
      studentCourseId: courseId,
      name: name,
      email: database.Value(email),
      phone: database.Value(phone),
      office: database.Value(office),
    );
  }
}

extension CourseEntityMapper on CourseEntity {
  CourseDto toDto() {
    return CourseDto(
      id: serverId ?? id,
      institution: institutionId,
      title: title,
      code: code,
      color: color,
      termLabel: termLabel,
      academicYear: academicYear,
      termStartDate: termStartDate,
      termEndDate: termEndDate,
      previousCourse: previousCourseId,
      archivedAt: archivedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lecturers: lecturers.map((lecturer) => lecturer.toDto()).toList(),
    );
  }
}

extension LecturerEntityMapper on LecturerEntity {
  LecturerDto toDto() => LecturerDto(
    id: id,
    name: name,
    email: email,
    phone: phone,
    office: office,
  );
}

extension ScheduleEntryEntityMapper on ScheduleEntryEntity {
  ScheduleEntryDto toDto() {
    return ScheduleEntryDto(
      id: serverId ?? id,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      venue: venue,
      campus: campus,
      section: section,
      label: label,
      color: color,
      isRecurring: isRecurring,
      specificDate: specificDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CachedScheduleEntryMapper on database.ScheduleEntry {
  ScheduleEntryEntity toDomain({
    String? courseTitle,
    String? courseCode,
    String? courseColor,
  }) {
    return ScheduleEntryEntity(
      id: id,
      serverId: serverId,
      idempotencyKey: idempotencyKey,
      syncStatus: syncStatus,
      lastSyncError: lastSyncError,
      studentCourseId: studentCourseId,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      venue: venue,
      campus: campus,
      section: section,
      label: label,
      color: color,
      isRecurring: isRecurring,
      specificDate: specificDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      courseTitle: courseTitle,
      courseCode: courseCode,
      courseColor: courseColor,
    );
  }
}

extension CachedCourseMapper on database.Course {
  CourseEntity toDomain(
    List<database.Lecturer> lecturers, [
    List<ScheduleEntryEntity> scheduleEntries = const [],
  ]) {
    return CourseEntity(
      id: id,
      serverId: serverId,
      idempotencyKey: idempotencyKey,
      syncStatus: syncStatus,
      lastSyncError: lastSyncError,
      institutionId: institutionId,
      title: title,
      code: code,
      color: color,
      termLabel: termLabel,
      academicYear: academicYear,
      termStartDate: termStartDate,
      termEndDate: termEndDate,
      previousCourseId: previousCourseId,
      archivedAt: archivedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lecturers: lecturers
          .map(
            (lecturer) => LecturerEntity(
              id: lecturer.id,
              courseId: lecturer.studentCourseId,
              name: lecturer.name,
              email: lecturer.email,
              phone: lecturer.phone,
              office: lecturer.office,
            ),
          )
          .toList(),
      scheduleEntries: scheduleEntries,
    );
  }
}
