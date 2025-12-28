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
  $authRoute,
  $profileRoute,
  $completeProfileRoute,
  $shereheRoute,
  $purchasedTicketsRoute,
  $ticketReceiptRoute,
  $qrCodeRoute,
  $todosRoute,
  $magnetRoute,
  $communitiesRoute,
  $createCommunitiesRoute,
  $trimVideoRoute,
  $communityMembershipsRoute,
  $achievementsHomePageRoute,
  $activitiesPageRoute,
  $examTimetableRoute,
  $settingsPageRoute,
];

RouteBase get $layoutShellRoute => StatefulShellRouteData.$route(
  factory: $LayoutShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [GoRouteData.$route(path: '/', factory: _$HomeRoute._fromState)],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/calendar',
          factory: _$CalendarRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'create',
              factory: _$CreateAgendaEventRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'item/:id',
              factory: _$AgendaItemViewRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/essentials',
          factory: _$EssentialsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $LayoutShellRouteExtension on LayoutShellRoute {
  static LayoutShellRoute _fromState(GoRouterState state) =>
      const LayoutShellRoute();
}

mixin _$HomeRoute on GoRouteData {
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

mixin _$CalendarRoute on GoRouteData {
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

mixin _$CreateAgendaEventRoute on GoRouteData {
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

mixin _$AgendaItemViewRoute on GoRouteData {
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

mixin _$EssentialsRoute on GoRouteData {
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
    GoRouteData.$route(path: '/feed', factory: _$FeedRoute._fromState);

mixin _$FeedRoute on GoRouteData {
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
  factory: _$PostDetailRoute._fromState,
);

mixin _$PostDetailRoute on GoRouteData {
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
    GoRouteData.$route(path: '/add-post', factory: _$AddPostRoute._fromState);

mixin _$AddPostRoute on GoRouteData {
  static AddPostRoute _fromState(GoRouterState state) => AddPostRoute();

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

RouteBase get $authRoute =>
    GoRouteData.$route(path: '/auth', factory: _$AuthRoute._fromState);

mixin _$AuthRoute on GoRouteData {
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

RouteBase get $profileRoute =>
    GoRouteData.$route(path: '/profile', factory: _$ProfileRoute._fromState);

mixin _$ProfileRoute on GoRouteData {
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

RouteBase get $completeProfileRoute => GoRouteData.$route(
  path: '/complete-profile',
  factory: _$CompleteProfileRoute._fromState,
);

mixin _$CompleteProfileRoute on GoRouteData {
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
  factory: _$ShereheRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'get-event/:eventId',
      factory: _$ShereheDetailsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'ticket-flow',
          factory: _$TicketFlowRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'qr-code-scanner',
          factory: _$QrCodeScannerRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'event-tickets',
          factory: _$EventTicketsRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'create', factory: _$CreateEventRoute._fromState),
  ],
);

mixin _$ShereheRoute on GoRouteData {
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

mixin _$ShereheDetailsRoute on GoRouteData {
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

mixin _$TicketFlowRoute on GoRouteData {
  static TicketFlowRoute _fromState(GoRouterState state) =>
      TicketFlowRoute(eventId: state.pathParameters['eventId']!);

  TicketFlowRoute get _self => this as TicketFlowRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event/${Uri.encodeComponent(_self.eventId)}/ticket-flow',
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

mixin _$QrCodeScannerRoute on GoRouteData {
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

mixin _$EventTicketsRoute on GoRouteData {
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

mixin _$CreateEventRoute on GoRouteData {
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

RouteBase get $purchasedTicketsRoute => GoRouteData.$route(
  path: '/purchased-tickets/all',
  factory: _$PurchasedTicketsRoute._fromState,
);

mixin _$PurchasedTicketsRoute on GoRouteData {
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

RouteBase get $ticketReceiptRoute => GoRouteData.$route(
  path: '/ticket-receipt',
  factory: _$TicketReceiptRoute._fromState,
);

mixin _$TicketReceiptRoute on GoRouteData {
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
  path: '/qr-code/:eventId/:ticketId',
  factory: _$QrCodeRoute._fromState,
);

mixin _$QrCodeRoute on GoRouteData {
  static QrCodeRoute _fromState(GoRouterState state) => QrCodeRoute(
    eventId: state.pathParameters['eventId']!,
    ticketId: state.pathParameters['ticketId']!,
    ticketName: state.uri.queryParameters['ticket-name']!,
    quantity: int.parse(state.uri.queryParameters['quantity']!),
  );

  QrCodeRoute get _self => this as QrCodeRoute;

  @override
  String get location => GoRouteData.$location(
    '/qr-code/${Uri.encodeComponent(_self.eventId)}/${Uri.encodeComponent(_self.ticketId)}',
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
    GoRouteData.$route(path: '/todos', factory: _$TodosRoute._fromState);

mixin _$TodosRoute on GoRouteData {
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

RouteBase get $magnetRoute => GoRouteData.$route(
  path: '/magnet',
  factory: _$MagnetRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'auth/:institutionID',
      factory: _$MagnetAuthRoute._fromState,
    ),
    GoRouteData.$route(
      path: ':institutionID',
      factory: _$MagnetHomeRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'profile',
          factory: _$MagnetProfileRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'courses',
          factory: _$MagnetCoursesRoute._fromState,
        ),
        GoRouteData.$route(path: 'fees', factory: _$MagnetFeesRoute._fromState),
      ],
    ),
  ],
);

mixin _$MagnetRoute on GoRouteData {
  static MagnetRoute _fromState(GoRouterState state) => MagnetRoute();

  @override
  String get location => GoRouteData.$location('/magnet');

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

mixin _$MagnetAuthRoute on GoRouteData {
  static MagnetAuthRoute _fromState(GoRouterState state) => MagnetAuthRoute(
    institutionID: int.parse(state.pathParameters['institutionID']!),
  );

  MagnetAuthRoute get _self => this as MagnetAuthRoute;

  @override
  String get location => GoRouteData.$location(
    '/magnet/auth/${Uri.encodeComponent(_self.institutionID.toString())}',
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

mixin _$MagnetHomeRoute on GoRouteData {
  static MagnetHomeRoute _fromState(GoRouterState state) => MagnetHomeRoute(
    institutionID: int.parse(state.pathParameters['institutionID']!),
  );

  MagnetHomeRoute get _self => this as MagnetHomeRoute;

  @override
  String get location => GoRouteData.$location(
    '/magnet/${Uri.encodeComponent(_self.institutionID.toString())}',
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

mixin _$MagnetProfileRoute on GoRouteData {
  static MagnetProfileRoute _fromState(GoRouterState state) =>
      MagnetProfileRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  MagnetProfileRoute get _self => this as MagnetProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/magnet/${Uri.encodeComponent(_self.institutionID.toString())}/profile',
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

mixin _$MagnetCoursesRoute on GoRouteData {
  static MagnetCoursesRoute _fromState(GoRouterState state) =>
      MagnetCoursesRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!),
      );

  MagnetCoursesRoute get _self => this as MagnetCoursesRoute;

  @override
  String get location => GoRouteData.$location(
    '/magnet/${Uri.encodeComponent(_self.institutionID.toString())}/courses',
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

mixin _$MagnetFeesRoute on GoRouteData {
  static MagnetFeesRoute _fromState(GoRouterState state) => MagnetFeesRoute(
    institutionID: int.parse(state.pathParameters['institutionID']!),
  );

  MagnetFeesRoute get _self => this as MagnetFeesRoute;

  @override
  String get location => GoRouteData.$location(
    '/magnet/${Uri.encodeComponent(_self.institutionID.toString())}/fees',
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

RouteBase get $communitiesRoute => GoRouteData.$route(
  path: '/communities/:communityId',
  factory: _$CommunitiesRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'info', factory: _$CommunityInfoRoute._fromState),
    GoRouteData.$route(
      path: 'members/:role',
      factory: _$CommunityMembersRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'edit',
      factory: _$EditCommunityInfoRoute._fromState,
    ),
  ],
);

mixin _$CommunitiesRoute on GoRouteData {
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

mixin _$CommunityInfoRoute on GoRouteData {
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

mixin _$CommunityMembersRoute on GoRouteData {
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

mixin _$EditCommunityInfoRoute on GoRouteData {
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
  factory: _$CreateCommunitiesRoute._fromState,
);

mixin _$CreateCommunitiesRoute on GoRouteData {
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
  factory: _$TrimVideoRoute._fromState,
);

mixin _$TrimVideoRoute on GoRouteData {
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
  factory: _$CommunityMembershipsRoute._fromState,
);

mixin _$CommunityMembershipsRoute on GoRouteData {
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
  factory: _$AchievementsHomePageRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':id',
      factory: _$AchievementDetailPageRoute._fromState,
    ),
  ],
);

mixin _$AchievementsHomePageRoute on GoRouteData {
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

mixin _$AchievementDetailPageRoute on GoRouteData {
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
  factory: _$ActivitiesPageRoute._fromState,
);

mixin _$ActivitiesPageRoute on GoRouteData {
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
  factory: _$ExamTimetableRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'search',
      factory: _$ExamTimetableSearchRoute._fromState,
    ),
  ],
);

mixin _$ExamTimetableRoute on GoRouteData {
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

mixin _$ExamTimetableSearchRoute on GoRouteData {
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
  factory: _$SettingsPageRoute._fromState,
);

mixin _$SettingsPageRoute on GoRouteData {
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
