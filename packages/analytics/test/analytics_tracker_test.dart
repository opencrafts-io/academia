import 'package:analytics/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingAnalyticsGateway implements AnalyticsGateway {
  final capturedEvents = <({String name, Map<String, Object> properties})>[];
  final identifiedUsers = <({String id, Map<String, Object> properties})>[];
  var resetCount = 0;

  @override
  Future<void> capture(String name, Map<String, Object> properties) async {
    capturedEvents.add((name: name, properties: properties));
  }

  @override
  Future<void> identify(String id, Map<String, Object> properties) async {
    identifiedUsers.add((id: id, properties: properties));
  }

  @override
  Future<void> reset() async {
    resetCount++;
  }
}

void main() {
  test('sends a versioned, owned product event', () async {
    final gateway = _RecordingAnalyticsGateway();
    final tracker = AnalyticsTracker(gateway);

    await tracker.track(
      AnalyticsEvent.signInCompleted(AnalyticsSignInMethod.apple),
    );

    expect(gateway.capturedEvents, hasLength(1));
    expect(gateway.capturedEvents.single.name, 'sign_in_completed');
    expect(gateway.capturedEvents.single.properties, {
      'analytics_schema_version': 1,
      'event_owner': 'acquisition',
      'sign_in_method': 'apple',
    });
  });

  test('identifies a user without contact details', () async {
    final gateway = _RecordingAnalyticsGateway();
    final tracker = AnalyticsTracker(gateway);

    await tracker.identify(
      const AnalyticsIdentity(
        userId: 'account-1',
        hasCompletedOnboarding: true,
      ),
    );

    expect(gateway.identifiedUsers, hasLength(1));
    expect(gateway.identifiedUsers.single.id, 'account-1');
    expect(gateway.identifiedUsers.single.properties, {
      'analytics_schema_version': 1,
      'has_completed_onboarding': true,
    });
  });

  test('resets the analytics identity after sign out', () async {
    final gateway = _RecordingAnalyticsGateway();
    final tracker = AnalyticsTracker(gateway);

    await tracker.reset();

    expect(gateway.resetCount, 1);
  });

  test('records route names without route arguments', () async {
    final gateway = _RecordingAnalyticsGateway();
    final tracker = AnalyticsTracker(gateway);
    final observer = AnalyticsRouteObserver(tracker);
    final route = MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/home'),
      builder: (_) => const SizedBox.shrink(),
    );

    observer.didPush(route, null);
    await Future<void>.delayed(Duration.zero);

    expect(gateway.capturedEvents, hasLength(1));
    expect(gateway.capturedEvents.single.name, 'screen_viewed');
    expect(gateway.capturedEvents.single.properties, {
      'analytics_schema_version': 1,
      'event_owner': 'activation',
      'screen_route': '/home',
    });
  });
}
