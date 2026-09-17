import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:permissions/permissions.dart';

class AnalyticsPermissionRequestObserver implements PermissionRequestObserver {
  AnalyticsPermissionRequestObserver(this._analyticsTracker);

  final AnalyticsTracker _analyticsTracker;

  @override
  void onPermissionRequested(
    PermissionCapability capability,
    PermissionStatus status,
  ) {
    unawaited(
      _analyticsTracker.track(
        AnalyticsEvent.permissionRequested(
          capability: switch (capability) {
            PermissionCapability.location =>
              AnalyticsPermissionCapability.location,
            PermissionCapability.notifications =>
              AnalyticsPermissionCapability.notifications,
            PermissionCapability.camera => AnalyticsPermissionCapability.camera,
            PermissionCapability.storage =>
              AnalyticsPermissionCapability.storage,
            PermissionCapability.preciseAlarms =>
              AnalyticsPermissionCapability.preciseAlarms,
          },
          outcome: switch (status) {
            PermissionStatus.granted => AnalyticsPermissionOutcome.granted,
            PermissionStatus.denied => AnalyticsPermissionOutcome.denied,
            PermissionStatus.permanentlyDenied =>
              AnalyticsPermissionOutcome.permanentlyDenied,
          },
        ),
      ),
    );
  }
}
