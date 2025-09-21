// lib/src/data/courses_table.dart
import 'package:drift/drift.dart';

class MagnetCourseInfo extends Table {
  // Use a nullable text column for Verisafe's user ID as it might be null initially
  TextColumn get userID => text().named('user_id')();

  // Primary key, the institution the course is part of
  IntColumn get institutionID => integer().named('institution_id')();

  // The unique identifier for the course (e.g., CS101)
  TextColumn get courseCode => text().named('course_code')();

  // The full name of the course
  TextColumn get courseTitle => text().named('course_title')();

  // A brief description of the course content
  TextColumn get courseDescription =>
      text().nullable().named('course_description')();

  // The number of credits the course is worth
  IntColumn get credits => integer()();

  // The name of the instructor teaching the course
  TextColumn get instructor => text().nullable()();

  // The semester in which the course is being offered
  TextColumn get semester => text().nullable()();

  // The schedule of the class
  DateTimeColumn get schedule => dateTime().nullable()();

  // The duration of the class
  IntColumn get durationInSeconds =>
      integer().nullable().named("duration_in_seconds")();

  // The prerequisites for the course (stored as a comma-separated string)
  TextColumn get prerequisites => text().nullable()();

  // The type of course (e.g., "Lecture", "Lab")
  TextColumn get courseType => text().nullable().named('course_type')();

  // The level of the course (e.g., "Undergraduate", "Graduate")
  TextColumn get courseLevel => text().nullable().named('course_level')();

  // The location where the course is held
  TextColumn get location => text().nullable()();

  // The maximum number of students that can enroll in the course
  IntColumn get enrollmentLimit =>
      integer().nullable().named('enrollment_limit')();

  // The current number of students enrolled in the course
  IntColumn get currentEnrollment =>
      integer().nullable().named('current_enrollment')();

  // A list of URLs or references to course materials
  TextColumn get courseMaterials =>
      text().nullable().named('course_materials')();

  @override
  Set<Column> get primaryKey => {userID, institutionID, courseCode};

  @override
  String get tableName => 'courses';
}
