import 'dart:core';

/// A data model representing information about a university course.
class MagnetCourseInfo {
  // Verisafe's user id
  final String userID;

  // The institution the course is part of
  final int institutionID;

  /// The unique identifier for the course (e.g., CS101).
  final String courseCode;

  /// The full name of the course (e.g., Introduction to Computer Science).
  final String courseTitle;

  /// A brief description of the course content.
  final String? courseDescription;

  /// The number of credits the course is worth.
  final int credits;

  /// The name of the instructor teaching the course.
  final String? instructor;

  /// The semester in which the course is being offered (e.g., "Fall 2023").
  final String? semester;

  /// The schedule of the class.
  final DateTime? schedule;

  /// The duration of the class.
  final Duration? duration;

  /// The prerequisites for the course.
  final List<String>? prerequisites;

  /// The type of course (e.g., "Lecture", "Lab").
  final String? courseType;

  /// The level of the course (e.g., "Undergraduate", "Graduate").
  final String? courseLevel;

  /// The location where the course is held.
  final String? location;

  /// The maximum number of students that can enroll in the course.
  final int? enrollmentLimit;

  /// The current number of students enrolled in the course.
  final int? currentEnrollment;

  /// A list of URLs or references to course materials.
  final List<String>? courseMaterials;

  const MagnetCourseInfo({
    required this.userID,
    required this.institutionID,
    required this.courseCode,
    required this.courseTitle,
    this.courseDescription,
    required this.credits,
    this.instructor,
    this.semester,
    this.schedule,
    this.duration,
    this.prerequisites,
    this.courseType,
    this.courseLevel,
    this.location,
    this.enrollmentLimit,
    this.currentEnrollment,
    this.courseMaterials,
  });

  /// Creates a copy of this [MagnetCourseInfo] object with the given
  /// fields replaced with new values.
  MagnetCourseInfo copyWith({
    String? userID,
    int? institutionID,
    String? courseCode,
    String? courseTitle,
    String? courseDescription,
    int? credits,
    String? instructor,
    String? semester,
    DateTime? schedule,
    Duration? duration,
    List<String>? prerequisites,
    String? courseType,
    String? courseLevel,
    String? location,
    int? enrollmentLimit,
    int? currentEnrollment,
    List<String>? courseMaterials,
  }) {
    return MagnetCourseInfo(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      courseDescription: courseDescription ?? this.courseDescription,
      credits: credits ?? this.credits,
      instructor: instructor ?? this.instructor,
      semester: semester ?? this.semester,
      schedule: schedule ?? this.schedule,
      duration: duration ?? this.duration,
      prerequisites: prerequisites ?? this.prerequisites,
      courseType: courseType ?? this.courseType,
      courseLevel: courseLevel ?? this.courseLevel,
      location: location ?? this.location,
      enrollmentLimit: enrollmentLimit ?? this.enrollmentLimit,
      currentEnrollment: currentEnrollment ?? this.currentEnrollment,
      courseMaterials: courseMaterials ?? this.courseMaterials,
    );
  }
}
