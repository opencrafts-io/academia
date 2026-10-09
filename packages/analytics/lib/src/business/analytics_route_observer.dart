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

    unawaited(
      _analyticsTracker.track(
        AnalyticsEvent.screenViewed(
          _stableRouteName(name),
          featurePackage: _featurePackageFor(name),
        ),
      ),
    );
  }

  String _stableRouteName(String route) {
    final path = Uri.tryParse(route)?.path ?? route.split('?').first;
    return path
        .split('/')
        .map((segment) =>
            int.tryParse(segment) != null || _isUuid(segment)
                ? ':id'
                : segment)
        .join('/');
  }

  bool _isUuid(String value) => RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-8][0-9a-fA-F]{3}-[89aAbB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  ).hasMatch(value);

  AnalyticsFeaturePackage? _featurePackageFor(String route) {
    final normalized = route.toLowerCase();
    if (normalized.startsWith('/study-tools') ||
        normalized.startsWith('studytools') ||
        normalized.startsWith('studymaterial') ||
        normalized.startsWith('studypractice') ||
        normalized.startsWith('studypodcast')) {
      return AnalyticsFeaturePackage.studyTools;
    }
    if (normalized.startsWith('/todos') ||
        normalized.startsWith('todos') ||
        normalized.contains('todo') ||
        normalized.contains('tasklist')) {
      return AnalyticsFeaturePackage.todos;
    }
    if (normalized.startsWith('/agenda') ||
        normalized.startsWith('agenda') ||
        normalized.startsWith('/calendar') ||
        normalized.startsWith('calendar')) {
      return AnalyticsFeaturePackage.agenda;
    }
    return null;
  }
}
