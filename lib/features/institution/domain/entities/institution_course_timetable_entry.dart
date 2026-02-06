import 'package:academia/database/database.dart';
import 'package:academia/features/institution/data/models/institution_course_timetable_entry.dart'
    as d;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'institution_course_timetable_entry.freezed.dart';
part 'institution_course_timetable_entry.g.dart';

@freezed
abstract class InstitutionCourseTimetableEntry
    with _$InstitutionCourseTimetableEntry {
  const factory InstitutionCourseTimetableEntry({
    required int id,
    int? institution,

    required String courseCode,
    required String courseName,
    required d.Weekday dayOfWeek,
    required DateTime startTime,
    required DateTime endTime,

    String? location,
    String? room,
    String? building,
    String? instructor,

    @Default(true) bool isRecurring,
    String? recurrencePattern,
    String? rawData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InstitutionCourseTimetableEntry;

  factory InstitutionCourseTimetableEntry.fromJson(Map<String, dynamic> json) =>
      _$InstitutionCourseTimetableEntryFromJson(json);

  /// Maps from a data level object to an entity object
  factory InstitutionCourseTimetableEntry.fromData(
    InstitutionCourseTimetableEntryData data,
  ) => InstitutionCourseTimetableEntry(
    id: data.id,
    endTime: data.endTime,
    dayOfWeek: data.dayOfWeek,
    startTime: data.startTime,
    courseCode: data.courseCode,
    courseName: data.courseName,
    room: data.room,
    rawData: data.rawData,
    location: data.location,
    building: data.building,
    createdAt: data.createdAt,
    updatedAt: data.updatedAt,
    instructor: data.instructor,
    institution: data.institution,
    isRecurring: data.isRecurring,
    recurrencePattern: data.recurrencePattern,
  );

  /// Maps to a data layer object
  InstitutionCourseTimetableEntryData toData() =>
      InstitutionCourseTimetableEntryData(
        id: id,
        recurrencePattern: recurrencePattern,
        isRecurring: isRecurring,
        institution: institution,
        instructor: instructor,
        updatedAt: updatedAt ?? DateTime.now(),
        createdAt: createdAt ?? DateTime.now(),
        building: building,
        location: location,
        rawData: rawData,
        room: room,
        courseName: courseName,
        courseCode: courseCode,
        startTime: startTime,
        dayOfWeek: dayOfWeek,
        endTime: endTime,
      );
}
