import 'package:equatable/equatable.dart';

class ExamTimetable extends Equatable {
  final String courseCode;
  final String day;
  final String startTime;
  final String endTime;
  final String venue;
  final String hrs;
  final String campus;
  final String invigilator;
  final String coordinator;
  final DateTime datetimeStr;

  const ExamTimetable({
    required this.courseCode,
    required this.day,
    required this.startTime,
    required this.endTime,
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
    day,
    startTime,
    endTime,
    venue,
    hrs,
    campus,
    coordinator,
    invigilator,
    datetimeStr,
  ];
}
