import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/config/router/route_guard.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthGuard implements RouteGuard {
  const AuthGuard();
  @override
  FutureOr<String?> check(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthBloc>().state;

    // Define which location represents the "Entry Point"
    final String loginLocation = AuthRoute().location;
    final bool isGoingToAuth = state.matchedLocation == loginLocation;

    // User is NOT authenticated
    if (authState is AuthUnauthenticated || authState is AuthInitial) {
      // If they aren't going to auth already, redirect them there
      return isGoingToAuth ? null : loginLocation;
    }

    // User IS authenticated but trying to go to Login/Register
    if (authState is AuthAuthenticated && isGoingToAuth) {
      // Send them to the "next" logical step (Home or Onboarding)
      // Note: Other guards in the pipeline (like OnboardingGuard)
      // will catch them after this redirect if needed.
      return HomeRoute().location;
    }

    // Auth is loading
    if (authState is AuthLoading) {
      // Stay put; don't redirect while transitioning
      return null;
    }

    return null;
  }
}
