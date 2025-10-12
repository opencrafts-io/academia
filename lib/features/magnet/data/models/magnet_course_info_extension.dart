import 'dart:convert';

import 'package:academia/database/database.dart';
import 'package:academia/features/magnet/domain/entities/entities.dart'
    as entity;
import 'package:magnet/magnet.dart';

extension MagnetCourseInfoExtension on CourseInfo {
  MagnetCourseInfoData toData({
    required String userID,
    required int institutionID,
  }) => MagnetCourseInfoData(
    userID: userID,
    institutionID: institutionID,
    credits: credits,
    courseCode: courseCode,
    courseTitle: courseTitle,
    semester: semester,
    schedule: schedule,
    location: location,
    instructor: instructor,
    courseType: courseType,
    courseLevel: courseLevel,
    prerequisites: jsonEncode(prerequisites),
    enrollmentLimit: enrollmentLimit,
    courseMaterials: jsonEncode(courseMaterials),
    courseDescription: courseDescription,
    durationInSeconds: duration?.inSeconds ?? 0,
    currentEnrollment: currentEnrollment,
  );

  entity.MagnetCourseInfo toEntity({
    required String userID,
    required int institutionID,
  }) => entity.MagnetCourseInfo(
    userID: userID,
    institutionID: institutionID,
    credits: credits,
    courseCode: courseCode,
    courseTitle: courseTitle,
    semester: semester,
    schedule: schedule,
    location: location,
    instructor: instructor,
    courseType: courseType,
    courseLevel: courseLevel,
    prerequisites: prerequisites,
    enrollmentLimit: enrollmentLimit,
    courseMaterials: courseMaterials,
    courseDescription: courseDescription,
    duration: duration,
    currentEnrollment: currentEnrollment,
  );
}

extension MagnetCourseEntityExtension on entity.MagnetCourseInfo {
  MagnetCourseInfoData toData() => MagnetCourseInfoData(
    userID: userID,
    institutionID: institutionID,
    credits: credits,
    courseCode: courseCode,
    courseTitle: courseTitle,
    semester: semester,
    schedule: schedule,
    location: location,
    instructor: instructor,
    courseType: courseType,
    courseLevel: courseLevel,
    prerequisites: jsonEncode(prerequisites),
    enrollmentLimit: enrollmentLimit,
    courseMaterials: jsonEncode(courseMaterials),
    courseDescription: courseDescription,
    durationInSeconds: duration?.inSeconds ?? 0,
    currentEnrollment: currentEnrollment,
  );
}

extension MagnetCourseInfoDataExtension on MagnetCourseInfoData {
  entity.MagnetCourseInfo toEntity() => entity.MagnetCourseInfo(
    userID: userID,
    institutionID: institutionID,
    credits: credits,
    courseCode: courseCode,
    courseTitle: courseTitle,
    semester: semester,
    schedule: schedule,
    location: location,
    instructor: instructor,
    courseType: courseType,
    courseLevel: courseLevel,
    prerequisites: jsonDecode(prerequisites ?? '[]'),
    enrollmentLimit: enrollmentLimit,
    courseMaterials: jsonDecode(courseMaterials ?? '[]'),
    courseDescription: courseDescription,
    duration: Duration(seconds: durationInSeconds ?? 0),
    currentEnrollment: currentEnrollment,
  );
}
