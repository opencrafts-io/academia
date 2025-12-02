import 'package:equatable/equatable.dart';

class ExamTimetable extends Equatable {
  final String courseCode;
  final String institutionId;
  final String day;
  final String time;
  final String venue;
  final String hrs;
  final String campus;
  final String invigilator;
  final String coordinator;
  final DateTime datetimeStr;

  const ExamTimetable({
    required this.courseCode,
    required this.institutionId,
    required this.day,
    required this.time,
    required this.venue,
    required this.hrs,
    required this.campus,
    required this.coordinator,
    required this.invigilator,
    required this.datetimeStr,
  });

  // Check if the exam is past
  bool get isPast {
    return datetimeStr.isBefore(DateTime.now());
  }

  // Check if the exam is upcoming
  bool get isUpcoming {
    return datetimeStr.isAfter(DateTime.now());
  }

  @override
  List<Object?> get props => [
    courseCode,
    institutionId,
    day,
    time,
    venue,
    hrs,
    campus,
    coordinator,
    invigilator,
    datetimeStr,
  ];
}
