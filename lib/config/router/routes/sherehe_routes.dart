part of '../routes.dart';

@TypedGoRoute<ShereheRoute>(
  path: "/sherehe",
  routes: [
    TypedGoRoute<CreateEventRoute>(
      path: "create",
      routes: [
        TypedGoRoute<ShereheSelectInstitutionsRoute>(
          path: "sherehe-select-institutions",
        ),
        TypedGoRoute<EditAddedTicketRoute>(path: "edit-added-ticket"),
        TypedGoRoute<AddTicketRoute>(path: "add-ticket"),
      ],
    ),
  ],
)
class ShereheRoute extends GoRouteData with $ShereheRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheHome();
  }
}

@TypedGoRoute<ShereheDetailsWithTokenRoute>(
  path: "/sherehe/get-event-with-invite/:invite",
)
class ShereheDetailsWithTokenRoute extends GoRouteData
    with $ShereheDetailsWithTokenRoute {
  final String invite;

  const ShereheDetailsWithTokenRoute({required this.invite});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheDetailsPage(invite: invite);
  }
}

class CreateEventRoute extends GoRouteData with $CreateEventRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateEventScreen();
  }
}

class EditAddedTicketRoute extends GoRouteData with $EditAddedTicketRoute {
  final bool isMultiDayEvent;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;
  final bool isTicketPage;
  final bool isEventScopeInstitution;

  const EditAddedTicketRoute({
    this.isMultiDayEvent = false,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
    required this.isTicketPage,
    required this.isEventScopeInstitution,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final editTicketArgs = state.extra as EditAddedTicketArgs;
    return EditAddedTicketScreen(
      addedTicket: editTicketArgs.ticket,
      isMultiDayEvent: isMultiDayEvent,
      eventStartDateTime: eventStartDateTime,
      eventEndDateTime: eventEndDateTime,
      isTicketPage: isTicketPage,
      isEventScopeInstitution: isEventScopeInstitution,
      eligibleInstitutions: editTicketArgs.eligibleInstitutions,
    );
  }
}

class AddTicketRoute extends GoRouteData with $AddTicketRoute {
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;
  final bool isMultiDayEvent;
  final bool isTicketPage;
  final bool isEventScopeInstitution;

  const AddTicketRoute({
    this.isMultiDayEvent = false,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
    required this.isTicketPage,
    required this.isEventScopeInstitution,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final eligibleInstitutions = state.extra as List<Institution>?;

    return AddTicketScreen(
      isMultiDayEvent: isMultiDayEvent,
      eventStartDateTime: eventStartDateTime,
      eventEndDateTime: eventEndDateTime,
      isTicketPage: isTicketPage,
      isEventScopeInstitution: isEventScopeInstitution,
      eligibleInstitutions: eligibleInstitutions,
    );
  }
}

class ShereheSelectInstitutionsRoute extends GoRouteData
    with $ShereheSelectInstitutionsRoute {
  final String title;
  final String subtitle;

  const ShereheSelectInstitutionsRoute({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final shereheInstitutionsArgs = state.extra is ShereheInstitutionRouteArgs
        ? state.extra as ShereheInstitutionRouteArgs
        : ShereheInstitutionRouteArgs(
            selectedInstitutions: [],
            eligibleInstitutions: [],
          );

    return ShereheSelectInstitutionsScreen(
      title: title,
      subtitle: subtitle,
      selectedInstitutions: shereheInstitutionsArgs.selectedInstitutions,
      eligibleInstitutions: shereheInstitutionsArgs.eligibleInstitutions,
      onlyShowEligibleInstitutions:
          shereheInstitutionsArgs.onlyShowEligibleInstitutions,
    );
  }
}

@TypedGoRoute<ShereheDetailsRoute>(
  path: "/sherehe/get-event/:eventId",
  routes: [
    TypedGoRoute<TicketFlowRoute>(path: "ticket-flow"),
    TypedGoRoute<QrCodeScannerRoute>(path: "qr-code-scanner"),
    TypedGoRoute<EventTicketsRoute>(path: "event-tickets"),
    TypedGoRoute<OrganizerDashboardRoute>(
      path: "organizer-dashboard",
      routes: [
        TypedGoRoute<AllAttendeesRoute>(path: "all-attendees"),
        TypedGoRoute<AllScannersRoute>(
          path: "all-scanners",
          routes: [
            TypedGoRoute<AddEventScannerRoute>(path: "add-event-scanner"),
          ],
        ),
        TypedGoRoute<AllEventTicketsRoute>(
          path: "all-event-tickets",
          routes: [TypedGoRoute<TicketLinksRoute>(path: "ticket-links")],
        ),
        TypedGoRoute<EventLinksRoute>(path: "event-links"),
      ],
    ),
  ],
)
class ShereheDetailsRoute extends GoRouteData with $ShereheDetailsRoute {
  final String eventId;

  const ShereheDetailsRoute({required this.eventId});

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    final event = state.extra is Event ? state.extra as Event : null;

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ShereheDetailsPage(eventId: eventId, event: event),

      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(
              begin: Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

class TicketFlowRoute extends GoRouteData with $TicketFlowRoute {
  final String eventId;

  const TicketFlowRoute({required this.eventId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketFlowPage(eventId: eventId);
  }
}

@TypedGoRoute<TicketFlowWithInviteRoute>(
  path: "/sherehe/ticket-flow-with-invite/:invite",
)
class TicketFlowWithInviteRoute extends GoRouteData
    with $TicketFlowWithInviteRoute {
  final String invite;

  const TicketFlowWithInviteRoute({required this.invite});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketFlowPage(invite: invite);
  }
}

class EventTicketsRoute extends GoRouteData with $EventTicketsRoute {
  final String eventId;

  const EventTicketsRoute({required this.eventId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final args = state.extra as ConfirmPaymentArgs?;

    return BlocProvider(
      create: (context) => sl<UserEventTicketsBloc>(),
      child: EventTicketsPage(
        eventId: eventId,
        event: args?.event,
        attendees: args?.attendees,
      ),
    );
  }
}

class OrganizerDashboardRoute extends GoRouteData
    with $OrganizerDashboardRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final String eventScope;

  const OrganizerDashboardRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final eventInstitutions = state.extra as List<Institution>?;

    return OrganizerDashboardPage(
      eventId: eventId,
      eventName: eventName,
      eventLocation: eventLocation,
      eventStartDate: eventStartDate,
      eventEndDate: eventEndDate,
      eventPosterImage: eventPosterImage,
      eventScope: eventScope,
      eventInstitutions: eventInstitutions,
    );
  }
}

class AllAttendeesRoute extends GoRouteData with $AllAttendeesRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final String eventScope;

  const AllAttendeesRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => sl<AllAttendeesBloc>(),
      child: AllAttendeesScreen(eventId: eventId),
    );
  }
}

class AllScannersRoute extends GoRouteData with $AllScannersRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final String eventScope;

  const AllScannersRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => sl<AllScannersBloc>(),
      child: AllScannersScreen(
        eventId: eventId,
        eventName: eventName,
        eventLocation: eventLocation,
        eventStartDate: eventStartDate,
        eventEndDate: eventEndDate,
        eventPosterImage: eventPosterImage,
        eventScope: eventScope,
      ),
    );
  }
}

class AllEventTicketsRoute extends GoRouteData with $AllEventTicketsRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final bool isEventScopeInstitution;
  final String eventScope;

  const AllEventTicketsRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.isEventScopeInstitution,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final eligibleInstitutions = state.extra as List<Institution>?;

    return BlocProvider(
      create: (context) =>
          sl<TicketStatsBloc>()..add(GetTicketStats(eventId: eventId)),
      child: AllEventTicketsScreen(
        eventId: eventId,
        eventName: eventName,
        eventLocation: eventLocation,
        eventStartDate: eventStartDate,
        eventEndDate: eventEndDate,
        eventPosterImage: eventPosterImage,
        eligibleInstitutions: eligibleInstitutions,
        isEventScopeInstitution: isEventScopeInstitution,
        eventScope: eventScope,
      ),
    );
  }
}

class TicketLinksRoute extends GoRouteData with $TicketLinksRoute {
  final String eventId;
  final String ticketId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final bool isEventScopeInstitution;
  final String eventScope;

  const TicketLinksRoute({
    required this.eventId,
    required this.ticketId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.isEventScopeInstitution,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) =>
          sl<TicketLinkBloc>()..add(GetTicketInvites(ticketId: ticketId)),
      child: TicketLinksScreen(
        ticketId: ticketId,
        eventName: eventName,
        eventLocation: eventLocation,
        eventStartDate: eventStartDate,
        eventEndDate: eventEndDate,
        eventPosterImage: eventPosterImage,
      ),
    );
  }
}

class EventLinksRoute extends GoRouteData with $EventLinksRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final String eventScope;

  const EventLinksRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) =>
          sl<EventLinkBloc>()..add(GetEventInvites(eventId: eventId)),
      child: EventLinksScreen(
        eventId: eventId,
        eventName: eventName,
        eventLocation: eventLocation,
        eventStartDate: eventStartDate,
        eventEndDate: eventEndDate,
        eventPosterImage: eventPosterImage,
      ),
    );
  }
}

class AddEventScannerRoute extends GoRouteData with $AddEventScannerRoute {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;
  final String eventScope;

  const AddEventScannerRoute({
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
    required this.eventScope,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddEventScannerScreen(eventId: eventId);
  }
}

@TypedGoRoute<CreateTicketRoute>(path: "/organizer-dashboard/create-ticket")
class CreateTicketRoute extends GoRouteData with $CreateTicketRoute {
  final String eventId;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;
  final bool isEventScopeInstitution;

  const CreateTicketRoute({
    required this.eventId,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
    required this.isEventScopeInstitution,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final eligibleInstitutions = state.extra as List<Institution>?;

    return CreateTicketScreen(
      eventId: eventId,
      eventStartDateTime: eventStartDateTime,
      eventEndDateTime: eventEndDateTime,
      isEventScopeInstitution: isEventScopeInstitution,
      eligibleInstitutions: eligibleInstitutions,
    );
  }
}

@TypedGoRoute<PurchasedTicketsRoute>(path: "/purchased-tickets/all")
class PurchasedTicketsRoute extends GoRouteData with $PurchasedTicketsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => sl<AllUserEventTicketsBloc>(),
      child: PurchasedTicketsPage(),
    );
  }
}

@TypedGoRoute<OrganizedEventsRoute>(path: "/organized-events/mine")
class OrganizedEventsRoute extends GoRouteData with $OrganizedEventsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => sl<OrganizedEventsBloc>(),
      child: OrganizedEventsScreen(),
    );
  }
}

@TypedGoRoute<TicketReceiptRoute>(path: "/ticket-receipt")
class TicketReceiptRoute extends GoRouteData with $TicketReceiptRoute {
  final int ticketPrice;
  final int quantity;

  const TicketReceiptRoute({required this.ticketPrice, required this.quantity});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketReceiptScreen(ticketPrice: ticketPrice, quantity: quantity);
  }
}

@TypedGoRoute<QrCodeRoute>(path: "/qr-code/:eventId/:attendeeId")
class QrCodeRoute extends GoRouteData with $QrCodeRoute {
  final String eventId;
  final String attendeeId;
  final String ticketName;
  final int quantity;
  final String? ticketStartDate;
  final String? ticketEndDate;

  const QrCodeRoute({
    required this.eventId,
    required this.attendeeId,
    required this.ticketName,
    required this.quantity,
    this.ticketStartDate,
    this.ticketEndDate,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final event = state.extra as Event;

    return QrCodeScreen(
      eventId: eventId,
      attendeeId: attendeeId,
      ticketName: ticketName,
      quantity: quantity,
      event: event,
      ticketStartDate: ticketStartDate,
      ticketEndDate: ticketEndDate,
    );
  }
}

class QrCodeScannerRoute extends GoRouteData with $QrCodeScannerRoute {
  final String eventId;

  const QrCodeScannerRoute({required this.eventId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => sl<ValidateAttendeeBloc>(),
      child: QrCodeScannerScreen(eventId: eventId),
    );
  }
}
