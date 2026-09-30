import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabaseV2 database;
  late CourseDao dao;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    dao = CourseDao(database);
  });

  tearDown(() => database.close());

  test('replaces a cached course lecturer snapshot atomically', () async {
    await dao.replaceCourse(
      course: CoursesCompanion.insert(
        id: 'course-1',
        institutionId: 7,
        title: 'Algorithms',
        createdAt: DateTime(2026, 9, 23),
        updatedAt: DateTime(2026, 9, 23),
        cachedAt: DateTime(2026, 9, 23),
      ),
      lecturers: [
        LecturersCompanion.insert(
          id: 'lecturer-1',
          studentCourseId: 'course-1',
          name: 'Ada Lovelace',
        ),
      ],
    );

    await dao.replaceCourse(
      course: CoursesCompanion.insert(
        id: 'course-1',
        institutionId: 7,
        title: 'Algorithms',
        createdAt: DateTime(2026, 9, 23),
        updatedAt: DateTime(2026, 9, 23, 1),
        cachedAt: DateTime(2026, 9, 23, 1),
      ),
      lecturers: [
        LecturersCompanion.insert(
          id: 'lecturer-2',
          studentCourseId: 'course-1',
          name: 'Grace Hopper',
        ),
      ],
    );

    expect((await dao.activeCourses()).single.title, 'Algorithms');
    expect(
      (await dao.lecturersForCourse('course-1'))
          .map((lecturer) => lecturer.name),
      ['Grace Hopper'],
    );
  });
}
