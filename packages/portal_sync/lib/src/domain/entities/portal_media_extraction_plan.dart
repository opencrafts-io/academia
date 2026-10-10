import 'portal_analysis_plan.dart' show PortalPageType;
import 'portal_connection.dart';
import 'portal_draft.dart';
import 'portal_source_identity.dart';

/// One course Gemini read directly from an explicitly selected image or
/// document. Unlike the DOM path's [PortalPageType]-scoped column plan,
/// there is no local page to re-read values from afterward — the model
/// must return the field values themselves, bounded and validated exactly
/// like any other untrusted model output.
class PortalMediaCourseCandidate {
  const PortalMediaCourseCandidate({
    required this.code,
    required this.title,
    this.term,
    this.section,
    this.lecturer,
  });

  final String code;
  final String title;
  final String? term;
  final String? section;
  final String? lecturer;

  factory PortalMediaCourseCandidate.fromJson(Map raw) {
    final code = raw['code'];
    final title = raw['title'];
    if (code is! String || code.trim().isEmpty || code.length > 64) {
      throw const FormatException('Invalid media course code.');
    }
    if (title is! String || title.trim().isEmpty || title.length > 256) {
      throw const FormatException('Invalid media course title.');
    }
    return PortalMediaCourseCandidate(
      code: code.trim(),
      title: title.trim(),
      term: _optionalText(raw['term']),
      section: _optionalText(raw['section']),
      lecturer: _optionalText(raw['lecturer']),
    );
  }
}

/// One weekly class meeting Gemini read directly from the capture.
class PortalMediaMeetingCandidate {
  const PortalMediaMeetingCandidate({
    required this.code,
    required this.day,
    required this.start,
    required this.end,
    this.venue,
    this.term,
  });

  final String code;
  final String day;
  final String start;
  final String end;
  final String? venue;
  final String? term;

  factory PortalMediaMeetingCandidate.fromJson(Map raw) {
    final code = raw['code'];
    final day = raw['day'];
    final start = raw['start'];
    final end = raw['end'];
    if (code is! String || code.trim().isEmpty || code.length > 64) {
      throw const FormatException('Invalid media meeting code.');
    }
    if (day is! String || day.length > 32) {
      throw const FormatException('Invalid media meeting day.');
    }
    if (start is! String ||
        start.length > 16 ||
        end is! String ||
        end.length > 16) {
      throw const FormatException('Invalid media meeting time.');
    }
    return PortalMediaMeetingCandidate(
      code: code.trim(),
      day: day,
      start: start,
      end: end,
      venue: _optionalText(raw['venue']),
      term: _optionalText(raw['term']),
    );
  }
}

String? _optionalText(Object? value) {
  if (value == null) return null;
  if (value is! String || value.length > 256) {
    throw const FormatException('Invalid media field value.');
  }
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}

/// The bounded, validated result of a multimodal analysis request. Mirrors
/// the same courses/meetings shape as [PortalDraft] so it can convert
/// directly into one, reusing the same import identity scheme as the DOM
/// capture path (see [PortalSourceIdentity]) so the same course observed
/// through either path upserts to the same record instead of duplicating.
class PortalMediaExtractionPlan {
  const PortalMediaExtractionPlan({
    required this.pageType,
    required this.courses,
    required this.meetings,
  });

  static const int schemaVersion = 1;
  static const String promptVersion = 'portal-media-v1';

  final PortalPageType pageType;
  final List<PortalMediaCourseCandidate> courses;
  final List<PortalMediaMeetingCandidate> meetings;

  factory PortalMediaExtractionPlan.fromJson(Map raw) {
    final pageType = raw['pageType'];
    final courses = raw['courses'] ?? const [];
    final meetings = raw['meetings'] ?? const [];
    if (courses is! List || courses.length > 32) {
      throw const FormatException('Invalid media courses response.');
    }
    if (meetings is! List || meetings.length > 64) {
      throw const FormatException('Invalid media meetings response.');
    }
    return PortalMediaExtractionPlan(
      pageType: PortalPageType.values.firstWhere(
        (value) => value.name == pageType,
        orElse: () => throw const FormatException('Invalid media page type.'),
      ),
      courses: List.unmodifiable(
        courses.map((course) {
          if (course is! Map) {
            throw const FormatException('Invalid media course entry.');
          }
          return PortalMediaCourseCandidate.fromJson(course);
        }),
      ),
      meetings: List.unmodifiable(
        meetings.map((meeting) {
          if (meeting is! Map) {
            throw const FormatException('Invalid media meeting entry.');
          }
          return PortalMediaMeetingCandidate.fromJson(meeting);
        }),
      ),
    );
  }

  /// Converts the validated candidates into a [PortalDraft] scoped to the
  /// currently connected portal [connection], or null when nothing usable
  /// was found. Ambiguous meetings (unparseable day/time, or a course code
  /// that does not match exactly one captured course) are dropped rather
  /// than guessed, matching the DOM extractor's behavior.
  PortalDraft? toDraft(PortalConnection connection, {DateTime? observedAt}) {
    final builtCourses = <String, PortalCourseDraft>{};
    for (final course in courses) {
      final sourceId = PortalSourceIdentity.hash([
        connection.accountId,
        connection.origin,
        connection.institutionId,
        course.code.toLowerCase(),
        course.term?.toLowerCase(),
      ]);
      builtCourses[sourceId] = PortalCourseDraft(
        sourceId: sourceId,
        code: course.code,
        title: course.title,
        term: course.term,
        section: course.section,
        lecturer: course.lecturer,
      );
    }
    final builtMeetings = <String, PortalMeetingDraft>{};
    final occurrenceCounts = <String, int>{};
    for (final meeting in meetings) {
      final matching = builtCourses.values
          .where(
            (course) =>
                course.code.toLowerCase() == meeting.code.toLowerCase() &&
                (meeting.term == null ||
                    course.term?.toLowerCase() == meeting.term?.toLowerCase()),
          )
          .toList(growable: false);
      if (matching.length != 1) continue;
      final day = normalizePortalDay(meeting.day);
      final start = normalizePortalTime(meeting.start);
      final end = normalizePortalTime(meeting.end);
      if (day == null ||
          start == null ||
          end == null ||
          !validPortalTimeRange(start, end)) {
        continue;
      }
      final courseSourceId = matching.single.sourceId;
      final occurrenceKey = '$courseSourceId|$day';
      final occurrence = occurrenceCounts.update(
        occurrenceKey,
        (count) => count + 1,
        ifAbsent: () => 0,
      );
      final sourceId = PortalSourceIdentity.hash([
        courseSourceId,
        day,
        'media',
        occurrence,
      ]);
      builtMeetings[sourceId] = PortalMeetingDraft(
        sourceId: sourceId,
        courseSourceId: courseSourceId,
        day: day,
        startTime: start,
        endTime: end,
        venue: meeting.venue,
      );
    }
    if (builtCourses.isEmpty) return null;
    final draft = PortalDraft(
      courses: builtCourses.values.toList(),
      meetings: builtMeetings.values.toList(),
      sourceOrigin: connection.origin,
      observedAt: observedAt ?? DateTime.now().toUtc(),
    );
    return draft.isValid ? draft : null;
  }
}
