import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// A custom [NavigatorObserver] that logs navigation events (push and pop).
///
/// This class listens to route changes in the navigation stack and logs relevant
/// information such as route names, arguments, and previous route details.
///

class AppNavigationObserver extends NavigatorObserver {
  final Logger _logger = Logger();

  /// Called when a new route is pushed onto the navigation stack.
  ///
  /// Logs details about the pushed route, including its name, arguments, and
  /// the previous route (if any).
  ///
  /// - [route]: The new route being pushed onto the stack.
  /// - [previousRoute]: The route that was active before the new route was pushed.
  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.i({
      "trace": "did push route",
      "route": route.settings.name,
      "arguments": route.settings.arguments,
      "previous": previousRoute?.settings.name ?? "no previous route",
      "previous_arguments": previousRoute?.settings.arguments,
    });
    super.didPush(route, previousRoute);
  }

  /// Called when a route is popped from the navigation stack.
  ///
  /// Logs details about the popped route, including its name, arguments, and
  /// the previous route (if any).
  ///
  /// - [route]: The route being popped off the stack.
  /// - [previousRoute]: The route that becomes active after the current route is popped.
  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.i({
      "trace": "did pop route",
      "route": route.settings.name,
      "arguments": route.settings.arguments,
      "previous": previousRoute?.settings.name ?? "no previous route",
      "previous_arguments": previousRoute?.settings.arguments,
    });
    super.didPop(route, previousRoute);
  }
}
