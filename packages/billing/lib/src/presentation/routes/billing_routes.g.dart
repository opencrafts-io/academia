// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$paywallRoute];

RouteBase get $paywallRoute => GoRouteData.$route(
  path: '/billing',
  hasOverriddenOnExit: false,
  factory: $PaywallRoute._fromState,
);

mixin $PaywallRoute on GoRouteData {
  static PaywallRoute _fromState(GoRouterState state) => const PaywallRoute();

  @override
  String get location => GoRouteData.$location('/billing');

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
