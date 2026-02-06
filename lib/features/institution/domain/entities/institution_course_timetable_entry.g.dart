// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_course_timetable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InstitutionCourseTimetableEntry _$InstitutionCourseTimetableEntryFromJson(
  Map<String, dynamic> json,
) => _InstitutionCourseTimetableEntry(
  id: (json['id'] as num).toInt(),
  institution: (json['institution'] as num?)?.toInt(),
  courseCode: json['courseCode'] as String,
  courseName: json['courseName'] as String,
  dayOfWeek: $enumDecode(_$WeekdayEnumMap, json['dayOfWeek']),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  location: json['location'] as String?,
  room: json['room'] as String?,
  building: json['building'] as String?,
  instructor: json['instructor'] as String?,
  isRecurring: json['isRecurring'] as bool? ?? true,
  recurrencePattern: json['recurrencePattern'] as String?,
  rawData: json['rawData'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$InstitutionCourseTimetableEntryToJson(
  _InstitutionCourseTimetableEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'institution': instance.institution,
  'courseCode': instance.courseCode,
  'courseName': instance.courseName,
  'dayOfWeek': _$WeekdayEnumMap[instance.dayOfWeek]!,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'location': instance.location,
  'room': instance.room,
  'building': instance.building,
  'instructor': instance.instructor,
  'isRecurring': instance.isRecurring,
  'recurrencePattern': instance.recurrencePattern,
  'rawData': instance.rawData,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};
