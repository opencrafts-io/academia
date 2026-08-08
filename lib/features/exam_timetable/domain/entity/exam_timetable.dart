import 'package:equatable/equatable.dart';

/// Holds optional extra fields from the raw_data JSON blob.
class ExamRawData extends Equatable {
  /// e.g. "FRI\n24/4/26" or "MONDAY 20/04/26"
  final String? originalDay;

  /// e.g. "ATHI RIVER"
  final String? campus;

  /// e.g. "JOYSTACY/ JOY"
  final String? invigilator;

  /// e.g. "9:00AM-11:00AM" (original time before normalisation)
  final String? originalTime;

  /// e.g. "Human Resource Analytics"
  final String? courseName;

  /// e.g. "JAN – APRIL 26EC"
  final String? group;

  /// e.g. "20"
  final String? studentCount;

  /// e.g. "Thursday, 30th  April 2026"
  final String? originalDate;

  const ExamRawData({
    this.originalDay,
    this.campus,
    this.invigilator,
    this.originalTime,
    this.courseName,
    this.group,
    this.studentCount,
    this.originalDate,
  });

  factory ExamRawData.fromJson(Map<String, dynamic> json) {
    return ExamRawData(
      originalDay: json['original_day'] as String?,
      campus: json['campus'] as String?,
      invigilator: json['invigilator'] as String?,
      originalTime: json['original_time'] as String?,
      courseName: json['course_name'] as String?,
      group: json['group'] as String?,
      studentCount: json['student_count'] as String?,
      originalDate: json['original_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (originalDay != null) 'original_day': originalDay,
      if (campus != null) 'campus': campus,
      if (invigilator != null) 'invigilator': invigilator,
      if (originalTime != null) 'original_time': originalTime,
      if (courseName != null) 'course_name': courseName,
      if (group != null) 'group': group,
      if (studentCount != null) 'student_count': studentCount,
      if (originalDate != null) 'original_date': originalDate,
    };
  }

  @override
  List<Object?> get props => [
    originalDay,
    campus,
    invigilator,
    originalTime,
    courseName,
    group,
    studentCount,
    originalDate,
  ];
}

class ExamTimetable extends Equatable {
  final int institutionId;
  final String courseCode;
  final String startTime;
  final String endTime;
  final String venue;

  /// Optional — may be empty string
  final String coordinator;

  /// Optional — may be empty string
  final String hrs;

  /// Optional raw data blob from the API
  final ExamRawData? rawData;

  /// Parsed from start_time; used for sorting and countdown.
  final DateTime datetimeStr;

  const ExamTimetable({
    required this.institutionId,
    required this.courseCode,
    required this.startTime,
    required this.endTime,
    required this.venue,
    this.coordinator = '',
    this.hrs = '',
    this.rawData,
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

  /// Convenience getter: human-readable day from raw_data or formatted date
  String get displayDay {
    final od = rawData?.originalDay;
    if (od != null && od.isNotEmpty) {
      return od.replaceAll('\n', ' ');
    }
    // Fall back to formatted date from datetimeStr
    final d = datetimeStr;
    return '${_weekday(d.weekday)} ${d.day}/${d.month}/${d.year % 100}';
  }

  static String _weekday(int w) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[(w - 1).clamp(0, 6)];
  }

  @override
  List<Object?> get props => [
    institutionId,
    courseCode,
    startTime,
    endTime,
    venue,
    hrs,
    coordinator,
    rawData,
    datetimeStr,
  ];
}
