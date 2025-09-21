// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $layoutShellRoute,
  $feedRoute,
  $conversationListRoute,
  $chatRoute,
  $userSelectionRoute,
  $postDetailRoute,
  $addPostRoute,
  $authRoute,
  $profileRoute,
  $completeProfileRoute,
  $shereheRoute,
  $todosRoute,
  $magnetRoute,
  $communitiesRoute,
  $createCommunitiesRoute,
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

RouteBase get $conversationListRoute => GoRouteData.$route(
  path: '/conversations',

  factory: _$ConversationListRoute._fromState,
);

mixin _$ConversationListRoute on GoRouteData {
  static ConversationListRoute _fromState(GoRouterState state) =>
      ConversationListRoute();

  @override
  String get location => GoRouteData.$location('/conversations');

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

RouteBase get $userSelectionRoute => GoRouteData.$route(
  path: '/users/select',

  factory: _$UserSelectionRoute._fromState,
);

mixin _$UserSelectionRoute on GoRouteData {
  static UserSelectionRoute _fromState(GoRouterState state) =>
      UserSelectionRoute();

  @override
  String get location => GoRouteData.$location('/users/select');

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

mixin _$MagnetCoursesRoute on GoRouteData {
  static MagnetCoursesRoute _fromState(GoRouterState state) =>
      MagnetCoursesRoute(
        institutionID: int.parse(state.pathParameters['institutionID']!)!,
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
    institutionID: int.parse(state.pathParameters['institutionID']!)!,
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
    GoRouteData.$route(
      path: 'users',

      factory: _$CommunityUserListRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'add-members',

      factory: _$AddMembersRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'add-community-guidelines',

      factory: _$AddCommunityGuidelinesRoute._fromState,
    ),
  ],
);

mixin _$CommunitiesRoute on GoRouteData {
  static CommunitiesRoute _fromState(GoRouterState state) =>
      CommunitiesRoute(communityId: state.pathParameters['communityId']!);

  CommunitiesRoute get _self => this as CommunitiesRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId)}',
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

mixin _$CommunityUserListRoute on GoRouteData {
  static CommunityUserListRoute _fromState(GoRouterState state) =>
      CommunityUserListRoute(
        communityId: state.pathParameters['communityId']!,
        userId: state.uri.queryParameters['user-id']!,
        title: state.uri.queryParameters['title']!,
        isTargetModerator:
            _$convertMapValue(
              'is-target-moderator',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isTargetBannedUsers:
            _$convertMapValue(
              'is-target-banned-users',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isTargetMember:
            _$convertMapValue(
              'is-target-member',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isCreator:
            _$convertMapValue(
              'is-creator',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isModerator:
            _$convertMapValue(
              'is-moderator',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isMember:
            _$convertMapValue(
              'is-member',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isBanned:
            _$convertMapValue(
              'is-banned',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        isPrivate:
            _$convertMapValue(
              'is-private',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
      );

  CommunityUserListRoute get _self => this as CommunityUserListRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId)}/users',
    queryParams: {
      'user-id': _self.userId,
      'title': _self.title,
      if (_self.isTargetModerator != false)
        'is-target-moderator': _self.isTargetModerator.toString(),
      if (_self.isTargetBannedUsers != false)
        'is-target-banned-users': _self.isTargetBannedUsers.toString(),
      if (_self.isTargetMember != false)
        'is-target-member': _self.isTargetMember.toString(),
      if (_self.isCreator != false) 'is-creator': _self.isCreator.toString(),
      if (_self.isModerator != false)
        'is-moderator': _self.isModerator.toString(),
      if (_self.isMember != false) 'is-member': _self.isMember.toString(),
      if (_self.isBanned != false) 'is-banned': _self.isBanned.toString(),
      if (_self.isPrivate != false) 'is-private': _self.isPrivate.toString(),
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

mixin _$AddMembersRoute on GoRouteData {
  static AddMembersRoute _fromState(GoRouterState state) => AddMembersRoute(
    communityId: state.pathParameters['communityId']!,
    userId: state.uri.queryParameters['user-id']!,
  );

  AddMembersRoute get _self => this as AddMembersRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId)}/add-members',
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

mixin _$AddCommunityGuidelinesRoute on GoRouteData {
  static AddCommunityGuidelinesRoute _fromState(GoRouterState state) =>
      AddCommunityGuidelinesRoute(
        communityId: state.pathParameters['communityId']!,
        userId: state.uri.queryParameters['user-id']!,
      );

  AddCommunityGuidelinesRoute get _self => this as AddCommunityGuidelinesRoute;

  @override
  String get location => GoRouteData.$location(
    '/communities/${Uri.encodeComponent(_self.communityId)}/add-community-guidelines',
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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
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
