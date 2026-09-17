import 'package:in_app_update/src/domain/app_update_decision.dart';
import 'package:in_app_update/src/domain/app_update_platform.dart';
import 'package:in_app_update/src/domain/update_campaign.dart';
import 'package:injectable/injectable.dart';
import 'package:pub_semver/pub_semver.dart';

@lazySingleton
class AppUpdatePolicyEvaluator {
  AppUpdatePolicyEvaluator({@ignoreParam Set<String>? trustedStoreHosts})
    : _trustedStoreHosts =
          trustedStoreHosts ?? const {'play.google.com', 'apps.apple.com'};

  final Set<String> _trustedStoreHosts;

  AppUpdateDecision evaluate({
    required Object? rawConfiguration,
    required AppUpdatePlatform platform,
    required Version currentVersion,
    required Uri fallbackStoreUrl,
  }) {
    if (!_isTrustedStoreUrl(fallbackStoreUrl)) return const NoAppUpdate();

    final configuration = _asStringMap(rawConfiguration);
    if (configuration == null) return const NoAppUpdate();

    final campaigns = _parseV2Campaigns(
      configuration: configuration,
      platform: platform,
      fallbackStoreUrl: fallbackStoreUrl,
    );
    final applicable = campaigns
        .where((campaign) => currentVersion < campaign.targetVersion)
        .toList();

    if (applicable.isNotEmpty) {
      applicable.sort(_compareCampaigns);
      return _decisionFor(applicable.first);
    }

    return _parseLegacyDecision(
      configuration: configuration,
      platform: platform,
      currentVersion: currentVersion,
      fallbackStoreUrl: fallbackStoreUrl,
    );
  }

  List<UpdateCampaign> _parseV2Campaigns({
    required Map<String, dynamic> configuration,
    required AppUpdatePlatform platform,
    required Uri fallbackStoreUrl,
  }) {
    if (configuration['schema_version'] != 2) return const [];

    final platforms = _asStringMap(configuration['platforms']);
    final platformConfig = platforms == null
        ? null
        : _asStringMap(platforms[platform.name]);
    if (platformConfig == null) return const [];

    final platformStoreUrl =
        _parseTrustedStoreUrl(platformConfig['store_url']) ?? fallbackStoreUrl;
    final rawCampaigns = platformConfig['campaigns'];
    if (rawCampaigns is! List) return const [];

    return rawCampaigns
        .map(
          (rawCampaign) => _parseV2Campaign(
            rawCampaign: rawCampaign,
            fallbackStoreUrl: platformStoreUrl,
          ),
        )
        .whereType<UpdateCampaign>()
        .toList();
  }

  UpdateCampaign? _parseV2Campaign({
    required Object? rawCampaign,
    required Uri fallbackStoreUrl,
  }) {
    final campaign = _asStringMap(rawCampaign);
    if (campaign == null) return null;

    final id = _validatedText(campaign['id'], maxLength: 128);
    final targetVersion = _parseVersion(campaign['target_version']);
    final mode = _parseMode(campaign['mode']);
    final title = _validatedText(campaign['title'], maxLength: 120);
    final message = _validatedText(campaign['message'], maxLength: 500);
    if (id == null ||
        targetVersion == null ||
        mode == null ||
        title == null ||
        message == null) {
      return null;
    }

    return UpdateCampaign(
      id: id,
      targetVersion: targetVersion,
      mode: mode,
      title: title,
      message: message,
      storeUrl:
          _parseTrustedStoreUrl(campaign['store_url']) ?? fallbackStoreUrl,
    );
  }

  AppUpdateDecision _parseLegacyDecision({
    required Map<String, dynamic> configuration,
    required AppUpdatePlatform platform,
    required Version currentVersion,
    required Uri fallbackStoreUrl,
  }) {
    final platformConfig = _asStringMap(configuration[platform.name]);
    final targetVersion = platformConfig == null
        ? null
        : _parseVersion(platformConfig['min_version']);
    if (targetVersion == null || currentVersion >= targetVersion) {
      return const NoAppUpdate();
    }

    final message =
        _validatedText(configuration['message'], maxLength: 500) ??
        'A new version of the app is available.';
    final campaign = UpdateCampaign(
      id: 'legacy-${platform.name}-$targetVersion',
      targetVersion: targetVersion,
      mode: platformConfig!['is_critical'] == true
          ? AppUpdateMode.required
          : AppUpdateMode.optional,
      title: 'Time for an upgrade',
      message: message,
      storeUrl: fallbackStoreUrl,
    );
    return _decisionFor(campaign);
  }

  AppUpdateDecision _decisionFor(UpdateCampaign campaign) {
    return campaign.mode == AppUpdateMode.required
        ? RequiredAppUpdate(campaign)
        : OptionalAppUpdate(campaign);
  }

  int _compareCampaigns(UpdateCampaign left, UpdateCampaign right) {
    final modeComparison = _modeRank(right.mode)
        .compareTo(_modeRank(left.mode));
    if (modeComparison != 0) return modeComparison;
    return right.targetVersion.compareTo(left.targetVersion);
  }

  int _modeRank(AppUpdateMode mode) {
    return switch (mode) {
      AppUpdateMode.required => 1,
      AppUpdateMode.optional => 0,
    };
  }

  AppUpdateMode? _parseMode(Object? value) {
    return switch (value) {
      'optional' => AppUpdateMode.optional,
      'required' => AppUpdateMode.required,
      _ => null,
    };
  }

  Version? _parseVersion(Object? value) {
    if (value is! String) return null;
    try {
      return Version.parse(value);
    } on FormatException {
      return null;
    }
  }

  String? _validatedText(Object? value, {required int maxLength}) {
    if (value is! String) return null;
    final text = value.trim();
    return text.isEmpty || text.length > maxLength ? null : text;
  }

  Uri? _parseTrustedStoreUrl(Object? value) {
    if (value is! String) return null;
    final uri = Uri.tryParse(value);
    return uri != null && _isTrustedStoreUrl(uri) ? uri : null;
  }

  bool _isTrustedStoreUrl(Uri uri) {
    return uri.scheme == 'https' &&
        uri.host.isNotEmpty &&
        _trustedStoreHosts.contains(uri.host.toLowerCase());
  }

  Map<String, dynamic>? _asStringMap(Object? value) {
    if (value is! Map) return null;
    return Map<String, dynamic>.fromEntries(
      value.entries
          .where((entry) => entry.key is String)
          .map((entry) => MapEntry(entry.key as String, entry.value)),
    );
  }
}
