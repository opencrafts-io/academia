// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $mainLayoutShellRoute,
  $feedRoute,
  $chatRoute,
  $postDetailRoute,
  $addPostRoute,
  $authRoute,
  $profileRoute,
  $completeProfileRoute,
  $shereheRoute,
  $todosRoute,
  $magnetRoute,
];

RouteBase get $mainLayoutShellRoute => ShellRouteData.$route(
  navigatorKey: MainLayoutShellRoute.$navigatorKey,
  factory: $MainLayoutShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(path: '/', factory: _$HomeRoute._fromState),
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
    GoRouteData.$route(
      path: '/essentials',

      factory: _$EssentialsRoute._fromState,
    ),
    GoRouteData.$route(path: '/meteor', factory: _$MeteorRoute._fromState),
  ],
);

extension $MainLayoutShellRouteExtension on MainLayoutShellRoute {
  static MainLayoutShellRoute _fromState(GoRouterState state) =>
      const MainLayoutShellRoute();
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

mixin _$MeteorRoute on GoRouteData {
  static MeteorRoute _fromState(GoRouterState state) => MeteorRoute();

  @override
  String get location => GoRouteData.$location('/meteor');

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

RouteBase get $chatRoute => GoRouteData.$route(
  path: '/chat/:conversationId',

  factory: _$ChatRoute._fromState,
);

mixin _$ChatRoute on GoRouteData {
  static ChatRoute _fromState(GoRouterState state) =>
      ChatRoute(conversationId: state.pathParameters['conversationId']!);

  ChatRoute get _self => this as ChatRoute;

  @override
  String get location => GoRouteData.$location(
    '/chat/${Uri.encodeComponent(_self.conversationId)}',
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

RouteBase get $postDetailRoute => GoRouteData.$route(
  path: '/post/:postId',

  factory: _$PostDetailRoute._fromState,
);

mixin _$PostDetailRoute on GoRouteData {
  static PostDetailRoute _fromState(GoRouterState state) =>
      PostDetailRoute(postId: state.pathParameters['postId']!);

  PostDetailRoute get _self => this as PostDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/post/${Uri.encodeComponent(_self.postId)}');

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
      path: 'get-event',

      factory: _$ShereheDetailsRoute._fromState,
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
      ShereheDetailsRoute(eventId: state.uri.queryParameters['event-id']!);

  ShereheDetailsRoute get _self => this as ShereheDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/sherehe/get-event',
    queryParams: {'event-id': _self.eventId},
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
    institutionID: int.parse(state.pathParameters['institutionID']!)!,
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
    institutionID: int.parse(state.pathParameters['institutionID']!)!,
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
        institutionID: int.parse(state.pathParameters['institutionID']!)!,
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
