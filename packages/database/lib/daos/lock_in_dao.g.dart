// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_in_dao.dart';

// ignore_for_file: type=lint
mixin _$LockInDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $LockInRuleRecordsTable get lockInRuleRecords =>
      attachedDatabase.lockInRuleRecords;
  $LockInAttemptsTable get lockInAttempts => attachedDatabase.lockInAttempts;
  LockInDaoManager get managers => LockInDaoManager(this);
}

class LockInDaoManager {
  final _$LockInDaoMixin _db;
  LockInDaoManager(this._db);
  $$LockInRuleRecordsTableTableManager get lockInRuleRecords =>
      $$LockInRuleRecordsTableTableManager(
        _db.attachedDatabase,
        _db.lockInRuleRecords,
      );
  $$LockInAttemptsTableTableManager get lockInAttempts =>
      $$LockInAttemptsTableTableManager(
        _db.attachedDatabase,
        _db.lockInAttempts,
      );
}
