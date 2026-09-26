// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$settingsPageRoute];

RouteBase get $settingsPageRoute => GoRouteData.$route(
  path: '/settings',
  hasOverriddenOnExit: false,
  factory: $SettingsPageRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'notifications',
      hasOverriddenOnExit: false,
      factory: $NotificationSettingsRoute._fromState,
    ),
  ],
);

mixin $SettingsPageRoute on GoRouteData {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      const SettingsPageRoute();

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

mixin $NotificationSettingsRoute on GoRouteData {
  static NotificationSettingsRoute _fromState(GoRouterState state) =>
      const NotificationSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/notifications');

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
