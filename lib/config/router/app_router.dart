import 'package:academia/config/config.dart';
import 'package:academia/config/router/app_navigation_observer.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
//

class AppRouter {
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    routes: $appRoutes,
    observers: [
      if (sl<FlavorConfig>().isProduction) PosthogObserver(),
      AppNavigationObserver(),
      DioRequestInspector.navigatorObserver,
    ],
    navigatorKey: globalNavigatorKey,
    redirect: (context, state) async {
      final authState = BlocProvider.of<AuthBloc>(context).state;
      final profileState = BlocProvider.of<ProfileBloc>(context).state;

      // If currently on auth route and authenticated, check profile state
      if (state.matchedLocation == AuthRoute().location &&
          authState is AuthAuthenticated) {
        if (profileState is ProfileLoadedState) {
          final profile = profileState.profile;

          // Check if account is marked for deletion
          if (profile.deletedAt != null) {
            final expiryDate = profile.deletedAt!.add(Duration(days: 14));
            final now = DateTime.now();

            if (now.isBefore(expiryDate)) {
              // Account can be recovered - go to complete profile
              return CompleteProfileRoute().location;
            } else {
              // Account deletion expired - force logout
              context.read<AuthBloc>().add(AuthSignOutEvent());
              return AuthRoute().location;
            }
          }

          // Normal flow
          if (profile.onboarded && profile.termsAccepted) {
            return HomeRoute().location;
          } else {
            return CompleteProfileRoute().location;
          }
        }
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
