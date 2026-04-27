import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// An abstract definition for navigation middleware.
///
/// The [RouteGuard] is used by the [AppRouter] to intercept navigation
/// requests before they resolve to a screen. This is ideal for handling
/// cross-cutting concerns like Authentication, Onboarding, and Subscription checks.
///
/// Implementations should focus on a single responsibility.
abstract class RouteGuard {
  const RouteGuard();

  /// Evaluates the current application state against the navigation request.
  ///
  /// Parameters:
  /// * [context]: The BuildContext, useful for accessing Blocs/Providers.
  /// * [state]: The current [GoRouterState], containing the location and parameters.
  ///
  /// Returns:
  /// * `FutureOr<String?>`: A String representing the redirect path (e.g., '/login').
  /// * Returns `null` if the guard passes and the user is allowed to proceed.
  ///
  /// Example:
  /// ```dart
  /// if (notLoggedIn) return '/login';
  /// return null;
  /// ```
  FutureOr<String?> check(BuildContext context, GoRouterState state);
}
