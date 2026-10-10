import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

String _crlf(String text) => text.replaceAll('\n', '\r\n');

void main() {
  group('IcsCalendarParser', () {
    test('parses a valid feed with a single deadline-shaped event', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Example School//Calendar//EN
BEGIN:VEVENT
UID:assignment-1@example.edu
SUMMARY:Essay due
DESCRIPTION:Submit via the portal.
DTSTART:20260115T235900Z
END:VEVENT
END:VCALENDAR
''');
      final parsed = IcsCalendarParser.parse(text);
      expect(parsed.events, hasLength(1));
      final event = parsed.events.single;
      expect(event.uid, 'assignment-1@example.edu');
      expect(event.summary, 'Essay due');
      expect(event.start.timeZoneId, 'UTC');
      expect(event.end, isNull);
      expect(event.shape, PortalCalendarEventShape.deadline);
    });

    test('parses a weekly RRULE as a class meeting', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:cs101-lecture@example.edu
SUMMARY:CS101 Lecture
DTSTART;TZID=Africa/Nairobi:20260112T090000
DTEND;TZID=Africa/Nairobi:20260112T100000
RRULE:FREQ=WEEKLY;BYDAY=MO;COUNT=10
END:VEVENT
END:VCALENDAR
''');
      final parsed = IcsCalendarParser.parse(text);
      final event = parsed.events.single;
      expect(event.start.timeZoneId, 'Africa/Nairobi');
      expect(event.recurrenceRule, isNotNull);
      expect(event.recurrenceRule!.isWeekly, isTrue);
      expect(event.recurrenceRule!.byDay, ['MO']);
      expect(event.recurrenceRule!.count, 10);
      expect(event.duration, const Duration(hours: 1));
      expect(event.shape, PortalCalendarEventShape.classMeeting);
    });

    test('preserves EXDATE exceptions on a recurring event', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:cs101-lecture@example.edu
SUMMARY:CS101 Lecture
DTSTART;TZID=Africa/Nairobi:20260112T090000
DTEND;TZID=Africa/Nairobi:20260112T100000
RRULE:FREQ=WEEKLY;BYDAY=MO
EXDATE;TZID=Africa/Nairobi:20260119T090000
EXDATE;TZID=Africa/Nairobi:20260126T090000
END:VEVENT
END:VCALENDAR
''');
      final parsed = IcsCalendarParser.parse(text);
      final event = parsed.events.single;
      expect(event.exceptionDates, hasLength(2));
      expect(event.exceptionDates.first.value, DateTime(2026, 1, 19, 9, 0, 0));
      expect(event.exceptionDates.first.timeZoneId, 'Africa/Nairobi');
    });

    test(
      'a timed event with no TZID and no Z suffix is ambiguous, never guessed',
      () {
        final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:floating-time@example.edu
SUMMARY:Lab session
DTSTART:20260112T090000
DTEND:20260112T110000
RRULE:FREQ=WEEKLY;BYDAY=MO
END:VEVENT
END:VCALENDAR
''');
        final parsed = IcsCalendarParser.parse(text);
        final event = parsed.events.single;
        expect(event.start.hasMissingTimeZone, isTrue);
        expect(event.start.timeZoneId, isNull);
        // Even though it otherwise matches the weekly class-meeting pattern,
        // a missing timezone must never be assumed to be the phone's zone.
        expect(event.shape, PortalCalendarEventShape.ambiguous);
      },
    );

    test('rejects a feed with no BEGIN:VCALENDAR', () {
      expect(
        () => IcsCalendarParser.parse('UID:not-a-calendar\n'),
        throwsFormatException,
      );
    });

    test('rejects a VEVENT missing UID', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
SUMMARY:No uid here
DTSTART:20260115T235900Z
END:VEVENT
END:VCALENDAR
''');
      expect(() => IcsCalendarParser.parse(text), throwsFormatException);
    });

    test('rejects an unbalanced feed', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:unterminated@example.edu
SUMMARY:Oops
DTSTART:20260115T235900Z
END:VCALENDAR
''');
      expect(() => IcsCalendarParser.parse(text), throwsFormatException);
    });

    test('rejects an oversized feed text', () {
      final huge = 'X' * (IcsCalendarParser.maxFeedTextLength + 1);
      expect(() => IcsCalendarParser.parse(huge), throwsFormatException);
    });

    test('unfolds a wrapped property line', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:wrapped@example.edu
SUMMARY:Essay due
 across two lines
DTSTART:20260115T235900Z
END:VEVENT
END:VCALENDAR
''');
      final parsed = IcsCalendarParser.parse(text);
      expect(parsed.events.single.summary, 'Essay dueacross two lines');
    });

    test('captures a representative VTIMEZONE offset', () {
      final text = _crlf('''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VTIMEZONE
TZID:Africa/Nairobi
BEGIN:STANDARD
DTSTART:19700101T000000
TZOFFSETFROM:+0300
TZOFFSETTO:+0300
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
UID:cs101-lecture@example.edu
SUMMARY:CS101 Lecture
DTSTART;TZID=Africa/Nairobi:20260112T090000
DTEND;TZID=Africa/Nairobi:20260112T100000
RRULE:FREQ=WEEKLY;BYDAY=MO
END:VEVENT
END:VCALENDAR
''');
      final parsed = IcsCalendarParser.parse(text);
      expect(parsed.timeZoneOffsets['Africa/Nairobi'], '+0300');
    });
  });
}
