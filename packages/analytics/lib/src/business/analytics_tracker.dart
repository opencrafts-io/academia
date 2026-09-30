import 'analytics_event.dart';
import 'analytics_gateway.dart';

class AnalyticsTracker {
  const AnalyticsTracker(this._gateway);

  final AnalyticsGateway _gateway;

  Future<void> track(AnalyticsEvent event) async {
    try {
      await _gateway.capture(event.name.wireName, event.payload);
    } catch (_) {
      // Analytics delivery must not disrupt the product action that triggered it.
    }
  }

  Future<void> identify(AnalyticsIdentity identity) async {
    try {
      await _gateway.identify(identity.userId, identity.properties);
    } catch (_) {
      // Analytics delivery must not disrupt profile loading or updates.
    }
  }

  Future<void> reset() async {
    try {
      await _gateway.reset();
    } catch (_) {
      // Analytics delivery must not disrupt sign-out.
    }
  }
}
