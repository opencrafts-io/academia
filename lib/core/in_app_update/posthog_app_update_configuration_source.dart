import 'package:analytics/analytics.dart';
import 'package:in_app_update/in_app_update.dart';

class PosthogAppUpdateConfigurationSource
    implements AppUpdateConfigurationSource {
  const PosthogAppUpdateConfigurationSource(this._featureFlagReader);

  static const flagKey = 'app-upgrade-config';

  final FeatureFlagReader _featureFlagReader;

  @override
  Future<Object?> load() => _featureFlagReader.readJson(flagKey);
}
