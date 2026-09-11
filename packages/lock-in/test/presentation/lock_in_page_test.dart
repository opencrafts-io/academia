import 'dart:async';
import 'dart:typed_data';

import 'package:database/app_database_v2.dart';
import 'package:database/daos/lock_in_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/lock_in.dart';
import 'package:lock_in/src/presentation/lock_rule_editor_page.dart';

void main() {
  late AppDatabaseV2 database;
  late _PermissionGateway gateway;
  late LockInService service;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    gateway = _PermissionGateway();
    service = LockInService(LockInRepository(LockInDao(database)), gateway);
  });

  tearDown(() async {
    await service.dispose();
    await database.close();
  });

  testWidgets('refreshes after granting app-blocking permission', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow app blocking'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('New rule'), findsOneWidget);
  });

  testWidgets('rechecks permission after returning from Android settings', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    gateway.grantPermission();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(find.text('New rule'), findsOneWidget);
  });

  testWidgets('shows that permission setup can continue after one grant', (
    tester,
  ) async {
    gateway.grantOnRequest = false;
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow app blocking'));
    await tester.pumpAndSettle();

    expect(find.text('Continue setup'), findsOneWidget);
  });

  testWidgets('shows installed app icons in the rule editor', (tester) async {
    gateway.apps = [
      BlockedApp(
        identifier: 'com.instagram.android',
        displayName: 'Instagram',
        icon: _transparentPng,
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(home: LockRuleEditorPage(service: service)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Instagram'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}

final _transparentPng = Uint8List.fromList(const [
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  72,
  68,
  82,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  8,
  6,
  0,
  0,
  0,
  31,
  21,
  196,
  137,
  0,
  0,
  0,
  13,
  73,
  68,
  65,
  84,
  8,
  215,
  99,
  248,
  207,
  192,
  240,
  31,
  0,
  5,
  0,
  1,
  255,
  137,
  153,
  61,
  29,
  0,
  0,
  0,
  0,
  73,
  69,
  78,
  68,
  174,
  66,
  96,
  130,
]);

class _PermissionGateway implements AppBlockingGateway {
  BlockPermissionStatus _permission = BlockPermissionStatus.denied;
  bool grantOnRequest = true;
  List<BlockedApp> apps = const [];

  @override
  Stream<BlockedAttemptEvent> get attemptedAccesses => const Stream.empty();

  @override
  Future<BlockPermissionStatus> checkPermission() async => _permission;

  @override
  Future<List<BlockedApp>> getInstalledApps() async => apps;

  @override
  Future<BlockPermissionStatus> requestPermission() async {
    if (grantOnRequest) grantPermission();
    return _permission;
  }

  void grantPermission() => _permission = BlockPermissionStatus.granted;

  @override
  Future<void> removeSchedule(String ruleId) async {}

  @override
  Future<void> setFocusBlockScreen() async {}

  @override
  Future<void> upsertSchedule(LockRule rule) async {}
}
