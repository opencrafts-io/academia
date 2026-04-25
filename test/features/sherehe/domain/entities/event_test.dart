import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

void main() {
  group('Event entity', () {
    const tEvent = Event(
      id: 'event-1',
      eventName: 'Test Event',
      eventDescription: 'A test event description',
      eventLocation: 'Nairobi, Kenya',
      startDate: '2025-06-01T10:00:00Z',
      endDate: '2025-06-01T18:00:00Z',
      attendeeCount: 100,
      organizerId: 'org-123',
      createdAt: '2025-01-01T00:00:00Z',
      updatedAt: '2025-01-02T00:00:00Z',
      scope: 'public',
    );

    group('construction', () {
      test('creates instance with all required fields', () {
        expect(tEvent.id, 'event-1');
        expect(tEvent.eventName, 'Test Event');
        expect(tEvent.eventDescription, 'A test event description');
        expect(tEvent.eventLocation, 'Nairobi, Kenya');
        expect(tEvent.startDate, '2025-06-01T10:00:00Z');
        expect(tEvent.endDate, '2025-06-01T18:00:00Z');
        expect(tEvent.attendeeCount, 100);
        expect(tEvent.organizerId, 'org-123');
        expect(tEvent.createdAt, '2025-01-01T00:00:00Z');
        expect(tEvent.updatedAt, '2025-01-02T00:00:00Z');
        expect(tEvent.scope, 'public');
      });

      test('optional fields default to null', () {
        expect(tEvent.eventUrl, isNull);
        expect(tEvent.eventCardImage, isNull);
        expect(tEvent.eventPosterImage, isNull);
        expect(tEvent.eventBannerImage, isNull);
        expect(tEvent.eventGenre, isNull);
        expect(tEvent.deletedAt, isNull);
        expect(tEvent.institutions, isNull);
        expect(tEvent.paymentInfo, isNull);
      });

      test('creates instance with all optional fields populated', () {
        const fullEvent = Event(
          id: 'event-full',
          eventName: 'Full Event',
          eventDescription: 'Full description',
          eventLocation: 'Mombasa, Kenya',
          startDate: '2025-07-01T08:00:00Z',
          endDate: '2025-07-02T20:00:00Z',
          attendeeCount: 500,
          organizerId: 'org-456',
          eventUrl: 'https://event.example.com',
          eventCardImage: 'https://img.example.com/card.jpg',
          eventPosterImage: 'https://img.example.com/poster.jpg',
          eventBannerImage: 'https://img.example.com/banner.jpg',
          eventGenre: ['Music', 'Festival'],
          createdAt: '2025-02-01T00:00:00Z',
          updatedAt: '2025-02-15T00:00:00Z',
          deletedAt: null,
          scope: 'institution',
          institutions: [1, 2, 3],
        );

        expect(fullEvent.eventUrl, 'https://event.example.com');
        expect(fullEvent.eventCardImage, 'https://img.example.com/card.jpg');
        expect(fullEvent.eventPosterImage, 'https://img.example.com/poster.jpg');
        expect(fullEvent.eventBannerImage, 'https://img.example.com/banner.jpg');
        expect(fullEvent.eventGenre, ['Music', 'Festival']);
        expect(fullEvent.scope, 'institution');
        expect(fullEvent.institutions, [1, 2, 3]);
      });
    });

    group('Equatable equality', () {
      test('two events with same fields are equal', () {
        const event1 = Event(
          id: 'event-1',
          eventName: 'Test Event',
          eventDescription: 'A test event description',
          eventLocation: 'Nairobi, Kenya',
          startDate: '2025-06-01T10:00:00Z',
          endDate: '2025-06-01T18:00:00Z',
          attendeeCount: 100,
          organizerId: 'org-123',
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-02T00:00:00Z',
          scope: 'public',
        );

        const event2 = Event(
          id: 'event-1',
          eventName: 'Test Event',
          eventDescription: 'A test event description',
          eventLocation: 'Nairobi, Kenya',
          startDate: '2025-06-01T10:00:00Z',
          endDate: '2025-06-01T18:00:00Z',
          attendeeCount: 100,
          organizerId: 'org-123',
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-02T00:00:00Z',
          scope: 'public',
        );

        expect(event1, equals(event2));
      });

      test('events with different id are not equal', () {
        final event2 = tEvent.copyWith(id: 'event-2');
        expect(tEvent, isNot(equals(event2)));
      });

      test('events with different startDate are not equal', () {
        final event2 = tEvent.copyWith(startDate: '2025-07-01T10:00:00Z');
        expect(tEvent, isNot(equals(event2)));
      });

      test('events with different endDate are not equal', () {
        final event2 = tEvent.copyWith(endDate: '2025-07-01T20:00:00Z');
        expect(tEvent, isNot(equals(event2)));
      });

      test('events with different scope are not equal', () {
        final event2 = tEvent.copyWith(scope: 'institution');
        expect(tEvent, isNot(equals(event2)));
      });

      test('events with different institutions are not equal', () {
        final event2 = tEvent.copyWith(institutions: [1, 2]);
        expect(tEvent, isNot(equals(event2)));
      });
    });

    group('props', () {
      test('props contains all fields including new startDate, endDate, scope, institutions', () {
        final props = tEvent.props;
        expect(props, contains(tEvent.id));
        expect(props, contains(tEvent.eventName));
        expect(props, contains(tEvent.startDate));
        expect(props, contains(tEvent.endDate));
        expect(props, contains(tEvent.scope));
        expect(props.length, 19); // all 19 fields
      });
    });

    group('copyWith', () {
      test('returns same values when no arguments provided', () {
        final copy = tEvent.copyWith();
        expect(copy, equals(tEvent));
      });

      test('copies with new id', () {
        final copy = tEvent.copyWith(id: 'new-id');
        expect(copy.id, 'new-id');
        expect(copy.eventName, tEvent.eventName);
        expect(copy.startDate, tEvent.startDate);
        expect(copy.endDate, tEvent.endDate);
      });

      test('copies with new startDate', () {
        final copy = tEvent.copyWith(startDate: '2025-09-01T09:00:00Z');
        expect(copy.startDate, '2025-09-01T09:00:00Z');
        expect(copy.endDate, tEvent.endDate);
      });

      test('copies with new endDate', () {
        final copy = tEvent.copyWith(endDate: '2025-09-02T22:00:00Z');
        expect(copy.endDate, '2025-09-02T22:00:00Z');
        expect(copy.startDate, tEvent.startDate);
      });

      test('copies with new scope', () {
        final copy = tEvent.copyWith(scope: 'private');
        expect(copy.scope, 'private');
      });

      test('copies with institutions list', () {
        final copy = tEvent.copyWith(institutions: [10, 20, 30]);
        expect(copy.institutions, [10, 20, 30]);
      });

      test('copies with eventGenre list', () {
        final copy = tEvent.copyWith(eventGenre: ['Music', 'Festival']);
        expect(copy.eventGenre, ['Music', 'Festival']);
      });

      test('copies with null deletedAt remains null', () {
        final copy = tEvent.copyWith();
        expect(copy.deletedAt, isNull);
      });

      test('copies with new attendeeCount', () {
        final copy = tEvent.copyWith(attendeeCount: 200);
        expect(copy.attendeeCount, 200);
      });

      test('copies with updated organizerId', () {
        final copy = tEvent.copyWith(organizerId: 'org-999');
        expect(copy.organizerId, 'org-999');
      });
    });

    group('stringify', () {
      test('stringify is true', () {
        expect(tEvent.stringify, isTrue);
      });
    });

    group('hashCode', () {
      test('equal events have same hashCode', () {
        const event1 = Event(
          id: 'hash-test',
          eventName: 'Hash Event',
          eventDescription: 'Hash test',
          eventLocation: 'Kisumu',
          startDate: '2025-08-01T10:00:00Z',
          endDate: '2025-08-01T20:00:00Z',
          attendeeCount: 50,
          organizerId: 'org-hash',
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-02T00:00:00Z',
          scope: 'public',
        );
        const event2 = Event(
          id: 'hash-test',
          eventName: 'Hash Event',
          eventDescription: 'Hash test',
          eventLocation: 'Kisumu',
          startDate: '2025-08-01T10:00:00Z',
          endDate: '2025-08-01T20:00:00Z',
          attendeeCount: 50,
          organizerId: 'org-hash',
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-02T00:00:00Z',
          scope: 'public',
        );
        expect(event1.hashCode, event2.hashCode);
      });
    });
  });
}