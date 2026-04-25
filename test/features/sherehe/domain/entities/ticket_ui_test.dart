import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:academia/features/sherehe/domain/entities/ticket_ui.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:academia/features/institution/domain/entities/institution.dart';

void main() {
  group('TicketUI', () {
    final tInstitution = Institution(
      institutionId: 1,
      name: 'Test University',
      webPages: ['https://testuni.ac.ke'],
      domains: ['testuni.ac.ke'],
      alphaTwoCode: 'KE',
      country: 'Kenya',
    );

    const tTicket = Ticket(
      id: 'ticket-1',
      eventId: 'event-1',
      ticketName: 'VIP',
      ticketPrice: 1500,
      scope: 'institution',
    );

    late TicketUI tTicketUI;

    setUp(() {
      tTicketUI = TicketUI(
        ticket: tTicket,
        institutions: [tInstitution],
        selectedTicketGroupType: TicketGroupTypes.individual,
        selectedScopeType: ScopeTypes.institution,
      );
    });

    group('construction', () {
      test('creates instance with all required fields', () {
        expect(tTicketUI.ticket, equals(tTicket));
        expect(tTicketUI.institutions, hasLength(1));
        expect(tTicketUI.institutions.first.institutionId, 1);
        expect(tTicketUI.selectedTicketGroupType, TicketGroupTypes.individual);
        expect(tTicketUI.selectedScopeType, ScopeTypes.institution);
      });

      test('creates instance with null selectedTicketGroupType', () {
        final ticketUI = TicketUI(
          ticket: tTicket,
          institutions: const [],
          selectedTicketGroupType: null,
          selectedScopeType: ScopeTypes.public,
        );
        expect(ticketUI.selectedTicketGroupType, isNull);
      });

      test('creates instance with null selectedScopeType', () {
        final ticketUI = TicketUI(
          ticket: tTicket,
          institutions: const [],
          selectedTicketGroupType: TicketGroupTypes.groupOfTwo,
          selectedScopeType: null,
        );
        expect(ticketUI.selectedScopeType, isNull);
      });

      test('creates instance with empty institutions list', () {
        final ticketUI = TicketUI(
          ticket: tTicket,
          institutions: const [],
          selectedTicketGroupType: null,
          selectedScopeType: null,
        );
        expect(ticketUI.institutions, isEmpty);
      });

      test('creates instance with multiple institutions', () {
        final institution2 = Institution(
          institutionId: 2,
          name: 'Another University',
          webPages: null,
          domains: null,
          alphaTwoCode: 'KE',
          country: 'Kenya',
        );
        final ticketUI = TicketUI(
          ticket: tTicket,
          institutions: [tInstitution, institution2],
          selectedTicketGroupType: null,
          selectedScopeType: ScopeTypes.institution,
        );
        expect(ticketUI.institutions, hasLength(2));
      });
    });

    group('copyWith', () {
      test('returns same values when no arguments provided', () {
        final copy = tTicketUI.copyWith();
        expect(copy.ticket, equals(tTicketUI.ticket));
        expect(copy.institutions, equals(tTicketUI.institutions));
        expect(copy.selectedTicketGroupType, tTicketUI.selectedTicketGroupType);
        expect(copy.selectedScopeType, tTicketUI.selectedScopeType);
      });

      test('copies with new ticket', () {
        const newTicket = Ticket(
          id: 'ticket-new',
          ticketName: 'Economy',
          ticketPrice: 200,
        );
        final copy = tTicketUI.copyWith(ticket: newTicket);
        expect(copy.ticket, equals(newTicket));
        expect(copy.institutions, equals(tTicketUI.institutions));
        expect(copy.selectedTicketGroupType, tTicketUI.selectedTicketGroupType);
        expect(copy.selectedScopeType, tTicketUI.selectedScopeType);
      });

      test('copies with new institutions list', () {
        final newInstitution = Institution(
          institutionId: 99,
          name: 'New University',
          webPages: null,
          domains: null,
          alphaTwoCode: 'UG',
          country: 'Uganda',
        );
        final copy = tTicketUI.copyWith(institutions: [newInstitution]);
        expect(copy.institutions, hasLength(1));
        expect(copy.institutions.first.institutionId, 99);
        expect(copy.ticket, equals(tTicketUI.ticket));
      });

      test('copies with new selectedTicketGroupType', () {
        final copy = tTicketUI.copyWith(
          selectedTicketGroupType: TicketGroupTypes.groupOfFive,
        );
        expect(copy.selectedTicketGroupType, TicketGroupTypes.groupOfFive);
        expect(copy.selectedScopeType, tTicketUI.selectedScopeType);
      });

      test('copies with new selectedScopeType', () {
        final copy = tTicketUI.copyWith(selectedScopeType: ScopeTypes.public);
        expect(copy.selectedScopeType, ScopeTypes.public);
        expect(copy.selectedTicketGroupType, tTicketUI.selectedTicketGroupType);
      });

      test('copies with null selectedTicketGroupType', () {
        final copy = tTicketUI.copyWith(selectedTicketGroupType: null);
        // When null is provided, copyWith keeps original (uses ??)
        expect(copy.selectedTicketGroupType, tTicketUI.selectedTicketGroupType);
      });

      test('copies with empty institutions list', () {
        final copy = tTicketUI.copyWith(institutions: []);
        expect(copy.institutions, isEmpty);
      });
    });
  });
}