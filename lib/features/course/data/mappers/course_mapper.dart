import 'package:academia/database/database.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:drift/drift.dart';

extension CourseDataX on CourseData {
  /// Converts Drift [CourseData] to Domain [CourseEntity]
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      serverId: serverId,
      institutionId: institution,
      semesterId: semester,
      courseCode: courseCode,
      courseName: courseName,
      instructor: instructor,
      color: color,
      isSynced: isSynced,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CourseEntityX on CourseEntity {
  /// Converts Domain [CourseEntity] to Drift [CourseCompanion] for DB writes
  CourseData toData() {
    return CourseData(
      isSynced: isSynced,
      isDeleted: isDeleted,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      courseCode: courseCode,
      courseName: courseName,
      instructor: instructor,
      id: id ?? '',
      color: color,
      serverId: serverId,
      semester: semesterId,
      institution: institutionId,
    );
  }

  CourseCompanion toCompanion() {
    return CourseCompanion(
      id: (id == null || id!.isEmpty) ? const Value.absent() : Value(id!),
      serverId: serverId == null ? const Value.absent() : Value(serverId),
      courseCode: Value(courseCode),
      courseName: Value(courseName),
      instructor: Value(instructor),

      color: color == null ? const Value.absent() : Value(color),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),

      semester: semesterId == null ? const Value.absent() : Value(semesterId),
      institution: institutionId == null
          ? const Value.absent()
          : Value(institutionId),
      createdAt: Value(createdAt ?? DateTime.now()),
      updatedAt: Value(updatedAt ?? DateTime.now()),
    );
  }
}
