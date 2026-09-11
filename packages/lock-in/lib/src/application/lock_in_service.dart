import 'dart:async';

import '../data/lock_in_repository.dart';
import '../domain/lock_rule.dart';
import 'app_blocking_gateway.dart';

/// Coordinates local Lock In data with the platform blocking service.
class LockInService {
  LockInService(this._repository, this._gateway);

  final LockInRepository _repository;
  final AppBlockingGateway _gateway;
  StreamSubscription<BlockedAttemptEvent>? _attemptSubscription;
  final _appNames = <String, String>{};

  Future<List<LockRule>> rules() => _repository.getRules();

  Stream<List<LockRule>> watchRules() => _repository.watchRules();

  /// Finds the active saved rule window for an app opened at [at].
  Future<LockRuleWindow?> activeWindowFor(
    String appIdentifier, {
    DateTime? at,
  }) async {
    final localTime = at ?? DateTime.now();
    for (final rule in await rules()) {
      if (!rule.apps.any((app) => app.identifier == appIdentifier)) continue;
      final window = rule.activeWindowAt(localTime);
      if (window != null) return window;
    }
    return null;
  }

  Future<List<BlockedApp>> installedApps() async {
    final apps = await _gateway.getInstalledApps();
    _appNames.addEntries(
      apps.map((app) => MapEntry(app.identifier, app.displayName)),
    );
    return apps;
  }

  Future<BlockPermissionStatus> checkPermission() => _gateway.checkPermission();

  Future<BlockPermissionStatus> requestPermission() =>
      _gateway.requestPermission();

  Future<void> saveRule(LockRule rule) async {
    final existing = (await rules())
        .where((item) => item.id == rule.id)
        .firstOrNull;
    if (existing?.isActiveAt(DateTime.now()) ?? false) {
      throw StateError(
        'An active Lock In rule cannot be changed until it ends.',
      );
    }
    final permission = await checkPermission();
    if (permission != BlockPermissionStatus.granted) {
      throw StateError(
        'Blocking permission must be granted before saving a rule.',
      );
    }
    await _repository.saveRule(rule);
    await _gateway.setFocusBlockScreen();
    await _gateway.upsertSchedule(rule);
  }

  Future<void> deleteRule(String ruleId) async {
    final rule = (await rules()).where((item) => item.id == ruleId).firstOrNull;
    if (rule == null) return;
    if (rule.isActiveAt(DateTime.now())) {
      throw StateError(
        'An active Lock In rule cannot be deleted until it ends.',
      );
    }
    await _gateway.removeSchedule(ruleId);
    await _repository.deleteRule(ruleId);
  }

  Future<Map<DateTime, int>> attemptCountsByDay({
    required DateTime from,
    required DateTime to,
  }) => _repository.attemptCountsByDay(from: from, to: to);

  Future<void> start() async {
    if (_attemptSubscription != null) return;
    _attemptSubscription = _gateway.attemptedAccesses.listen((event) {
      unawaited(
        _repository.recordAttempt(
          appIdentifier: event.appIdentifier,
          appName: _appNames[event.appIdentifier] ?? event.appIdentifier,
          ruleId: event.ruleId,
          occurredAt: event.occurredAt,
        ),
      );
    });
    try {
      await installedApps();
    } on Object {
      // Attempt events can still be persisted using their package identifier
      // when Android has not granted app-discovery access yet.
    }
  }

  Future<void> dispose() async {
    await _attemptSubscription?.cancel();
    _attemptSubscription = null;
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
