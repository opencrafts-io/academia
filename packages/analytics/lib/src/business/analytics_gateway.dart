import 'package:posthog_flutter/posthog_flutter.dart';

abstract interface class AnalyticsGateway {
  Future<void> capture(String name, Map<String, Object> properties);

  Future<void> identify(String id, Map<String, Object> properties);

  Future<void> reset();
}

class PosthogAnalyticsGateway implements AnalyticsGateway {
  PosthogAnalyticsGateway({Posthog? posthog}) : _posthog = posthog ?? Posthog();

  final Posthog _posthog;

  @override
  Future<void> capture(String name, Map<String, Object> properties) {
    return _posthog.capture(eventName: name, properties: properties);
  }

  @override
  Future<void> identify(String id, Map<String, Object> properties) {
    return _posthog.identify(userId: id, userProperties: properties);
  }

  @override
  Future<void> reset() => _posthog.reset();
}

class DisabledAnalyticsGateway implements AnalyticsGateway {
  const DisabledAnalyticsGateway();

  @override
  Future<void> capture(String name, Map<String, Object> properties) async {}

  @override
  Future<void> identify(String id, Map<String, Object> properties) async {}

  @override
  Future<void> reset() async {}
}
