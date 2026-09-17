import 'dart:async';

import 'package:flutter/material.dart';

import 'analytics_event.dart';
import 'analytics_tracker.dart';

class AnalyticsRouteObserver extends NavigatorObserver {
  AnalyticsRouteObserver(this._analyticsTracker);

  final AnalyticsTracker _analyticsTracker;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _record(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _record(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _record(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _record(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (name == null || name.isEmpty) {
      return;
    }

    unawaited(_analyticsTracker.track(AnalyticsEvent.screenViewed(name)));
  }
}
