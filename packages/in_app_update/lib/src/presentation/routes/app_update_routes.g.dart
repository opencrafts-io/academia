// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $appUpdateRequiredRoute,
  $appUpdateOptionalRoute,
];

RouteBase get $appUpdateRequiredRoute => GoRouteData.$route(
  path: '/app-update/required',
  hasOverriddenOnExit: false,
  factory: $AppUpdateRequiredRoute._fromState,
);

mixin $AppUpdateRequiredRoute on GoRouteData {
  static AppUpdateRequiredRoute _fromState(GoRouterState state) =>
      AppUpdateRequiredRoute($extra: state.extra as UpdateCampaign);

  AppUpdateRequiredRoute get _self => this as AppUpdateRequiredRoute;

  @override
  String get location => GoRouteData.$location('/app-update/required');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $appUpdateOptionalRoute => GoRouteData.$route(
  path: '/app-update/optional',
  hasOverriddenOnExit: false,
  factory: $AppUpdateOptionalRoute._fromState,
);

mixin $AppUpdateOptionalRoute on GoRouteData {
  static AppUpdateOptionalRoute _fromState(GoRouterState state) =>
      AppUpdateOptionalRoute($extra: state.extra as UpdateCampaign);

  AppUpdateOptionalRoute get _self => this as AppUpdateOptionalRoute;

  @override
  String get location => GoRouteData.$location('/app-update/optional');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
