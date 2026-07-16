import 'dart:convert';

import 'package:academia/database/database.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';

extension ExamTimetableExtension on ExamTimetable {
  ExamTimetableData toModel() => ExamTimetableData(
    courseCode: courseCode,
    startTime: startTime,
    endTime: endTime,
    venue: venue,
    coordinator: coordinator,
    hrs: hrs,
    rawData: rawData != null ? jsonEncode(rawData!.toJson()) : null,
    datetimeStr: datetimeStr,
  );
}

extension ExamTimetableDataExtension on ExamTimetableData {
  ExamRawData? _parseRawData() {
    if (rawData == null || rawData!.isEmpty) return null;
    try {
      final decoded = jsonDecode(rawData!) as Map<String, dynamic>;
      return ExamRawData.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  ExamTimetable toEntity() => ExamTimetable(
    courseCode: courseCode,
    startTime: startTime,
    endTime: endTime,
    venue: venue,
    coordinator: coordinator,
    hrs: hrs,
    rawData: _parseRawData(),
    datetimeStr: datetimeStr,
  );

  ExamTimetable toDomainEntity() => toEntity();
}
