import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  IcsCalendarEvent event({
    required String uid,
    String? timeZoneId,
    IcsRecurrenceRule? rule,
    Duration? duration,
    bool allDay = false,
  }) {
    final start = DateTime(2026, 1, 12, 9, 0);
    return IcsCalendarEvent(
      uid: uid,
      summary: 'Event $uid',
      start: IcsDateTime(
        value: start,
        isAllDay: allDay,
        timeZoneId: timeZoneId,
      ),
      end: duration == null
          ? null
          : IcsDateTime(
              value: start.add(duration),
              isAllDay: allDay,
              timeZoneId: timeZoneId,
            ),
      recurrenceRule: rule,
    );
  }

  final weeklyRule = const IcsRecurrenceRule(
    raw: 'FREQ=WEEKLY;BYDAY=MO',
    frequency: 'WEEKLY',
    byDay: ['MO'],
  );

  test('buckets events by shape along the agenda/task boundary', () {
    final draft = buildPortalCalendarDraft(
      events: [
        event(
          uid: 'meeting-1',
          timeZoneId: 'Africa/Nairobi',
          rule: weeklyRule,
          duration: const Duration(hours: 1),
        ),
        event(uid: 'deadline-1', timeZoneId: 'UTC'),
        event(
          uid: 'floating-1',
          rule: weeklyRule,
          duration: const Duration(hours: 1),
        ),
      ],
      accountId: 'account-a',
      feedUrl: Uri.parse('https://canvas.example.edu/feeds/secret-token.ics'),
    );
    expect(draft.classMeetings, hasLength(1));
    expect(draft.classMeetings.single.uid, 'meeting-1');
    expect(draft.deadlines, hasLength(1));
    expect(draft.deadlines.single.uid, 'deadline-1');
    expect(draft.needsReview, hasLength(1));
    expect(draft.needsReview.single.uid, 'floating-1');
    expect(draft.needsReview.single.missingTimeZone, isTrue);
    expect(draft.totalEvents, 3);
  });

  test('never includes the feed URL in sourceFeedId', () {
    final feedUrl = Uri.parse(
      'https://canvas.example.edu/feeds/super-secret-token-123.ics',
    );
    final draft = buildPortalCalendarDraft(
      events: [event(uid: 'deadline-1', timeZoneId: 'UTC')],
      accountId: 'account-a',
      feedUrl: feedUrl,
    );
    expect(draft.sourceFeedId, isNot(contains('secret')));
    expect(draft.sourceFeedId, isNot(contains(feedUrl.toString())));
    expect(draft.sourceFeedId, hasLength(64)); // sha256 hex digest
  });

  test('the same event from the same feed gets the same stable sourceId', () {
    final feedUrl = Uri.parse('https://canvas.example.edu/feeds/a.ics');
    final draftA = buildPortalCalendarDraft(
      events: [event(uid: 'deadline-1', timeZoneId: 'UTC')],
      accountId: 'account-a',
      feedUrl: feedUrl,
    );
    final draftB = buildPortalCalendarDraft(
      events: [event(uid: 'deadline-1', timeZoneId: 'UTC')],
      accountId: 'account-a',
      feedUrl: feedUrl,
    );
    expect(draftA.deadlines.single.sourceId, draftB.deadlines.single.sourceId);
  });

  test('different accounts get different source ids for the same feed', () {
    final feedUrl = Uri.parse('https://canvas.example.edu/feeds/a.ics');
    final draftA = buildPortalCalendarDraft(
      events: [event(uid: 'deadline-1', timeZoneId: 'UTC')],
      accountId: 'account-a',
      feedUrl: feedUrl,
    );
    final draftB = buildPortalCalendarDraft(
      events: [event(uid: 'deadline-1', timeZoneId: 'UTC')],
      accountId: 'account-b',
      feedUrl: feedUrl,
    );
    expect(
      draftA.deadlines.single.sourceId,
      isNot(draftB.deadlines.single.sourceId),
    );
  });
}
