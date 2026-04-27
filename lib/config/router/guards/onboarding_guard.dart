import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/config/router/route_guard.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingGuard implements RouteGuard {
  @override
  FutureOr<String?> check(BuildContext context, GoRouterState state) {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadedState) {
      final profile = profileState.profile;
      final onboardingLoc = CompleteProfileRoute().location;
      final isAlreadyOnOnboarding = state.matchedLocation == onboardingLoc;

      if (profile.onboarded && profile.termsAccepted) {
        return null;
      }

      if (!isAlreadyOnOnboarding) {
        return onboardingLoc;
      }
    }

    return null;
  }
}
