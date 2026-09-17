import 'package:analytics/src/feature_flags/feature_flag_reader.dart';
import 'package:injectable/injectable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

abstract interface class PosthogFeatureFlagGateway {
  Future<Object?> readPayload(String key);

  Future<bool> isEnabled(String key);
}

@LazySingleton(as: FeatureFlagReader)
class PosthogFeatureFlagReader implements FeatureFlagReader {
  const PosthogFeatureFlagReader(this._gateway);

  final PosthogFeatureFlagGateway _gateway;

  @override
  Future<Object?> readJson(String key) => _gateway.readPayload(key);

  @override
  Future<bool> isEnabled(String key) => _gateway.isEnabled(key);
}

@LazySingleton(as: PosthogFeatureFlagGateway)
class PosthogFlutterFeatureFlagGateway implements PosthogFeatureFlagGateway {
  PosthogFlutterFeatureFlagGateway() : _posthog = Posthog();

  final Posthog _posthog;

  @override
  Future<Object?> readPayload(String key) async {
    await _posthog.reloadFeatureFlags();
    final result = await _posthog.getFeatureFlagResult(key, sendEvent: false);
    return result?.payload;
  }

  @override
  Future<bool> isEnabled(String key) async {
    await _posthog.reloadFeatureFlags();
    final result = await _posthog.getFeatureFlagResult(key, sendEvent: false);
    return result?.enabled ?? false;
  }
}
