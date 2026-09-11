import 'package:academia/config/config.dart';
import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/config/router/route_guard.dart';
import 'package:academia/injection_container.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'guards/guards.dart';
import 'package:billing/billing.dart' as billing;
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
          loadBlockWindow: (appIdentifier, now) => sl<LockInService>()
              .activeWindowFor(appIdentifier, at: now),
          onReturnHome: () => context.go(HomeRoute().location),
        ),
      ),
      ...billing.routes,
    ],
    initialLocation: SplashScreenRoute().location,
    observers: [
      if (sl<FlavorConfig>().isProduction) PosthogObserver(),
      AppNavigationObserver(),
      DioRequestInspector.navigatorObserver,
    ],
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) {
      if (state.uri.path == '/lock-in/blocked') return null;
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
