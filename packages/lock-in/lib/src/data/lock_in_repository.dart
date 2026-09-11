import 'dart:convert';

import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';

import '../domain/lock_rule.dart';

/// Local source of truth for Lock In configuration and recovery analytics.
class LockInRepository {
  LockInRepository(this._dao);

  final LockInDao _dao;

  Future<List<LockRule>> getRules() async {
    return (await _dao.getRules()).map(_ruleFromRow).toList(growable: false);
  }

  Stream<List<LockRule>> watchRules() {
    return _dao.watchRules().map(
      (rows) => rows.map(_ruleFromRow).toList(growable: false),
    );
  }

  Future<void> saveRule(LockRule rule) async {
    if (!rule.isValid) {
      throw ArgumentError.value(rule, 'rule', 'Rule is incomplete or invalid');
    }

    final otherRules = await getRules();
    if (otherRules.any(
      (other) => other.id != rule.id && rule.conflictsWith(other),
    )) {
      throw StateError(
        'This rule overlaps another enabled rule for a selected app.',
      );
    }

    await _dao.upsertRule(
      id: rule.id,
      name: rule.name,
      appsJson: jsonEncode(
        rule.apps
            .map(
              (app) => {
                'identifier': app.identifier,
                'displayName': app.displayName,
              },
            )
            .toList(growable: false),
      ),
      weekdaysJson: jsonEncode(rule.weekdays.toList()..sort()),
      startMinutes: rule.startMinutes,
      endMinutes: rule.endMinutes,
      enabled: rule.enabled,
    );
  }

  Future<void> deleteRule(String id) => _dao.deleteRule(id);

  Future<void> recordAttempt({
    required String appIdentifier,
    required String appName,
    required DateTime occurredAt,
    String? ruleId,
  }) {
    return _dao.recordAttempt(
      appIdentifier: appIdentifier,
      appName: appName,
      ruleId: ruleId,
      occurredAt: occurredAt,
    );
  }

  Future<Map<DateTime, int>> attemptCountsByDay({
    required DateTime from,
    required DateTime to,
  }) async {
    final rows = await _dao.getAttempts(from: from, to: to);
    final counts = <DateTime, int>{};
    for (final row in rows) {
      final local = row.occurredAt.toLocal();
      final day = DateTime(local.year, local.month, local.day);
      counts.update(day, (count) => count + 1, ifAbsent: () => 1);
    }
    return counts;
  }

  LockRule _ruleFromRow(LockInRuleRecord row) {
    final rawApps = (jsonDecode(row.appsJson) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final rawWeekdays = (jsonDecode(row.weekdaysJson) as List<dynamic>)
        .cast<num>();
    return LockRule(
      id: row.id,
      name: row.name,
      apps: rawApps
          .map(
            (app) => BlockedApp(
              identifier: app['identifier']! as String,
              displayName: app['displayName']! as String,
            ),
          )
          .toList(growable: false),
      weekdays: rawWeekdays.map((day) => day.toInt()).toSet(),
      startMinutes: row.startMinutes,
      endMinutes: row.endMinutes,
      enabled: row.enabled,
    );
  }
}
