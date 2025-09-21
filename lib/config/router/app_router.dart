import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/config/router/routes.dart';
import 'package:academia/features/features.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    routes: $appRoutes,
    observers: [AppNavigationObserver(), DioRequestInspector.navigatorObserver],
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) async {
      final authState = BlocProvider.of<AuthBloc>(context).state;
      final profileState = BlocProvider.of<ProfileBloc>(context).state;

      // If currently on auth route and authenticated, check profile state
      if (state.matchedLocation == AuthRoute().location &&
          authState is AuthAuthenticated) {
        if (profileState is ProfileLoadedState) {
          if (profileState.profile.onboarded &&
              profileState.profile.termsAccepted) {
            return HomeRoute().location;
          } else {
            return CompleteProfileRoute().location;
          }
        }
        // If profile not loaded yet, stay on auth screen
        return null;
      }

      // If loading, don't redirect
      if (authState is AuthLoading) {
        return null;
      }

      // If unauthenticated and not on auth route, redirect to auth
      if (authState is AuthUnauthenticated &&
          state.matchedLocation != AuthRoute().location) {
        return AuthRoute().location;
      }

      return null;
    },
  );
}
