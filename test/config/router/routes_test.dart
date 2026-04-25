import 'package:flutter_test/flutter_test.dart';
import 'package:academia/config/router/routes.dart';

void main() {
  group('Route location strings', () {
    group('TicketFlowRoute', () {
      test('location does not include userId query param', () {
        final route = TicketFlowRoute(eventId: 'evt-123');
        expect(route.location, contains('/sherehe/get-event/evt-123/ticket-flow'));
        expect(route.location, isNot(contains('user-id')));
      });

      test('location uses encoded eventId', () {
        final route = TicketFlowRoute(eventId: 'simple-id');
        expect(
          route.location,
          '/sherehe/get-event/simple-id/ticket-flow',
        );
      });

      test('location encodes special characters in eventId', () {
        final route = TicketFlowRoute(eventId: 'event with spaces');
        // Uri.encodeComponent encodes spaces as %20
        expect(route.location, contains('event%20with%20spaces'));
        expect(route.location, contains('/ticket-flow'));
      });

      test('location does not have query parameters', () {
        final route = TicketFlowRoute(eventId: 'evt-abc');
        expect(route.location, isNot(contains('?')));
      });
    });

    group('ShereheDetailsWithTokenRoute', () {
      test('location contains invite path parameter', () {
        final route = ShereheDetailsWithTokenRoute(invite: 'my-invite-token');
        expect(
          route.location,
          '/sherehe/get-event-with-invite/my-invite-token',
        );
      });

      test('location uses correct base path', () {
        final route = ShereheDetailsWithTokenRoute(invite: 'abc123');
        expect(route.location, startsWith('/sherehe/get-event-with-invite/'));
      });

      test('location encodes special characters in invite', () {
        final route = ShereheDetailsWithTokenRoute(invite: 'token with space');
        expect(route.location, contains('token%20with%20space'));
      });

      test('location with UUID-style invite', () {
        final route = ShereheDetailsWithTokenRoute(
          invite: '550e8400-e29b-41d4-a716-446655440000',
        );
        expect(
          route.location,
          '/sherehe/get-event-with-invite/550e8400-e29b-41d4-a716-446655440000',
        );
      });
    });

    group('TicketFlowWithInviteRoute', () {
      test('location contains invite path parameter', () {
        final route = TicketFlowWithInviteRoute(invite: 'my-ticket-invite');
        expect(
          route.location,
          '/sherehe/ticket-flow-with-invite/my-ticket-invite',
        );
      });

      test('location uses correct base path', () {
        final route = TicketFlowWithInviteRoute(invite: 'token123');
        expect(route.location, startsWith('/sherehe/ticket-flow-with-invite/'));
      });

      test('location encodes special characters in invite', () {
        final route = TicketFlowWithInviteRoute(invite: 'some/path');
        expect(route.location, contains('some%2Fpath'));
      });

      test('location with UUID-style invite', () {
        final route = TicketFlowWithInviteRoute(
          invite: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        );
        expect(
          route.location,
          '/sherehe/ticket-flow-with-invite/a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        );
      });
    });

    group('EditAddedTicketRoute', () {
      test('location is static path without parameters', () {
        final route = EditAddedTicketRoute();
        expect(route.location, '/sherehe/create/edit-added-ticket');
      });

      test('multiple instances have same location', () {
        final route1 = EditAddedTicketRoute();
        final route2 = EditAddedTicketRoute();
        expect(route1.location, equals(route2.location));
      });
    });

    group('ShereheSelectInstitutionsRoute', () {
      test('location contains title and subtitle as query params', () {
        final route = ShereheSelectInstitutionsRoute(
          title: 'Select Universities',
          subtitle: 'Choose your institution',
        );
        expect(route.location, contains('/sherehe/create/sherehe-select-institutions'));
        expect(route.location, contains('title=Select+Universities'));
        expect(route.location, contains('subtitle=Choose+your+institution'));
      });

      test('location base path is correct', () {
        final route = ShereheSelectInstitutionsRoute(
          title: 'Title',
          subtitle: 'Sub',
        );
        expect(route.location, startsWith('/sherehe/create/sherehe-select-institutions'));
      });

      test('location includes both title and subtitle query params', () {
        final route = ShereheSelectInstitutionsRoute(
          title: 'My Title',
          subtitle: 'My Subtitle',
        );
        expect(route.location, contains('title='));
        expect(route.location, contains('subtitle='));
      });

      test('two routes with same params have same location', () {
        final route1 = ShereheSelectInstitutionsRoute(
          title: 'Title',
          subtitle: 'Sub',
        );
        final route2 = ShereheSelectInstitutionsRoute(
          title: 'Title',
          subtitle: 'Sub',
        );
        expect(route1.location, equals(route2.location));
      });

      test('two routes with different titles have different locations', () {
        final route1 = ShereheSelectInstitutionsRoute(
          title: 'Title A',
          subtitle: 'Sub',
        );
        final route2 = ShereheSelectInstitutionsRoute(
          title: 'Title B',
          subtitle: 'Sub',
        );
        expect(route1.location, isNot(equals(route2.location)));
      });
    });

    group('Route path structure consistency', () {
      test('ShereheDetailsWithTokenRoute and TicketFlowWithInviteRoute use different base paths', () {
        final detailsRoute = ShereheDetailsWithTokenRoute(invite: 'same-token');
        final ticketRoute = TicketFlowWithInviteRoute(invite: 'same-token');
        expect(detailsRoute.location, isNot(equals(ticketRoute.location)));
      });

      test('EditAddedTicketRoute does not contain event or invite in path', () {
        final route = EditAddedTicketRoute();
        expect(route.location, isNot(contains('event')));
        expect(route.location, isNot(contains('invite')));
      });
    });
  });
}