// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $layoutShellRoute,
  $feedRoute,
  $postDetailRoute,
  $addPostRoute,
  $blockedItemsRoute,
  $authRoute,
  $profileRoute,
  $completeProfileRoute,
  $shereheRoute,
  $purchasedTicketsRoute,
  $organizedEventsRoute,
  $ticketReceiptRoute,
  $qrCodeRoute,
  $todosRoute,
  $communitiesRoute,
  $createCommunitiesRoute,
  $trimVideoRoute,
  $communityMembershipsRoute,
  $achievementsHomePageRoute,
  $activitiesPageRoute,
  $examTimetableRoute,
  $settingsPageRoute,
  $institutionShellRouteData,
  $semestersPageRoute,
  $coursesPageRoute,
];

RouteBase get $layoutShellRoute => StatefulShellRouteData.$route(
  factory: $LayoutShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [GoRouteData.$route(path: '/', factory: $HomeRoute._fromState)],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/calendar',
          factory: $CalendarRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'create',
              factory: $CreateAgendaEventRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'item/:id',
              factory: $AgendaItemViewRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/essentials',
          factory: $EssentialsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $LayoutShellRouteExtension on LayoutShellRoute {
  static LayoutShellRoute _fromState(GoRouterState state) =>
      const LayoutShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CalendarRoute on GoRouteData {
  static CalendarRoute _fromState(GoRouterState state) => CalendarRoute();

  @override
  String get location => GoRouteData.$location('/calendar');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateAgendaEventRoute on GoRouteData {
  static CreateAgendaEventRoute _fromState(GoRouterState state) =>
      CreateAgendaEventRoute();

  @override
  String get location => GoRouteData.$location('/calendar/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AgendaItemViewRoute on GoRouteData {
  static AgendaItemViewRoute _fromState(GoRouterState state) =>
      AgendaItemViewRoute(id: state.pathParameters['id']);

  AgendaItemViewRoute get _self => this as AgendaItemViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/calendar/item/${Uri.encodeComponent(_self.id ?? '')}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EssentialsRoute on GoRouteData {
  static EssentialsRoute _fromState(GoRouterState state) => EssentialsRoute();

  @override
  String get location => GoRouteData.$location('/essentials');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $feedRoute =>
    GoRouteData.$route(path: '/feed', factory: $FeedRoute._fromState);

mixin $FeedRoute on GoRouteData {
  static FeedRoute _fromState(GoRouterState state) => FeedRoute();

  @override
  String get location => GoRouteData.$location('/feed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $postDetailRoute => GoRouteData.$route(
  path: '/post/:postId',
  factory: $PostDetailRoute._fromState,
);

mixin $PostDetailRoute on GoRouteData {
  static PostDetailRoute _fromState(GoRouterState state) =>
      PostDetailRoute(postId: int.parse(state.pathParameters['postId']!));

  PostDetailRoute get _self => this as PostDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/post/${Uri.encodeComponent(_self.postId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addPostRoute =>
    GoRouteData.$route(path: '/add-post', factory: $AddPostRoute._fromState);

mixin $AddPostRoute on GoRouteData {
  static AddPostRoute _fromState(GoRouterState state) => const AddPostRoute();

  @override
  String get location => GoRouteData.$location('/add-post');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $blockedItemsRoute => GoRouteData.$route(
  path: '/blocked-items',
  factory: $BlockedItemsRoute._fromState,
);

mixin $BlockedItemsRoute on GoRouteData {
  static BlockedItemsRoute _fromState(GoRouterState state) =>
      BlockedItemsRoute();

  @override
  String get location => GoRouteData.$location('/blocked-items');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authRoute =>
    GoRouteData.$route(path: '/auth', factory: $AuthRoute._fromState);

mixin $AuthRoute on GoRouteData {
  static AuthRoute _fromState(GoRouterState state) => AuthRoute();

  @override
  String get location => GoRouteData.$location('/auth');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileRoute => GoRouteData.$route(
  path: '/profile',
  factory: $ProfileRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'link-institution',
      factory: $LinkInstitutionProfileRoute._fromState,
    ),
  ],
);

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LinkInstitutionProfileRoute on GoRouteData {
  static LinkInstitutionProfileRoute _fromState(GoRouterState state) =>
      LinkInstitutionProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile/link-institution');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $completeProfileRoute => GoRouteData.$route(
  path: '/complete-profile',
  factory: $CompleteProfileRoute._fromState,
);

mixin $CompleteProfileRoute on GoRouteData {
  static CompleteProfileRoute _fromState(GoRouterState state) =>
      CompleteProfileRoute();

  @override
  String get location => GoRouteData.$location('/complete-profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $shereheRoute => GoRouteData.$route(
  path: '/sherehe',
  factory: $ShereheRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'get-event/:eventId',
      factory: $ShereheDetailsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'ticket-flow',
          factory: $TicketFlowRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'qr-code-scanner',
          factory: $QrCodeScannerRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'event-tickets',
          factory: $EventTicketsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'organizer-dashboard',
          factory: $OrganizerDashboardRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'all-attendees',
              factory: $AllAttendeesRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'all-scanners',
              factory: $AllScannersRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'add-event-scanner',
              factory: $AddEventScannerRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'create',
      factory: $CreateEventRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'sherehe-select-institutions',
          factory: $ShereheSelectInstitutionsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'edit-added-ticket',
          factory: $EditAddedTicketRoute._fromState,
        ),
      ],
    ),
  ],
);

mixin $ShereheRoute on GoRouteData {
  static ShereheRoute _fromState(GoRouterState state) => ShereheRoute();

  @override
  String get location => GoRouteData.$location('/sherehe');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ShereheDetailsRoute on GoRouteData {
  static ShereheDetailsRoute _fromState(GoRouterState state) =>
      ShereheDetailsRoute(eventId: state.pathParameters['eventId']!);

  ShereheDetailsRoute get _self => this as ShereheDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TicketFlowRoute on GoRouteData {
  static TicketFlowRoute _fromState(GoRouterState state) => TicketFlowRoute(
    eventId: state.pathParameters['eventId']!,
    userId: state.uri.queryParameters['user-id']!,
  );

  TicketFlowRoute get _self => this as TicketFlowRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/ticket-flow',
    queryParams: {'user-id': _self.userId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $QrCodeScannerRoute on GoRouteData {
  static QrCodeScannerRoute _fromState(GoRouterState state) =>
      QrCodeScannerRoute(eventId: state.pathParameters['eventId']!);

  QrCodeScannerRoute get _self => this as QrCodeScannerRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/qr-code-scanner',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EventTicketsRoute on GoRouteData {
  static EventTicketsRoute _fromState(GoRouterState state) =>
      EventTicketsRoute(eventId: state.pathParameters['eventId']!);

  EventTicketsRoute get _self => this as EventTicketsRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/event-tickets',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrganizerDashboardRoute on GoRouteData {
  static OrganizerDashboardRoute _fromState(GoRouterState state) =>
      OrganizerDashboardRoute(eventId: state.pathParameters['eventId']!);

  OrganizerDashboardRoute get _self => this as OrganizerDashboardRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/organizer-dashboard',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AllAttendeesRoute on GoRouteData {
  static AllAttendeesRoute _fromState(GoRouterState state) =>
      AllAttendeesRoute(eventId: state.pathParameters['eventId']!);

  AllAttendeesRoute get _self => this as AllAttendeesRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/organizer-dashboard/all-attendees',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AllScannersRoute on GoRouteData {
  static AllScannersRoute _fromState(GoRouterState state) =>
      AllScannersRoute(eventId: state.pathParameters['eventId']!);

  AllScannersRoute get _self => this as AllScannersRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/organizer-dashboard/all-scanners',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AddEventScannerRoute on GoRouteData {
  static AddEventScannerRoute _fromState(GoRouterState state) =>
      AddEventScannerRoute(eventId: state.pathParameters['eventId']!);

  AddEventScannerRoute get _self => this as AddEventScannerRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/organizer-dashboard/add-event-scanner',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateEventRoute on GoRouteData {
  static CreateEventRoute _fromState(GoRouterState state) => CreateEventRoute();

  @override
  String get location => GoRouteData.$location('/sherehe/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ShereheSelectInstitutionsRoute on GoRouteData {
  static ShereheSelectInstitutionsRoute _fromState(GoRouterState state) =>
      ShereheSelectInstitutionsRoute();

  @override
  String get location =>
      GoRouteData.$location('/sherehe/create/sherehe-select-institutions');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditAddedTicketRoute on GoRouteData {
  static EditAddedTicketRoute _fromState(GoRouterState state) =>
      EditAddedTicketRoute();

  @override
  String get location =>
      GoRouteData.$location('/sherehe/create/edit-added-ticket');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $purchasedTicketsRoute => GoRouteData.$route(
  path: '/purchased-tickets/all',
  factory: $PurchasedTicketsRoute._fromState,
);

mixin $PurchasedTicketsRoute on GoRouteData {
  static PurchasedTicketsRoute _fromState(GoRouterState state) =>
      PurchasedTicketsRoute();

  @override
  String get location => GoRouteData.$location('/purchased-tickets/all');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $organizedEventsRoute => GoRouteData.$route(
  path: '/organized-events/mine',
  factory: $OrganizedEventsRoute._fromState,
);

mixin $OrganizedEventsRoute on GoRouteData {
  static OrganizedEventsRoute _fromState(GoRouterState state) =>
      OrganizedEventsRoute();

  @override
  String get location => GoRouteData.$location('/organized-events/mine');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $ticketReceiptRoute => GoRouteData.$route(
  path: '/ticket-receipt',
  factory: $TicketReceiptRoute._fromState,
);

mixin $TicketReceiptRoute on GoRouteData {
  static TicketReceiptRoute _fromState(GoRouterState state) =>
      TicketReceiptRoute(
        ticketPrice: int.parse(state.uri.queryParameters['ticket-price']!),
        quantity: int.parse(state.uri.queryParameters['quantity']!),
      );

  TicketReceiptRoute get _self => this as TicketReceiptRoute;

  @override
  String get location => GoRouteData.$location(
    '/ticket-receipt',
    queryParams: {
      'ticket-price': _self.ticketPrice.toString(),
      'quantity': _self.quantity.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qrCodeRoute => GoRouteData.$route(
  path: '/qr-code/:eventId/:attendeeId',
  factory: $QrCodeRoute._fromState,
);

mixin $QrCodeRoute on GoRouteData {
  static QrCodeRoute _fromState(GoRouterState state) => QrCodeRoute(
    eventId: state.pathParameters['eventId']!,
    attendeeId: state.pathParameters['attendeeId']!,
    ticketName: state.uri.queryParameters['ticket-name']!,
    quantity: int.parse(state.uri.queryParameters['quantity']!),
  );

  QrCodeRoute get _self => this as QrCodeRoute;

  @override
  String get location => GoRouteData.$location(
    '/qr-code/${Uri.encodeComponent(_self.eventId)}/${Uri.encodeComponent(_self.attendeeId)}',
    queryParams: {
      'ticket-name': _self.ticketName,
      'quantity': _self.quantity.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $todosRoute =>
    GoRouteData.$route(path: '/todos', factory: $TodosRoute._fromState);

mixin $TodosRoute on GoRouteData {
  static TodosRoute _fromState(GoRouterState state) => TodosRoute();

  @override
  String get location => GoRouteData.$location('/todos');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $communitiesRoute => GoRouteData.$route(
  path: '/communities/:communityId',
  factory: $CommunitiesRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'info', factory: $CommunityInfoRoute._fromState),
    GoRouteData.$route(
      path: 'members/:role',
      factory: $CommunityMembersRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'edit',
      factory: $EditCommunityInfoRoute._fromState,
    ),
  ],
);

mixin $CommunitiesRoute on GoRouteData {
  static CommunitiesRoute _fromState(GoRouterState state) => CommunitiesRoute(
    communityId: int.parse(state.pathParameters['communityId']!),
  );

  CommunitiesRoute get _self => this as CommunitiesRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CommunityInfoRoute on GoRouteData {
  static CommunityInfoRoute _fromState(GoRouterState state) =>
      CommunityInfoRoute(
        communityId: int.parse(state.pathParameters['communityId']!),
      );

  CommunityInfoRoute get _self => this as CommunityInfoRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId.toString())}/info',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CommunityMembersRoute on GoRouteData {
  static CommunityMembersRoute _fromState(GoRouterState state) =>
      CommunityMembersRoute(
        communityId: int.parse(state.pathParameters['communityId']!),
        role: state.pathParameters['role']!,
      );

  CommunityMembersRoute get _self => this as CommunityMembersRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId.toString())}/members/${Uri.encodeComponent(_self.role)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditCommunityInfoRoute on GoRouteData {
  static EditCommunityInfoRoute _fromState(GoRouterState state) =>
      EditCommunityInfoRoute(
        communityId: int.parse(state.pathParameters['communityId']!),
      );

  EditCommunityInfoRoute get _self => this as EditCommunityInfoRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId.toString())}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createCommunitiesRoute => GoRouteData.$route(
  path: '/create-community',
  factory: $CreateCommunitiesRoute._fromState,
);

mixin $CreateCommunitiesRoute on GoRouteData {
  static CreateCommunitiesRoute _fromState(GoRouterState state) =>
      CreateCommunitiesRoute();

  @override
  String get location => GoRouteData.$location('/create-community');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $trimVideoRoute => GoRouteData.$route(
  path: '/video-trimer/:videoPath',
  factory: $TrimVideoRoute._fromState,
);

mixin $TrimVideoRoute on GoRouteData {
  static TrimVideoRoute _fromState(GoRouterState state) =>
      TrimVideoRoute(videoPath: state.pathParameters['videoPath']!);

  TrimVideoRoute get _self => this as TrimVideoRoute;

  @override
  String get location => GoRouteData.$location(
    '/video-trimer/${Uri.encodeComponent(_self.videoPath)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $communityMembershipsRoute => GoRouteData.$route(
  path: '/community/memberships/mine',
  factory: $CommunityMembershipsRoute._fromState,
);

mixin $CommunityMembershipsRoute on GoRouteData {
  static CommunityMembershipsRoute _fromState(GoRouterState state) =>
      CommunityMembershipsRoute();

  @override
  String get location => GoRouteData.$location('/community/memberships/mine');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $achievementsHomePageRoute => GoRouteData.$route(
  path: '/achievements',
  factory: $AchievementsHomePageRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':id',
      factory: $AchievementDetailPageRoute._fromState,
    ),
  ],
);

mixin $AchievementsHomePageRoute on GoRouteData {
  static AchievementsHomePageRoute _fromState(GoRouterState state) =>
      AchievementsHomePageRoute();

  @override
  String get location => GoRouteData.$location('/achievements');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AchievementDetailPageRoute on GoRouteData {
  static AchievementDetailPageRoute _fromState(GoRouterState state) =>
      AchievementDetailPageRoute(id: state.pathParameters['id']!);

  AchievementDetailPageRoute get _self => this as AchievementDetailPageRoute;

  @override
  String get location =>
      GoRouteData.$location('/achievements/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $activitiesPageRoute => GoRouteData.$route(
  path: '/activities/:id',
  factory: $ActivitiesPageRoute._fromState,
);

mixin $ActivitiesPageRoute on GoRouteData {
  static ActivitiesPageRoute _fromState(GoRouterState state) =>
      ActivitiesPageRoute(id: state.pathParameters['id']!);

  ActivitiesPageRoute get _self => this as ActivitiesPageRoute;

  @override
  String get location =>
      GoRouteData.$location('/activities/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $examTimetableRoute => GoRouteData.$route(
  path: '/exam-timetable/:institutionId',
  factory: $ExamTimetableRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'search',
      factory: $ExamTimetableSearchRoute._fromState,
    ),
  ],
);

mixin $ExamTimetableRoute on GoRouteData {
  static ExamTimetableRoute _fromState(GoRouterState state) =>
      ExamTimetableRoute(institutionId: state.pathParameters['institutionId']!);

  ExamTimetableRoute get _self => this as ExamTimetableRoute;

  @override
  String get location => GoRouteData.$location(
    '/exam-timetable/${Uri.encodeComponent(_self.institutionId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ExamTimetableSearchRoute on GoRouteData {
  static ExamTimetableSearchRoute _fromState(GoRouterState state) =>
      ExamTimetableSearchRoute(
        institutionId: state.pathParameters['institutionId']!,
      );

  ExamTimetableSearchRoute get _self => this as ExamTimetableSearchRoute;

  @override
  String get location => GoRouteData.$location(
    '/exam-timetable/${Uri.encodeComponent(_self.institutionId)}/search',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsPageRoute => GoRouteData.$route(
  path: '/settings',
  factory: $SettingsPageRoute._fromState,
);

mixin $SettingsPageRoute on GoRouteData {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      SettingsPageRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $institutionShellRouteData => ShellRouteData.$route(
  factory: $InstitutionShellRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/institution/:institutionID',
      factory: $InstitutionHomePageRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'keys',
          factory: $InstitutionKeysViewRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'fees',
          factory: $InstitutionFeesTransactionRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'profile/:profileId',
          factory: $EditStudentProfileRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $InstitutionShellRouteDataExtension on InstitutionShellRouteData {
  static InstitutionShellRouteData _fromState(GoRouterState state) =>
      const InstitutionShellRouteData();
}

mixin $InstitutionHomePageRoute on GoRouteData {
  static InstitutionHomePageRoute _fromState(GoRouterState state) =>
      InstitutionHomePageRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  InstitutionHomePageRoute get _self => this as InstitutionHomePageRoute;

  @override
  String get location => GoRouteData.$location(
    '/institution/${Uri.encodeComponent(_self.institutionID.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InstitutionKeysViewRoute on GoRouteData {
  static InstitutionKeysViewRoute _fromState(GoRouterState state) =>
      InstitutionKeysViewRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  InstitutionKeysViewRoute get _self => this as InstitutionKeysViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/institution/${Uri.encodeComponent(_self.institutionID.toString())}/keys',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InstitutionFeesTransactionRoute on GoRouteData {
  static InstitutionFeesTransactionRoute _fromState(GoRouterState state) =>
      InstitutionFeesTransactionRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  InstitutionFeesTransactionRoute get _self =>
      this as InstitutionFeesTransactionRoute;

  @override
  String get location => GoRouteData.$location(
    '/institution/${Uri.encodeComponent(_self.institutionID.toString())}/fees',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditStudentProfileRoute on GoRouteData {
  static EditStudentProfileRoute _fromState(GoRouterState state) =>
      EditStudentProfileRoute(
        profileId: int.parse(state.pathParameters['profileId']!),
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  EditStudentProfileRoute get _self => this as EditStudentProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/institution/${Uri.encodeComponent(_self.institutionID.toString())}/profile/${Uri.encodeComponent(_self.profileId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $semestersPageRoute => GoRouteData.$route(
  path: '/semesters',
  factory: $SemestersPageRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'add', factory: $AddSemesterRoute._fromState),
    GoRouteData.$route(
      path: 'edit/:id',
      factory: $EditSemesterRoute._fromState,
    ),
  ],
);

mixin $SemestersPageRoute on GoRouteData {
  static SemestersPageRoute _fromState(GoRouterState state) =>
      SemestersPageRoute();

  @override
  String get location => GoRouteData.$location('/semesters');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AddSemesterRoute on GoRouteData {
  static AddSemesterRoute _fromState(GoRouterState state) => AddSemesterRoute();

  @override
  String get location => GoRouteData.$location('/semesters/add');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditSemesterRoute on GoRouteData {
  static EditSemesterRoute _fromState(GoRouterState state) =>
      EditSemesterRoute(id: int.parse(state.pathParameters['id']!));

  EditSemesterRoute get _self => this as EditSemesterRoute;

  @override
  String get location => GoRouteData.$location(
    '/semesters/edit/${Uri.encodeComponent(_self.id.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $coursesPageRoute => GoRouteData.$route(
  path: '/courses',
  factory: $CoursesPageRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'create', factory: $AddCoursesRoute._fromState),
    GoRouteData.$route(
      path: 'view/:courseId',
      factory: $ViewCourseRoute._fromState,
    ),
  ],
);

mixin $CoursesPageRoute on GoRouteData {
  static CoursesPageRoute _fromState(GoRouterState state) => CoursesPageRoute();

  @override
  String get location => GoRouteData.$location('/courses');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AddCoursesRoute on GoRouteData {
  static AddCoursesRoute _fromState(GoRouterState state) => AddCoursesRoute();

  @override
  String get location => GoRouteData.$location('/courses/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ViewCourseRoute on GoRouteData {
  static ViewCourseRoute _fromState(GoRouterState state) =>
      ViewCourseRoute(courseId: state.pathParameters['courseId']!);

  ViewCourseRoute get _self => this as ViewCourseRoute;

  @override
  String get location => GoRouteData.$location(
    '/courses/view/${Uri.encodeComponent(_self.courseId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
