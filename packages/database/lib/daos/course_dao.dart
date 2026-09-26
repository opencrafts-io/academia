import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database_v2.dart';
import '../tables/tables.dart';

part 'course_dao.g.dart';

@injectable
@DriftAccessor(tables: [Courses, Lecturers])
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

  Future<List<Lecturer>> lecturersForCourse(String courseId) {
    return (select(
      lecturers,
    )..where((lecturer) => lecturer.studentCourseId.equals(courseId))).get();
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
        lecturers,
      )..where((lecturer) => lecturer.studentCourseId.equals(id))).go();
      await (delete(courses)..where((course) => course.id.equals(id))).go();
    });
  }
}
