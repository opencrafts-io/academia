import 'package:academia/database/database.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';

extension ExamTimetableExtension on ExamTimetable {
  ExamTimetableData toModel() => ExamTimetableData(
    courseCode: courseCode,
    institutionId: institutionId,
    day: day,
    time: time,
    venue: venue,
    hrs: hrs,
    campus: campus,
    coordinator: coordinator,
    invigilator: invigilator,
    datetimeStr: datetimeStr
  );
}

extension ExamTimetableDataExtension on ExamTimetableData {
  ExamTimetable toEntity() => ExamTimetable(
    courseCode: courseCode,
    institutionId: institutionId,
    day: day,
    time: time,
    venue: venue,
    hrs: hrs,
    campus: campus,
    coordinator: coordinator,
    invigilator: invigilator,
    datetimeStr: datetimeStr,
  );

  ExamTimetable toDomainEntity() => ExamTimetable(
    courseCode: courseCode,
    institutionId: institutionId,
    day: day,
    time: time,
    venue: venue,
    hrs: hrs,
    campus: campus,
    coordinator: coordinator,
    invigilator: invigilator,
    datetimeStr: datetimeStr,
  );
}
