import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabaseV2 database;
  late LockInDao dao;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    dao = LockInDao(database);
  });

  tearDown(() => database.close());

  test('stores rules and attempts in the shared database', () async {
    await dao.upsertRule(
      id: 'work',
      name: 'Work hours',
      appsJson: '[]',
      weekdaysJson: '[1,2,3,4,5]',
      startMinutes: 540,
      endMinutes: 1020,
      enabled: true,
    );
    await dao.recordAttempt(
      appIdentifier: 'com.instagram.android',
      appName: 'Instagram',
      ruleId: 'work',
      occurredAt: DateTime(2026, 9, 7, 9),
    );

    expect((await dao.getRules()).single.id, 'work');
    expect((await dao.getAttempts()).single.appIdentifier, 'com.instagram.android');
  });
}
