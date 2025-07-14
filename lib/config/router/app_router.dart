import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/config/router/routes.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: AuthRoute().location,
    routes: $appRoutes,
    observers: [AppNavigationObserver()],
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) {
      // final authState = BlocProvider.of<AuthBloc>(context).state;
      // if (authState is AuthUnauthenticated) {
      //   return AuthRoute().location;
      // }
      return null;
    },
  );
}
