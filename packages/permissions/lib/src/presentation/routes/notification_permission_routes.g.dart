// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_permission_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$notificationPermissionRoute];

RouteBase get $notificationPermissionRoute => GoRouteData.$route(
  path: '/notification-allow',
  hasOverriddenOnExit: false,
  factory: $NotificationPermissionRoute._fromState,
);

mixin $NotificationPermissionRoute on GoRouteData {
  static NotificationPermissionRoute _fromState(GoRouterState state) =>
      const NotificationPermissionRoute();

  @override
  String get location => GoRouteData.$location('/notification-allow');

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
