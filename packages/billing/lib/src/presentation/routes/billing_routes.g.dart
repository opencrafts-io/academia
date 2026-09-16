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
  static PaywallRoute _fromState(GoRouterState state) => PaywallRoute(
    featureName: state.uri.queryParameters['feature-name'] ?? 'this feature',
    accessMessage: state.uri.queryParameters['access-message'],
  );

  PaywallRoute get _self => this as PaywallRoute;

  @override
  String get location => GoRouteData.$location(
    '/billing',
    queryParams: {
      if (_self.featureName != 'this feature')
        'feature-name': _self.featureName,
      if (_self.accessMessage != null) 'access-message': _self.accessMessage,
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
