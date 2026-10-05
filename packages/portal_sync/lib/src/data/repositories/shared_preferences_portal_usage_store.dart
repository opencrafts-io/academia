import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/portal_sync_repositories.dart';

class SharedPreferencesPortalUsageStore implements PortalUsageStore {
  SharedPreferencesPortalUsageStore(
    this.preferences, {
    this.dailyLimit = 4,
    this.monthlyLimit = 30,
    this.initialSetupLimit = 6,
  }) {
    if (dailyLimit < 1 || monthlyLimit < 1 || initialSetupLimit < 1) {
      throw ArgumentError('Usage limits must be positive.');
    }
  }

  final SharedPreferences preferences;
  final int dailyLimit;
  final int monthlyLimit;
  final int initialSetupLimit;
  static const String _prefix = 'portal_sync_usage_v1_';

  String _key(String accountId) =>
      '$_prefix${sha256.convert(utf8.encode(accountId))}';

  Map<String, dynamic> _read(String accountId) {
    final encoded = preferences.getString(_key(accountId));
    if (encoded == null || encoded.length > 4096) return {};
    try {
      final decoded = jsonDecode(encoded);
      return decoded is Map<String, dynamic> ? decoded : {};
    } on FormatException {
      return {};
    }
  }

  @override
  Future<bool> canAttempt(String accountId, {DateTime? now}) async {
    final time = (now ?? DateTime.now()).toUtc();
    final data = _read(accountId);
    final month = _monthKey(time);
    final day = _dayKey(time);
    final months = _counts(data['months']);
    final days = _counts(data['days']);
    if ((months[month] ?? 0) >= monthlyLimit) return false;
    if (data['setupComplete'] != true) {
      return (days[day] ?? 0) < initialSetupLimit;
    }
    return (days[day] ?? 0) < dailyLimit;
  }

  @override
  Future<void> recordAttempt(String accountId, {DateTime? now}) async {
    final time = (now ?? DateTime.now()).toUtc();
    final data = _read(accountId);
    final months = _counts(data['months']);
    final days = _counts(data['days']);
    final month = _monthKey(time);
    final day = _dayKey(time);
    months[month] = (months[month] ?? 0) + 1;
    days[day] = (days[day] ?? 0) + 1;
    final retainedMonths = months.keys.toList()..sort();
    while (retainedMonths.length > 14) {
      months.remove(retainedMonths.removeAt(0));
    }
    final retainedDays = days.keys.toList()..sort();
    while (retainedDays.length > 40) {
      days.remove(retainedDays.removeAt(0));
    }
    data['months'] = months;
    data['days'] = days;
    await preferences.setString(_key(accountId), jsonEncode(data));
  }

  @override
  Future<void> markSetupComplete(String accountId) async {
    final data = _read(accountId)..['setupComplete'] = true;
    await preferences.setString(_key(accountId), jsonEncode(data));
  }

  @override
  Future<void> clearAccount(String accountId) async =>
      preferences.remove(_key(accountId));

  Map<String, int> _counts(Object? value) {
    if (value is! Map) return {};
    return {
      for (final entry in value.entries)
        if (entry.key is String &&
            entry.value is int &&
            (entry.value as int) >= 0)
          entry.key as String: entry.value as int,
    };
  }

  String _monthKey(DateTime time) =>
      '${time.year}-${time.month.toString().padLeft(2, '0')}';
  String _dayKey(DateTime time) =>
      '${_monthKey(time)}-${time.day.toString().padLeft(2, '0')}';
}
