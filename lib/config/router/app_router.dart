import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: HomeRoute().location,
    routes: $appRoutes,
    observers: [AppNavigationObserver()],
    navigatorKey: globalNavigatorKey,
  );
}
