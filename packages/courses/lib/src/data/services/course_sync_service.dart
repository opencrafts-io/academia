import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:courses/src/data/datasources/course_remote_datasource.dart';
import 'package:courses/src/data/dtos/dtos.dart';
import 'package:courses/src/domain/entities/course_term.dart';
import 'package:courses/src/domain/entities/sync_status_update.dart';
import 'package:database/database.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CourseSyncService with WidgetsBindingObserver {
  CourseSyncService({required this.remote, required this.courseDao});

  final CourseRemoteDatasource remote;
  final CourseDao courseDao;
  final _changes = StreamController<SyncStatusUpdate>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final _expiredCourseIds = <String>{};
  Timer? _termExpiryTimer;
  bool _started = false;
  bool _syncing = false;
  bool _syncAgain = false;

  Stream<SyncStatusUpdate> get changes => _changes.stream;

  void startListening() {
    if (_started) return;
    _started = true;
    _scheduleTermExpirySync();
    WidgetsBinding.instance.addObserver(this);
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        unawaited(syncPending());
      }
    });
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    _termExpiryTimer?.cancel();
    if (_started) WidgetsBinding.instance.removeObserver(this);
    _started = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(syncPending());
  }

  void _scheduleTermExpirySync() {
    _termExpiryTimer?.cancel();
    final now = DateTime.now();
    final nextLocalMidnight = DateTime(now.year, now.month, now.day + 1);
    _termExpiryTimer = Timer(nextLocalMidnight.difference(now), () {
      if (!_started) return;
      unawaited(syncPending());
      _scheduleTermExpirySync();
    });
  }

  Future<void> syncPending() async {
    if (_syncing) {
      _syncAgain = true;
      return;
    }
    _syncing = true;
    try {
      do {
        _syncAgain = false;
        await _syncCourses();
        await _archiveExpiredCourses();
        await _syncScheduleEntries();
      } while (_syncAgain);
    } finally {
      _syncing = false;
    }
  }

  Future<void> _syncCourses() async {
    final pending = await courseDao.pendingCourses();
    for (final course in pending) {
      String? previousCourseId;
      if (course.previousCourseId != null) {
        final previous = await courseDao.courseById(course.previousCourseId!);
        previousCourseId = previous?.serverId;
      }

      try {
        final result = await remote.createCourse(
          institutionId: course.institutionId,
          title: course.title,
          code: course.code,
          color: course.color,
          termLabel: course.termLabel,
          academicYear: course.academicYear,
          termStartDate: course.termStartDate,
          termEndDate: course.termEndDate,
          previousCourseId: previousCourseId,
          idempotencyKey: course.idempotencyKey,
        );
        await result.fold(
          (failure) => _handleCourseFailure(course.id, failure),
          (created) async {
            await courseDao.setCourseSynced(
              course.id,
              created.id,
              createdAt: created.createdAt,
              updatedAt: created.updatedAt,
            );
            _changes.add(
              SyncStatusUpdate(
                id: course.id,
                serverId: created.id,
                status: 'synced',
              ),
            );
          },
        );
      } catch (_) {
        // Leave unexpected and transport failures pending for the next trigger.
      }
    }
  }

  Future<void> _archiveExpiredCourses() async {
    final activeCourses = await courseDao.activeCourses();
    for (final course in activeCourses) {
      if (!hasCourseTermEnded(course.termEndDate)) {
        _expiredCourseIds.remove(course.id);
        continue;
      }

      if (_expiredCourseIds.add(course.id)) {
        _changes.add(
          SyncStatusUpdate(
            id: course.id,
            serverId: course.serverId,
            status: 'expired',
          ),
        );
      }

      final serverId = course.serverId;
      if (serverId == null) continue;

      try {
        final result = await remote.archiveCourse(serverId);
        await result.fold((_) async {}, (archived) async {
          final now = DateTime.now();
          final archivedAt = archived.archivedAt ?? now;
          await courseDao.markCourseArchived(
            course.id,
            archivedAt: archivedAt,
            updatedAt: archived.updatedAt,
          );
          _changes.add(
            SyncStatusUpdate(
              id: course.id,
              serverId: serverId,
              status: 'archived',
              archivedAt: archivedAt,
            ),
          );
        });
      } catch (_) {
        // Retry expired courses on the next sync trigger.
      }
    }
  }

  Future<void> _handleCourseFailure(String id, Failure failure) async {
    if (failure is ServerFailure && failure.statusCode == 400) {
      await courseDao.setCourseSyncFailed(id, failure.message);
      _changes.add(
        SyncStatusUpdate(id: id, status: 'failed', error: failure.message),
      );
    }
  }

  Future<void> _syncScheduleEntries() async {
    final pending = await courseDao.pendingScheduleEntries();
    for (final entry in pending) {
      final parent = await courseDao.courseById(entry.studentCourseId);
      final parentServerId = parent?.serverId;
      if (parent == null ||
          parent.syncStatus != 'synced' ||
          parentServerId == null ||
          parent.archivedAt != null ||
          hasCourseTermEnded(parent.termEndDate)) {
        continue;
      }

      final draft = ScheduleEntryDto(
        dayOfWeek: entry.dayOfWeek,
        startTime: entry.startTime,
        endTime: entry.endTime,
        venue: entry.venue,
        campus: entry.campus,
        section: entry.section,
        label: entry.label,
        color: entry.color,
        isRecurring: entry.isRecurring,
        specificDate: entry.specificDate,
      );
      try {
        final result = await remote.createScheduleEntry(
          courseId: parentServerId,
          entry: draft,
          idempotencyKey: entry.idempotencyKey,
        );
        await result.fold(
          (failure) => _handleScheduleFailure(entry.id, failure),
          (created) async {
            await courseDao.setScheduleEntrySynced(entry.id, created.id);
            _changes.add(
              SyncStatusUpdate(
                id: entry.id,
                serverId: created.id,
                status: 'synced',
                isScheduleEntry: true,
              ),
            );
          },
        );
      } catch (_) {
        // Leave unexpected and transport failures pending for the next trigger.
      }
    }
  }

  Future<void> _handleScheduleFailure(String id, Failure failure) async {
    if (failure is ServerFailure && failure.statusCode == 400) {
      await courseDao.setScheduleEntrySyncFailed(id, failure.message);
      _changes.add(
        SyncStatusUpdate(
          id: id,
          status: 'failed',
          error: failure.message,
          isScheduleEntry: true,
        ),
      );
    }
  }
}
