import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/src/data/lock_in_repository.dart';
import 'package:lock_in/src/domain/lock_rule.dart';

void main() {
  late AppDatabaseV2 database;
  late LockInRepository repository;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    repository = LockInRepository(LockInDao(database));
  });

  tearDown(() => database.close());

  test('persists attempts and aggregates them by local day', () async {
    await repository.recordAttempt(
      appIdentifier: 'com.instagram.android',
      appName: 'Instagram',
      ruleId: 'work',
      occurredAt: DateTime(2026, 9, 7, 9),
    );
    await repository.recordAttempt(
      appIdentifier: 'com.instagram.android',
      appName: 'Instagram',
      ruleId: 'work',
      occurredAt: DateTime(2026, 9, 7, 10),
    );
    await repository.recordAttempt(
      appIdentifier: 'com.instagram.android',
      appName: 'Instagram',
      ruleId: 'work',
      occurredAt: DateTime(2026, 9, 8, 9),
    );

    expect(
      await repository.attemptCountsByDay(
        from: DateTime(2026, 9, 7),
        to: DateTime(2026, 9, 8, 23, 59),
      ),
      {DateTime(2026, 9, 7): 2, DateTime(2026, 9, 8): 1},
    );
  });

  test('round trips a named rule and its selected apps', () async {
    const rule = LockRule(
      id: 'work',
      name: 'Work hours',
      apps: [
        BlockedApp(
          identifier: 'com.instagram.android',
          displayName: 'Instagram',
        ),
      ],
      weekdays: {DateTime.monday, DateTime.tuesday},
      startMinutes: 9 * 60,
      endMinutes: 17 * 60,
    );

    await repository.saveRule(rule);

    expect(await repository.getRules(), [rule]);
  });
}
