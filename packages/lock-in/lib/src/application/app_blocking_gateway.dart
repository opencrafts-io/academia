import 'dart:async';

import 'package:app_blocker/app_blocker.dart';
import 'package:flutter/material.dart';

import '../domain/lock_rule.dart';

enum BlockPermissionStatus { granted, denied, restricted }

class BlockedAttemptEvent {
  const BlockedAttemptEvent({
    required this.appIdentifier,
    required this.occurredAt,
    this.ruleId,
  });

  final String appIdentifier;
  final String? ruleId;
  final DateTime occurredAt;
}

/// Platform boundary for Android app discovery, schedules, and block events.
abstract class AppBlockingGateway {
  Future<BlockPermissionStatus> checkPermission();
  Future<BlockPermissionStatus> requestPermission();
  Future<List<BlockedApp>> getInstalledApps();
  Future<void> setFocusBlockScreen();
  Future<void> upsertSchedule(LockRule rule);
  Future<void> removeSchedule(String ruleId);
  Stream<BlockedAttemptEvent> get attemptedAccesses;
}

class AppBlockerGateway implements AppBlockingGateway {
  AppBlockerGateway({AppBlocker? blocker})
    : _blocker = blocker ?? AppBlocker.instance;

  final AppBlocker _blocker;

  @override
  Future<BlockPermissionStatus> checkPermission() async {
    return _mapPermission(await _blocker.checkPermission());
  }

  @override
  Future<BlockPermissionStatus> requestPermission() async {
    return _mapPermission(await _blocker.requestPermission());
  }

  @override
  Future<List<BlockedApp>> getInstalledApps() async {
    final apps = await _blocker.getApps();
    return apps
        .where((app) => !app.isSystemApp)
        .map(
          (app) => BlockedApp(
            identifier: app.packageName,
            displayName: app.appName,
            icon: app.icon,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> setFocusBlockScreen() {
    return _blocker.setBlockScreenConfig(
      const BlockScreenConfig(
        title: 'This app is blocked by Lock In',
        subtitle: 'Stay with your focus',
        message: 'Return to Academia when you are ready.',
        backgroundColor: Color(0xFF121318),
      ),
    );
  }

  @override
  Future<void> upsertSchedule(LockRule rule) async {
    final schedule = BlockSchedule(
      id: rule.id,
      name: rule.name,
      appIdentifiers: rule.apps.map((app) => app.identifier).toList(),
      weekdays: rule.weekdays.toList()..sort(),
      startTime: TimeOfDay(
        hour: rule.startMinutes ~/ 60,
        minute: rule.startMinutes % 60,
      ),
      endTime: TimeOfDay(
        hour: rule.endMinutes ~/ 60,
        minute: rule.endMinutes % 60,
      ),
      enabled: rule.enabled,
    );
    final existing = await _blocker.getSchedules();
    if (existing.any((item) => item.id == rule.id)) {
      await _blocker.updateSchedule(schedule);
    } else {
      await _blocker.addSchedule(schedule);
    }
  }

  @override
  Future<void> removeSchedule(String ruleId) => _blocker.removeSchedule(ruleId);

  @override
  Stream<BlockedAttemptEvent> get attemptedAccesses => _blocker.onBlockEvent
      .where((event) => event.type == BlockEventType.attemptedAccess)
      .where((event) => event.packageName != null)
      .map(
        (event) => BlockedAttemptEvent(
          appIdentifier: event.packageName!,
          ruleId: event.scheduleId,
          occurredAt: event.timestamp,
        ),
      );

  BlockPermissionStatus _mapPermission(BlockerPermissionStatus status) {
    return switch (status) {
      BlockerPermissionStatus.granted => BlockPermissionStatus.granted,
      BlockerPermissionStatus.denied => BlockPermissionStatus.denied,
      BlockerPermissionStatus.restricted => BlockPermissionStatus.restricted,
    };
  }
}
