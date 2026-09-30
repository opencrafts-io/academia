import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/domain/entities/entities.dart';
import 'package:database/database.dart' as database;

extension CourseDtoMapper on CourseDto {
  CourseEntity toDomain() {
    return CourseEntity(
      id: id,
      institutionId: institution,
      title: title,
      code: code,
      termLabel: termLabel,
      academicYear: academicYear,
      termStartDate: termStartDate,
      termEndDate: termEndDate,
      previousCourseId: previousCourse,
      archivedAt: archivedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lecturers: lecturers
          .map((lecturer) => lecturer.toDomain(courseId: id))
          .toList(),
    );
  }

  database.CoursesCompanion toCompanion(DateTime cachedAt) {
    return database.CoursesCompanion.insert(
      id: id,
      institutionId: institution,
      title: title,
      code: database.Value(code),
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
      id: id,
      institution: institutionId,
      title: title,
      code: code,
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
  LecturerDto toDto() {
    return LecturerDto(
      id: id,
      name: name,
      email: email,
      phone: phone,
      office: office,
    );
  }
}

extension CachedCourseMapper on database.Course {
  CourseEntity toDomain(List<database.Lecturer> lecturers) {
    return CourseEntity(
      id: id,
      institutionId: institutionId,
      title: title,
      code: code,
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
    );
  }
}
