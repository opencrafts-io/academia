import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/config/router/route_guard.dart';
import 'package:academia/config/router/routes.dart';
import 'package:academia/config/router/package_routes.dart';
import 'package:academia/injection_container.dart';
import 'package:analytics/analytics.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'guards/guards.dart';

import 'package:lock_in/lock_in.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();

  static const List<RouteGuard> _guards = [
    AuthGuard(),
    AccountRecoveryGuard(),
    OnboardingGuard(),
  ];

  static final router = GoRouter(
    routes: [
      ...$appRoutes,
      GoRoute(
        path: '/lock-in/blocked',
        builder: (context, state) => LockInBlockedPage(
          appIdentifier: state.uri.queryParameters['packageName'],
          loadBlockWindow: (appIdentifier, now) =>
              sl<LockInService>().activeWindowFor(appIdentifier, at: now),
          onReturnHome: () => context.go(HomeRoute().location),
        ),
      ),
      ...packageRoutes,
    ],
    initialLocation: SplashScreenRoute().location,
    observers: [
      AppNavigationObserver(),
      AnalyticsRouteObserver(sl<AnalyticsTracker>()),
      DioRequestInspector.navigatorObserver,
    ],
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) {
      if (state.uri.path == '/lock-in/blocked' ||
          state.uri.path.startsWith('/app-update/')) {
        return null;
      }
      for (final guard in _guards) {
        final String? redirectPath = guard.check(context, state);

        if (redirectPath != null) {
          return redirectPath;
        }
      }
      return null;
    },
  );
}
