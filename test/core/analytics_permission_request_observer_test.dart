import 'package:academia/core/permissions/analytics_permission_request_observer.dart';
import 'package:analytics/analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permissions/permissions.dart';

class _RecordingAnalyticsGateway implements AnalyticsGateway {
  String? eventName;
  Map<String, Object>? properties;

  @override
  Future<void> capture(String name, Map<String, Object> eventProperties) async {
    eventName = name;
    properties = eventProperties;
  }

  @override
  Future<void> identify(String id, Map<String, Object> properties) async {}

  @override
  Future<void> reset() async {}
}

void main() {
  test(
    'maps a permission request to the versioned analytics taxonomy',
    () async {
      final gateway = _RecordingAnalyticsGateway();
      final observer = AnalyticsPermissionRequestObserver(
        AnalyticsTracker(gateway),
      );

      observer.onPermissionRequested(
        PermissionCapability.notifications,
        PermissionStatus.granted,
      );
      await Future<void>.delayed(Duration.zero);

      expect(gateway.eventName, 'permission_requested');
      expect(gateway.properties, {
        'analytics_schema_version': 1,
        'event_owner': 'platform',
        'permission_capability': 'notifications',
        'permission_outcome': 'granted',
      });
    },
  );
}
