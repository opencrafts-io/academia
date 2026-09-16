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
  late LockInRepository repository;
  late LockInService service;

  setUp(() {
    database = AppDatabaseV2(NativeDatabase.memory());
    gateway = _PermissionGateway();
    repository = LockInRepository(LockInDao(database));
    service = LockInService(repository, gateway);
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

  testWidgets('shows local focus statistics on the dashboard', (tester) async {
    gateway.grantPermission();
    await repository.saveRule(
      const LockRule(
        id: 'work',
        name: 'Work hours',
        apps: [
          BlockedApp(
            identifier: 'com.instagram.android',
            displayName: 'Instagram',
          ),
        ],
        weekdays: {DateTime.monday},
        startMinutes: 9 * 60,
        endMinutes: 17 * 60,
      ),
    );
    await repository.recordAttempt(
      appIdentifier: 'com.instagram.android',
      appName: 'Instagram',
      ruleId: 'work',
      occurredAt: DateTime.now(),
    );
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    expect(find.text('Focus statistics'), findsOneWidget);
    expect(find.text('Blocked opens'), findsOneWidget);
    expect(find.text('Active rules'), findsOneWidget);
    expect(find.text('Apps protected'), findsOneWidget);
  });

  testWidgets('keeps Save rule in the persistent editor action bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: LockRuleEditorPage(service: service)),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('lock-in-save-action')), findsOneWidget);
  });

  testWidgets('updates an existing rule from the dashboard', (tester) async {
    gateway.grantPermission();
    await repository.saveRule(_inactiveRule());
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Edit rule'), 300);
    await tester.tap(find.text('Edit rule'));
    await tester.pumpAndSettle();
    expect(find.text('Edit Lock In rule'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Deep work');
    await tester.tap(find.byKey(const Key('lock-in-save-action')));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Deep work'), 300);
    expect(find.text('Deep work'), findsOneWidget);
  });

  testWidgets('confirms before deleting an existing rule', (tester) async {
    gateway.grantPermission();
    await repository.saveRule(_inactiveRule());
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Delete rule'), 300);
    await tester.tap(find.text('Delete rule'));
    await tester.pumpAndSettle();
    expect(find.text('Delete Work hours?'), findsOneWidget);

    await tester.tap(find.text('Delete rule').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.textContaining('No rules yet'), 300);
    expect(find.textContaining('No rules yet'), findsOneWidget);
  });

  testWidgets('explains why an active rule cannot be changed', (tester) async {
    gateway.grantPermission();
    await repository.saveRule(_activeRule());
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('This rule is active and cannot be changed until it ends.'),
      300,
    );

    expect(
      find.text('This rule is active and cannot be changed until it ends.'),
      findsOneWidget,
    );
  });

  testWidgets('separates dashboard rule cards', (tester) async {
    gateway.grantPermission();
    await repository.saveRule(_inactiveRule());
    await repository.saveRule(
      _inactiveRule(
        id: 'study',
        name: 'Study time',
        appIdentifier: 'com.youtube.android',
      ),
    );
    expect(await repository.getRules(), hasLength(2));
    await tester.pumpWidget(MaterialApp(home: LockInPage(service: service)));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -1000));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget.key == const ValueKey('lock-in-rule-gap-work') ||
            widget.key == const ValueKey('lock-in-rule-gap-study'),
      ),
      findsOneWidget,
    );
  });
}

LockRule _inactiveRule({
  String id = 'work',
  String name = 'Work hours',
  String appIdentifier = 'com.instagram.android',
}) {
  final weekday = DateTime.now().weekday == DateTime.monday
      ? DateTime.tuesday
      : DateTime.monday;
  return LockRule(
    id: id,
    name: name,
    apps: [BlockedApp(identifier: appIdentifier, displayName: 'Instagram')],
    weekdays: {weekday},
    startMinutes: 9 * 60,
    endMinutes: 17 * 60,
  );
}

LockRule _activeRule() {
  final now = DateTime.now();
  final currentMinute = now.hour * 60 + now.minute;
  final startsAt = currentMinute == 1439 ? 1438 : currentMinute;
  final endsAt = currentMinute == 1439 ? 0 : currentMinute + 1;
  return LockRule(
    id: 'active-work',
    name: 'Active work',
    apps: const [
      BlockedApp(identifier: 'com.instagram.android', displayName: 'Instagram'),
    ],
    weekdays: {now.weekday},
    startMinutes: startsAt,
    endMinutes: endsAt,
  );
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
