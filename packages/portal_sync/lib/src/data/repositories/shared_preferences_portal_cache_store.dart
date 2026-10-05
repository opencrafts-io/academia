import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/portal_analysis_plan.dart';
import '../../domain/repositories/portal_sync_repositories.dart';

class SharedPreferencesPortalCacheStore implements PortalCacheStore {
  SharedPreferencesPortalCacheStore(this.preferences);

  final SharedPreferences preferences;
  static const int _schemaVersion = PortalAnalysisPlan.schemaVersion;
  static const String _prefix = 'portal_sync_plan_v1_';

  String _key({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
  }) {
    final accountHash = sha256.convert(utf8.encode(accountId));
    final scope = jsonEncode([
      origin,
      language,
      fingerprint,
      modelVersion,
      PortalAnalysisPlan.promptVersion,
      _schemaVersion,
    ]);
    return '$_prefix${accountHash}_${sha256.convert(utf8.encode(scope))}';
  }

  @override
  Future<PortalAnalysisPlan?> getPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
  }) async {
    final key = _key(
      accountId: accountId,
      origin: origin,
      language: language,
      fingerprint: fingerprint,
      modelVersion: modelVersion,
    );
    final encoded = preferences.getString(key);
    if (encoded == null || encoded.length > 16 * 1024) return null;
    try {
      final value = jsonDecode(encoded);
      return value is Map ? PortalAnalysisPlan.fromJson(value) : null;
    } on FormatException {
      await preferences.remove(key);
      return null;
    }
  }

  @override
  Future<void> putPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
    required PortalAnalysisPlan plan,
  }) async {
    final encoded = jsonEncode(plan.toJson());
    if (encoded.length > 16 * 1024) {
      throw const FormatException('Portal plan exceeds the cache limit.');
    }
    await preferences.setString(
      _key(
        accountId: accountId,
        origin: origin,
        language: language,
        fingerprint: fingerprint,
        modelVersion: modelVersion,
      ),
      encoded,
    );
  }

  @override
  Future<void> clearAccount(String accountId) async {
    final accountPrefix = '$_prefix${sha256.convert(utf8.encode(accountId))}_';
    for (final key in preferences.getKeys().where(
      (key) => key.startsWith(accountPrefix),
    )) {
      await preferences.remove(key);
    }
  }
}
