/// A parsed RFC 5545 `DATE` or `DATE-TIME` value.
///
/// [timeZoneId] is the exact `TZID` parameter value when the property named
/// one, or `'UTC'` when the value used the `Z` UTC suffix. It is null for a
/// "floating" local time that named no zone at all — per the portal sync
/// design, a floating time must never be assumed to be the student's phone
/// timezone; the caller should ask the student instead of guessing.
class IcsDateTime {
  const IcsDateTime({
    required this.value,
    required this.isAllDay,
    this.timeZoneId,
  });

  /// The wall-clock value as written in the feed, naive of timezone.
  final DateTime value;

  /// True for a `VALUE=DATE` property (a whole-day entry with no time).
  final bool isAllDay;

  /// The IANA/Olson timezone id, `'UTC'`, or null when unspecified.
  final String? timeZoneId;

  /// True when the source feed did not say what timezone this time is in
  /// and it is not an all-day date (which has no meaningful timezone).
  bool get hasMissingTimeZone => !isAllDay && timeZoneId == null;
}

/// A structural (non-expanding) parse of an RFC 5545 `RRULE` value. Academia
/// preserves the rule and exception dates rather than expanding occurrences,
/// consistent with "never silently reduce alternating weeks to every week."
class IcsRecurrenceRule {
  const IcsRecurrenceRule({
    required this.raw,
    required this.frequency,
    this.interval,
    this.count,
    this.until,
    this.byDay = const [],
  });

  /// The untouched `RRULE` value, preserved for downstream fidelity.
  final String raw;

  /// `DAILY`, `WEEKLY`, `MONTHLY`, `YEARLY`, or null when unrecognized.
  final String? frequency;
  final int? interval;
  final int? count;
  final DateTime? until;

  /// Two-letter day codes, e.g. `['MO', 'WE', 'FR']`.
  final List<String> byDay;

  bool get isWeekly => frequency == 'WEEKLY';
}

/// How a parsed calendar event relates to the existing agenda/task boundary.
/// Academia never guesses a shape for an event that does not match a clear
/// pattern; [ambiguous] events must be surfaced for student review instead
/// of being imported as either a class meeting or a deadline.
enum PortalCalendarEventShape { classMeeting, deadline, ambiguous }

/// One `VEVENT` parsed from a calendar feed, bounded and defensively parsed
/// by [IcsCalendarParser]. Field lengths mirror the limits already enforced
/// on live DOM captures in `PortalSnapshot`.
class IcsCalendarEvent {
  const IcsCalendarEvent({
    required this.uid,
    required this.summary,
    this.description,
    this.location,
    required this.start,
    this.end,
    this.recurrenceRule,
    this.exceptionDates = const [],
  });

  final String uid;
  final String summary;
  final String? description;
  final String? location;
  final IcsDateTime start;
  final IcsDateTime? end;
  final IcsRecurrenceRule? recurrenceRule;
  final List<IcsDateTime> exceptionDates;

  Duration? get duration => end?.value.difference(start.value);

  /// Classifies the event without guessing: a weekly-recurring, timed
  /// meeting is a class meeting; a single, zero/undefined-duration or
  /// all-day item is a deadline; anything else — including a missing
  /// timezone on a timed event — is ambiguous and must be held for review.
  PortalCalendarEventShape get shape {
    if (start.hasMissingTimeZone || (end?.hasMissingTimeZone ?? false)) {
      return PortalCalendarEventShape.ambiguous;
    }
    final rule = recurrenceRule;
    final length = duration;
    if (rule != null &&
        rule.isWeekly &&
        length != null &&
        length.inMinutes > 0) {
      return PortalCalendarEventShape.classMeeting;
    }
    if (rule == null &&
        (start.isAllDay || length == null || length.inMinutes <= 0)) {
      return PortalCalendarEventShape.deadline;
    }
    return PortalCalendarEventShape.ambiguous;
  }
}
