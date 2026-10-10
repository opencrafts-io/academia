import 'ics_calendar_event.dart';
import 'portal_source_identity.dart';

/// One calendar feed event, classified and given a stable import identity.
/// [timeZoneId] is preserved verbatim from the feed (never guessed); a null
/// value on a timed event means the feed did not name a timezone and the
/// student must be asked rather than Academia assuming the phone's zone.
class PortalCalendarEventDraft {
  const PortalCalendarEventDraft({
    required this.sourceId,
    required this.uid,
    required this.summary,
    required this.start,
    required this.shape,
    this.description,
    this.location,
    this.end,
    this.timeZoneId,
    this.isAllDay = false,
    this.recurrenceRuleRaw,
    this.exceptionDates = const [],
    this.missingTimeZone = false,
  });

  final String sourceId;
  final String uid;
  final String summary;
  final String? description;
  final String? location;
  final DateTime start;
  final DateTime? end;
  final String? timeZoneId;
  final bool isAllDay;
  final String? recurrenceRuleRaw;
  final List<DateTime> exceptionDates;
  final PortalCalendarEventShape shape;
  final bool missingTimeZone;
}

/// Calendar events bucketed along the existing agenda/task boundary.
///
/// - [classMeetings]: weekly-recurring, timed events shaped like a class.
///   These are never auto-imported as a generic calendar entry or guessed
///   onto a course; a student must confirm which course they belong to, so
///   they are surfaced through [PortalCalendarImportResult.heldForReview]
///   rather than written automatically.
/// - [deadlines]: single, zero-duration or all-day items shaped like an
///   assignment or exam due date. These import directly as tasks.
/// - [needsReview]: everything that did not match either pattern clearly,
///   including any timed event with no stated timezone. Never guessed.
class PortalCalendarDraft {
  const PortalCalendarDraft({
    required this.classMeetings,
    required this.deadlines,
    required this.needsReview,
    required this.sourceFeedId,
  });

  final List<PortalCalendarEventDraft> classMeetings;
  final List<PortalCalendarEventDraft> deadlines;
  final List<PortalCalendarEventDraft> needsReview;

  /// A hash of the feed URL plus account, never the URL itself. The feed
  /// URL is credential-like and must never appear in a stored draft.
  final String sourceFeedId;

  int get totalEvents =>
      classMeetings.length + deadlines.length + needsReview.length;
}

/// Classifies parsed [events] and builds a [PortalCalendarDraft]. [feedUrl]
/// is hashed into [PortalCalendarDraft.sourceFeedId] together with
/// [accountId] and is never stored or logged in plain text.
PortalCalendarDraft buildPortalCalendarDraft({
  required List<IcsCalendarEvent> events,
  required String accountId,
  required Uri feedUrl,
}) {
  final feedId = PortalSourceIdentity.hash([
    accountId,
    feedUrl.scheme,
    feedUrl.host,
    feedUrl.port,
    feedUrl.path,
    feedUrl.query,
  ]);
  final classMeetings = <PortalCalendarEventDraft>[];
  final deadlines = <PortalCalendarEventDraft>[];
  final needsReview = <PortalCalendarEventDraft>[];
  for (final event in events) {
    final draft = PortalCalendarEventDraft(
      sourceId: PortalSourceIdentity.hash([feedId, event.uid]),
      uid: event.uid,
      summary: event.summary,
      description: event.description,
      location: event.location,
      start: event.start.value,
      end: event.end?.value,
      timeZoneId: event.start.timeZoneId,
      isAllDay: event.start.isAllDay,
      recurrenceRuleRaw: event.recurrenceRule?.raw,
      exceptionDates: event.exceptionDates
          .map((exception) => exception.value)
          .toList(growable: false),
      shape: event.shape,
      missingTimeZone: event.start.hasMissingTimeZone,
    );
    switch (event.shape) {
      case PortalCalendarEventShape.classMeeting:
        classMeetings.add(draft);
      case PortalCalendarEventShape.deadline:
        deadlines.add(draft);
      case PortalCalendarEventShape.ambiguous:
        needsReview.add(draft);
    }
  }
  return PortalCalendarDraft(
    classMeetings: List.unmodifiable(classMeetings),
    deadlines: List.unmodifiable(deadlines),
    needsReview: List.unmodifiable(needsReview),
    sourceFeedId: feedId,
  );
}
