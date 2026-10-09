// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $achievementsHomePageRoute,
  $activitiesPageRoute,
];

RouteBase get $achievementsHomePageRoute => GoRouteData.$route(
  path: '/achievements',
  hasOverriddenOnExit: false,
  factory: $AchievementsHomePageRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':id',
      hasOverriddenOnExit: false,
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
  hasOverriddenOnExit: false,
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
