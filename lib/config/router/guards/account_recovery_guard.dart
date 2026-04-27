import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/config/router/route_guard.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountRecoveryGuard implements RouteGuard {
  @override
  FutureOr<String?> check(BuildContext context, GoRouterState state) {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadedState) {
      final profile = profileState.profile;

      if (profile.deletedAt == null) return null;

      final recoveryLoc = CompleteProfileRoute().location;
      final isAlreadyOnRecovery = state.matchedLocation == recoveryLoc;

      final expiryDate = profile.deletedAt!.add(const Duration(days: 14));
      final now = DateTime.now();

      if (now.isBefore(expiryDate)) {
        // Window is still open - force redirect to recovery screen
        return isAlreadyOnRecovery ? null : recoveryLoc;
      } else {
        // Window expired - the account is effectively "gone"
        // We return null here and let the AuthGuard or a dedicated
        // listener handle the force-logout side effect.
        return null;
      }
    }

    return null;
  }
}
