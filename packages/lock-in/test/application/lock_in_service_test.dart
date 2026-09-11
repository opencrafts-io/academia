import 'dart:async';

import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/lock_in.dart';

void main() {
  late AppDatabaseV2 database;
  late _FakeGateway gateway;
  late LockInService service;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    gateway = _FakeGateway();
    service = LockInService(LockInRepository(LockInDao(database)), gateway);
  });

  tearDown(() async {
    await service.dispose();
    await database.close();
  });

  test('maps an enabled rule to a native recurring schedule', () async {
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

    await service.saveRule(rule);

    expect(gateway.schedules.single, rule);
    expect(await service.rules(), [rule]);
  });

  test('persists attempted access emitted by the blocker gateway', () async {
    await service.start();
    gateway.emitAttempt(
      BlockedAttemptEvent(
        appIdentifier: 'com.instagram.android',
        ruleId: 'work',
        occurredAt: DateTime(2026, 9, 7, 9),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(
      await service.attemptCountsByDay(
        from: DateTime(2026, 9, 7),
        to: DateTime(2026, 9, 7, 23, 59),
      ),
      {DateTime(2026, 9, 7): 1},
    );
  });
}

class _FakeGateway implements AppBlockingGateway {
  final _events = StreamController<BlockedAttemptEvent>.broadcast();
  final schedules = <LockRule>[];

  @override
  Stream<BlockedAttemptEvent> get attemptedAccesses => _events.stream;

  @override
  Future<BlockPermissionStatus> checkPermission() async =>
      BlockPermissionStatus.granted;

  @override
  Future<List<BlockedApp>> getInstalledApps() async => const [
    BlockedApp(identifier: 'com.instagram.android', displayName: 'Instagram'),
  ];

  @override
  Future<BlockPermissionStatus> requestPermission() => checkPermission();

  @override
  Future<void> removeSchedule(String ruleId) async {}

  @override
  Future<void> setFocusBlockScreen() async {}

  @override
  Future<void> upsertSchedule(LockRule rule) async => schedules.add(rule);

  void emitAttempt(BlockedAttemptEvent event) => _events.add(event);
}
