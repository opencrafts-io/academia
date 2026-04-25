import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

void main() {
  group('Ticket entity', () {
    const tTicket = Ticket(
      ticketName: 'General Admission',
      ticketPrice: 500,
    );

    const tFullTicket = Ticket(
      id: 'ticket-1',
      eventId: 'event-1',
      ticketName: 'VIP',
      ticketPrice: 2000,
      ticketQuantity: 50,
      ticketFor: 1,
      institutionIds: [10, 20],
      scope: 'public',
    );

    group('construction', () {
      test('creates instance with required fields only', () {
        expect(tTicket.ticketName, 'General Admission');
        expect(tTicket.ticketPrice, 500);
        expect(tTicket.id, isNull);
        expect(tTicket.eventId, isNull);
        expect(tTicket.ticketQuantity, isNull);
        expect(tTicket.ticketFor, isNull);
        expect(tTicket.institutionIds, isNull);
        expect(tTicket.scope, isNull);
      });

      test('creates instance with all fields populated', () {
        expect(tFullTicket.id, 'ticket-1');
        expect(tFullTicket.eventId, 'event-1');
        expect(tFullTicket.ticketName, 'VIP');
        expect(tFullTicket.ticketPrice, 2000);
        expect(tFullTicket.ticketQuantity, 50);
        expect(tFullTicket.ticketFor, 1);
        expect(tFullTicket.institutionIds, [10, 20]);
        expect(tFullTicket.scope, 'public');
      });

      test('ticket with zero price is valid', () {
        const freeTicket = Ticket(ticketName: 'Free Entry', ticketPrice: 0);
        expect(freeTicket.ticketPrice, 0);
      });

      test('ticket with null institutionIds for public scope', () {
        const publicTicket = Ticket(
          ticketName: 'Public Ticket',
          ticketPrice: 100,
          scope: 'public',
        );
        expect(publicTicket.institutionIds, isNull);
        expect(publicTicket.scope, 'public');
      });

      test('ticket with institutionIds for institution scope', () {
        const institutionTicket = Ticket(
          ticketName: 'Uni Ticket',
          ticketPrice: 200,
          scope: 'institution',
          institutionIds: [1, 2, 3],
        );
        expect(institutionTicket.institutionIds, [1, 2, 3]);
        expect(institutionTicket.scope, 'institution');
      });
    });

    group('Equatable equality', () {
      test('two tickets with same fields are equal', () {
        const ticket1 = Ticket(
          id: 'ticket-1',
          eventId: 'event-1',
          ticketName: 'VIP',
          ticketPrice: 2000,
          ticketQuantity: 50,
          ticketFor: 1,
          institutionIds: [10, 20],
          scope: 'public',
        );
        const ticket2 = Ticket(
          id: 'ticket-1',
          eventId: 'event-1',
          ticketName: 'VIP',
          ticketPrice: 2000,
          ticketQuantity: 50,
          ticketFor: 1,
          institutionIds: [10, 20],
          scope: 'public',
        );
        expect(ticket1, equals(ticket2));
      });

      test('tickets with different id are not equal', () {
        final ticket2 = tFullTicket.copyWith(id: 'ticket-999');
        expect(tFullTicket, isNot(equals(ticket2)));
      });

      test('tickets with different ticketPrice are not equal', () {
        final ticket2 = tFullTicket.copyWith(ticketPrice: 3000);
        expect(tFullTicket, isNot(equals(ticket2)));
      });

      test('tickets with different ticketFor are not equal', () {
        final ticket2 = tFullTicket.copyWith(ticketFor: 5);
        expect(tFullTicket, isNot(equals(ticket2)));
      });

      test('tickets with different scope are not equal', () {
        final ticket2 = tFullTicket.copyWith(scope: 'institution');
        expect(tFullTicket, isNot(equals(ticket2)));
      });

      test('tickets with different institutionIds are not equal', () {
        final ticket2 = tFullTicket.copyWith(institutionIds: [99, 100]);
        expect(tFullTicket, isNot(equals(ticket2)));
      });
    });

    group('props', () {
      test('props contains all 8 fields', () {
        final props = tFullTicket.props;
        expect(props, contains(tFullTicket.id));
        expect(props, contains(tFullTicket.eventId));
        expect(props, contains(tFullTicket.ticketName));
        expect(props, contains(tFullTicket.ticketPrice));
        expect(props, contains(tFullTicket.ticketQuantity));
        expect(props, contains(tFullTicket.ticketFor));
        expect(props, contains(tFullTicket.institutionIds));
        expect(props, contains(tFullTicket.scope));
        expect(props.length, 8);
      });
    });

    group('copyWith', () {
      test('returns equal instance when no arguments provided', () {
        final copy = tFullTicket.copyWith();
        expect(copy, equals(tFullTicket));
      });

      test('copies with new ticketName', () {
        final copy = tFullTicket.copyWith(ticketName: 'Economy');
        expect(copy.ticketName, 'Economy');
        expect(copy.ticketPrice, tFullTicket.ticketPrice);
      });

      test('copies with new ticketPrice', () {
        final copy = tFullTicket.copyWith(ticketPrice: 999);
        expect(copy.ticketPrice, 999);
      });

      test('copies with new ticketQuantity', () {
        final copy = tFullTicket.copyWith(ticketQuantity: 200);
        expect(copy.ticketQuantity, 200);
      });

      test('copies with new ticketFor', () {
        final copy = tFullTicket.copyWith(ticketFor: 2);
        expect(copy.ticketFor, 2);
      });

      test('copies with new institutionIds', () {
        final copy = tFullTicket.copyWith(institutionIds: [5, 6, 7]);
        expect(copy.institutionIds, [5, 6, 7]);
      });

      test('copies with new scope', () {
        final copy = tFullTicket.copyWith(scope: 'private');
        expect(copy.scope, 'private');
      });

      test('copies with new eventId', () {
        final copy = tFullTicket.copyWith(eventId: 'event-new');
        expect(copy.eventId, 'event-new');
        expect(copy.ticketName, tFullTicket.ticketName);
      });

      test('copies with empty institutionIds list', () {
        final copy = tFullTicket.copyWith(institutionIds: []);
        expect(copy.institutionIds, isEmpty);
      });
    });

    group('stringify', () {
      test('stringify is true', () {
        expect(tTicket.stringify, isTrue);
      });
    });

    group('hashCode', () {
      test('equal tickets have same hashCode', () {
        const ticket1 = Ticket(
          id: 'hash-ticket',
          ticketName: 'Standard',
          ticketPrice: 300,
          scope: 'institution',
        );
        const ticket2 = Ticket(
          id: 'hash-ticket',
          ticketName: 'Standard',
          ticketPrice: 300,
          scope: 'institution',
        );
        expect(ticket1.hashCode, ticket2.hashCode);
      });
    });
  });
}