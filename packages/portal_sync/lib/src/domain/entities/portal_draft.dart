class PortalCourseDraft {
  const PortalCourseDraft({
    required this.sourceId,
    required this.code,
    required this.title,
    this.term,
    this.section,
    this.lecturer,
  });

  final String sourceId;
  final String code;
  final String title;
  final String? term;
  final String? section;
  final String? lecturer;
}

class PortalMeetingDraft {
  const PortalMeetingDraft({
    required this.sourceId,
    required this.courseSourceId,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.venue,
    this.timeZone,
  });

  final String sourceId;
  final String courseSourceId;
  final String day;
  final String startTime;
  final String endTime;
  final String? venue;
  final String? timeZone;
}

class PortalDraft {
  PortalDraft({
    required List<PortalCourseDraft> courses,
    required List<PortalMeetingDraft> meetings,
    required this.sourceOrigin,
    required this.observedAt,
  }) : courses = List.unmodifiable(courses),
       meetings = List.unmodifiable(meetings);

  final List<PortalCourseDraft> courses;
  final List<PortalMeetingDraft> meetings;
  final String sourceOrigin;
  final DateTime observedAt;

  bool get isValid {
    if (sourceOrigin.isEmpty || courses.isEmpty) return false;
    final courseIds = <String>{};
    for (final course in courses) {
      if (course.sourceId.isEmpty ||
          course.code.trim().isEmpty ||
          course.title.trim().isEmpty ||
          !courseIds.add(course.sourceId)) {
        return false;
      }
    }
    final meetingIds = <String>{};
    for (final meeting in meetings) {
      if (meeting.sourceId.isEmpty ||
          !courseIds.contains(meeting.courseSourceId) ||
          !meetingIds.add(meeting.sourceId)) {
        return false;
      }
      if (!_validDay(meeting.day) ||
          !_validTimeRange(meeting.startTime, meeting.endTime)) {
        return false;
      }
    }
    return true;
  }

  static bool _validDay(String value) => const {
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  }.contains(value.trim().toLowerCase());

  static bool _validTimeRange(String start, String end) {
    final startMinutes = _minutes(start);
    final endMinutes = _minutes(end);
    return startMinutes != null &&
        endMinutes != null &&
        startMinutes < endMinutes;
  }

  static int? _minutes(String value) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(value.trim());
    if (match == null) return null;
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    if (hour > 23 || minute > 59) return null;
    return hour * 60 + minute;
  }
}

class PortalImportResult {
  const PortalImportResult({
    required this.importedCourses,
    required this.importedMeetings,
    this.message,
  });

  final int importedCourses;
  final int importedMeetings;
  final String? message;
}
