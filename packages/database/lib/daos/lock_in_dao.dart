import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database_v2.dart';
import '../tables/tables.dart';

part 'lock_in_dao.g.dart';

/// Persistence API shared by the Lock In subsystem.
@injectable
@DriftAccessor(tables: [LockInRuleRecords, LockInAttempts])
class LockInDao extends DatabaseAccessor<AppDatabaseV2> with _$LockInDaoMixin {
  LockInDao(super.db);

  Future<List<LockInRuleRecord>> getRules() {
    return (select(lockInRuleRecords)
          ..orderBy([(rule) => OrderingTerm.asc(rule.name)]))
        .get();
  }

  Stream<List<LockInRuleRecord>> watchRules() {
    return (select(lockInRuleRecords)
          ..orderBy([(rule) => OrderingTerm.asc(rule.name)]))
        .watch();
  }

  Future<void> upsertRule({
    required String id,
    required String name,
    required String appsJson,
    required String weekdaysJson,
    required int startMinutes,
    required int endMinutes,
    required bool enabled,
  }) async {
    await into(lockInRuleRecords).insertOnConflictUpdate(
      LockInRuleRecordsCompanion.insert(
        id: id,
        name: name,
        appsJson: appsJson,
        weekdaysJson: weekdaysJson,
        startMinutes: startMinutes,
        endMinutes: endMinutes,
        enabled: enabled,
      ),
    );
  }

  Future<void> deleteRule(String id) async {
    await (delete(lockInRuleRecords)..where((rule) => rule.id.equals(id))).go();
  }

  Future<void> recordAttempt({
    required String appIdentifier,
    required String appName,
    required DateTime occurredAt,
    String? ruleId,
  }) async {
    await into(lockInAttempts).insert(
      LockInAttemptsCompanion.insert(
        appIdentifier: appIdentifier,
        appName: appName,
        ruleId: Value(ruleId),
        occurredAt: occurredAt,
      ),
    );
  }

  Future<List<LockInAttempt>> getAttempts({
    DateTime? from,
    DateTime? to,
  }) {
    final query = select(lockInAttempts)
      ..orderBy([(attempt) => OrderingTerm.desc(attempt.occurredAt)]);
    if (from != null) {
      query.where((attempt) => attempt.occurredAt.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      query.where((attempt) => attempt.occurredAt.isSmallerOrEqualValue(to));
    }
    return query.get();
  }
}
