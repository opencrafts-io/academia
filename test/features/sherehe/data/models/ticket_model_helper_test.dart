import 'package:flutter_test/flutter_test.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/ticket_model_helper.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

// Helper to create TicketData instances for testing
TicketData makeTicketData({
  String? id,
  String? eventId,
  String ticketName = 'General Admission',
  int ticketPrice = 500,
  int? ticketQuantity,
  int? ticketFor,
  List<dynamic>? institutions,
  String? scope,
}) {
  return TicketData(
    id: id,
    eventId: eventId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketQuantity: ticketQuantity,
    ticketFor: ticketFor,
    institutions: institutions,
    scope: scope,
  );
}

void main() {
  group('TicketModelHelper (TicketData.toEntity)', () {
    test('maps required fields correctly', () {
      final model = makeTicketData(
        id: 'ticket-1',
        eventId: 'event-1',
        ticketName: 'VIP',
        ticketPrice: 2000,
        scope: 'public',
      );
      final entity = model.toEntity();

      expect(entity.id, 'ticket-1');
      expect(entity.eventId, 'event-1');
      expect(entity.ticketName, 'VIP');
      expect(entity.ticketPrice, 2000);
      expect(entity.scope, 'public');
    });

    test('maps ticketFor field (replaces old deleteTag/ticketVisibility)', () {
      final model = makeTicketData(ticketFor: 1);
      final entity = model.toEntity();
      expect(entity.ticketFor, 1);
    });

    test('maps null ticketFor to null in entity', () {
      final model = makeTicketData(ticketFor: null);
      final entity = model.toEntity();
      expect(entity.ticketFor, isNull);
    });

    test('maps ticketFor=2 for group-of-two tickets', () {
      final model = makeTicketData(ticketFor: 2);
      final entity = model.toEntity();
      expect(entity.ticketFor, 2);
    });

    test('maps ticketFor=5 for group-of-five tickets', () {
      final model = makeTicketData(ticketFor: 5);
      final entity = model.toEntity();
      expect(entity.ticketFor, 5);
    });

    test('maps null institutions to null institutionIds', () {
      final model = makeTicketData(institutions: null);
      final entity = model.toEntity();
      expect(entity.institutionIds, isNull);
    });

    test('maps empty institutions list to empty institutionIds', () {
      final model = makeTicketData(institutions: []);
      final entity = model.toEntity();
      expect(entity.institutionIds, isEmpty);
    });

    test('maps valid integer institutions list to List<int>', () {
      final model = makeTicketData(institutions: [1, 2, 3]);
      final entity = model.toEntity();
      expect(entity.institutionIds, [1, 2, 3]);
    });

    test('maps string-encoded integers in institutions list via int.tryParse', () {
      // institutions stored as JSON list may contain string-formatted ints
      final model = makeTicketData(institutions: ['10', '20', '30']);
      final entity = model.toEntity();
      expect(entity.institutionIds, [10, 20, 30]);
    });

    test('filters out non-parseable entries from institutions list', () {
      // int.tryParse returns null for non-int strings, whereType<int>() filters them
      final model = makeTicketData(institutions: ['abc', 1, '99', 'xyz']);
      final entity = model.toEntity();
      // Only valid int-parseable values survive: 1, 99
      expect(entity.institutionIds, [1, 99]);
    });

    test('filters out null entries from institutions list', () {
      final model = makeTicketData(institutions: [1, null, 3]);
      final entity = model.toEntity();
      // int.tryParse(null.toString()) = int.tryParse('null') = null, filtered out
      expect(entity.institutionIds, [1, 3]);
    });

    test('maps mixed numeric types in institutions list', () {
      final model = makeTicketData(institutions: [10, '20']);
      final entity = model.toEntity();
      expect(entity.institutionIds, [10, 20]);
    });

    test('maps scope field correctly', () {
      final model = makeTicketData(scope: 'institution');
      final entity = model.toEntity();
      expect(entity.scope, 'institution');
    });

    test('maps null scope to null in entity', () {
      final model = makeTicketData(scope: null);
      final entity = model.toEntity();
      expect(entity.scope, isNull);
    });

    test('maps ticketQuantity field', () {
      final model = makeTicketData(ticketQuantity: 100);
      final entity = model.toEntity();
      expect(entity.ticketQuantity, 100);
    });

    test('maps null ticketQuantity to null', () {
      final model = makeTicketData(ticketQuantity: null);
      final entity = model.toEntity();
      expect(entity.ticketQuantity, isNull);
    });

    test('returns Ticket instance', () {
      final model = makeTicketData();
      final entity = model.toEntity();
      expect(entity, isA<Ticket>());
    });

    test('handles zero ticketPrice', () {
      final model = makeTicketData(ticketPrice: 0);
      final entity = model.toEntity();
      expect(entity.ticketPrice, 0);
    });

    test('single institution in list parsed correctly', () {
      final model = makeTicketData(institutions: [42]);
      final entity = model.toEntity();
      expect(entity.institutionIds, [42]);
      expect(entity.institutionIds!.length, 1);
    });
  });

  group('TicketEntityHelper (Ticket.toModel)', () {
    const tTicket = Ticket(
      id: 'ticket-entity-1',
      eventId: 'event-entity-1',
      ticketName: 'Standard',
      ticketPrice: 300,
      ticketQuantity: 50,
      ticketFor: 1,
      institutionIds: [10, 20],
      scope: 'institution',
    );

    test('maps required entity fields to model', () {
      final model = tTicket.toModel();

      expect(model.id, 'ticket-entity-1');
      expect(model.eventId, 'event-entity-1');
      expect(model.ticketName, 'Standard');
      expect(model.ticketPrice, 300);
      expect(model.ticketQuantity, 50);
      expect(model.ticketFor, 1);
      expect(model.scope, 'institution');
    });

    test('maps ticketFor to model ticketFor', () {
      final model = tTicket.toModel();
      expect(model.ticketFor, 1);
    });

    test('maps institutionIds to model institutions', () {
      final model = tTicket.toModel();
      // institutionIds mapped via e => e (as-is)
      expect(model.institutions, [10, 20]);
    });

    test('maps null institutionIds to null institutions in model', () {
      const ticket = Ticket(ticketName: 'No inst', ticketPrice: 100);
      final model = ticket.toModel();
      expect(model.institutions, isNull);
    });

    test('maps null ticketFor to model', () {
      const ticket = Ticket(ticketName: 'Any', ticketPrice: 100);
      final model = ticket.toModel();
      expect(model.ticketFor, isNull);
    });

    test('maps null scope to null in model', () {
      const ticket = Ticket(ticketName: 'Any', ticketPrice: 100);
      final model = ticket.toModel();
      expect(model.scope, isNull);
    });

    test('returns TicketData instance', () {
      final model = tTicket.toModel();
      expect(model, isA<TicketData>());
    });

    test('maps empty institutionIds list to empty model institutions', () {
      const ticket = Ticket(
        ticketName: 'Empty inst',
        ticketPrice: 100,
        institutionIds: [],
      );
      final model = ticket.toModel();
      expect(model.institutions, isEmpty);
    });

    group('roundtrip (toModel then toEntity)', () {
      test('ticketFor survives roundtrip', () {
        final model = tTicket.toModel();
        final roundtripped = model.toEntity();
        expect(roundtripped.ticketFor, tTicket.ticketFor);
      });

      test('scope survives roundtrip', () {
        final model = tTicket.toModel();
        final roundtripped = model.toEntity();
        expect(roundtripped.scope, tTicket.scope);
      });

      test('ticketName and ticketPrice survive roundtrip', () {
        final model = tTicket.toModel();
        final roundtripped = model.toEntity();
        expect(roundtripped.ticketName, tTicket.ticketName);
        expect(roundtripped.ticketPrice, tTicket.ticketPrice);
      });

      test('institutionIds survive roundtrip with integer values', () {
        // After toModel, institutions is [10, 20] (ints)
        // After toEntity, int.tryParse(e.toString()) returns [10, 20]
        final model = tTicket.toModel();
        final roundtripped = model.toEntity();
        expect(roundtripped.institutionIds, [10, 20]);
      });
    });
  });
}