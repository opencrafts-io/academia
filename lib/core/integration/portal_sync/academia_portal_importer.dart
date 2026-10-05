import 'dart:convert';

import 'package:courses/courses.dart';
import 'package:crypto/crypto.dart';
import 'package:portal_sync/portal_sync.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Only local record IDs and hashes are stored, never portal rows or prompts.
class PortalImportLink {
  const PortalImportLink(this.recordId, this.baselineHash);
  final String recordId;
  final String baselineHash;
}

abstract interface class PortalImportLedger {
  Future<PortalImportLink?> get(String key);
  Future<void> put(String key, PortalImportLink value);
}

class SharedPreferencesPortalImportLedger implements PortalImportLedger {
  SharedPreferencesPortalImportLedger(this.preferences);
  final SharedPreferences preferences;

  @override
  Future<PortalImportLink?> get(String key) async {
    final encoded = preferences.getString(key);
    if (encoded == null) return null;
    try {
      final value = jsonDecode(encoded);
      if (value is Map &&
          value['id'] is String &&
          value['baseline'] is String) {
        return PortalImportLink(
          value['id'] as String,
          value['baseline'] as String,
        );
      }
    } on FormatException {
      // Corrupt mappings are treated as unowned records, never overwritten.
    }
    return null;
  }

  @override
  Future<void> put(String key, PortalImportLink value) async {
    final saved = await preferences.setString(
      key,
      jsonEncode({'id': value.recordId, 'baseline': value.baselineHash}),
    );
    if (!saved) throw StateError('Could not persist the import mapping.');
  }
}

/// Adapts reviewed portal records to the shipped offline course repository.
/// Writes are incremental; each successful write is linked before the next.
/// Missing records are never deleted, and edits outside our baseline are kept.
class AcademiaPortalImporter implements PortalImporter {
  AcademiaPortalImporter({
    required this.repository,
    required this.ledger,
    required this.accountId,
    required this.institutionId,
    required this.isCurrentAccount,
  });

  final CourseRepository repository;
  final PortalImportLedger ledger;
  final String accountId;
  final int institutionId;
  final bool Function() isCurrentAccount;
  bool _saving = false;

  void _checkAccount() {
    if (!isCurrentAccount()) throw StateError('The signed-in account changed.');
  }

  String _key(String origin, String kind, String sourceId) =>
      'portal_import_v1_${_hash([accountId, institutionId, origin, kind, sourceId])}';

  @override
  Future<PortalImportResult> importDraft(PortalDraft draft) async {
    _checkAccount();
    if (_saving || !draft.isValid) {
      throw StateError('No validated import is ready.');
    }
    final origin = Uri.tryParse(draft.sourceOrigin);
    if (origin == null ||
        origin.scheme != 'https' ||
        origin.userInfo.isNotEmpty ||
        origin.host.isEmpty) {
      throw StateError('The source origin is invalid.');
    }
    _saving = true;
    try {
      final courses = (await repository.listActiveCourses()).fold(
        (_) => throw StateError('Could not read saved courses.'),
        (value) => List<CourseEntity>.of(value),
      );
      final meetings = (await repository.listCachedStudentSchedule()).fold(
        (_) => throw StateError('Could not read saved meetings.'),
        (value) => List<ScheduleEntryEntity>.of(value),
      );
      _checkAccount();
      final courseIds = <String, String>{};
      var coursesSaved = 0;
      var meetingsSaved = 0;
      var kept = 0;

      for (final incoming in draft.courses) {
        _checkAccount();
        final key = _key(draft.sourceOrigin, 'course', incoming.sourceId);
        final link = await ledger.get(key);
        final matches = courses
            .where(
              (course) => link != null
                  ? course.id == link.recordId
                  : course.institutionId == institutionId &&
                        _normalize(course.code) == _normalize(incoming.code) &&
                        _normalize(course.termLabel) ==
                            _normalize(incoming.term),
            )
            .toList();
        if (matches.length > 1 || (link != null && matches.isEmpty)) {
          kept++;
          continue;
        }
        final existing = matches.isEmpty ? null : matches.single;
        if (existing != null && existing.institutionId != institutionId) {
          kept++;
          continue;
        }
        if (existing != null) courseIds[incoming.sourceId] = existing.id;
        final desiredHash = _hash([
          incoming.title,
          incoming.code,
          incoming.term,
        ]);
        if (existing != null &&
            ((link != null && _courseHash(existing) != link.baselineHash) ||
                (link == null && _courseHash(existing) != desiredHash))) {
          kept++;
          continue;
        }
        _checkAccount();
        CourseEntity saved;
        if (existing == null) {
          saved =
              (await repository.createCourse(
                institutionId: institutionId,
                title: incoming.title,
                code: incoming.code,
                termLabel: incoming.term,
              )).fold(
                (_) => throw StateError('Could not save a course.'),
                (value) => value,
              );
          courses.add(saved);
          coursesSaved++;
        } else if (_courseHash(existing) != desiredHash) {
          saved =
              (await repository.updateCourse(
                existing.copyWith(
                  title: incoming.title,
                  code: incoming.code,
                  termLabel: incoming.term,
                  updatedAt: DateTime.now().toUtc(),
                ),
              )).fold(
                (_) => throw StateError('Could not update a course.'),
                (value) => value,
              );
          courses[courses.indexWhere((course) => course.id == saved.id)] =
              saved;
          coursesSaved++;
        } else {
          saved = existing;
        }
        await ledger.put(key, PortalImportLink(saved.id, _courseHash(saved)));
        courseIds[incoming.sourceId] = saved.id;
      }

      final knownMeetingIds = <String>{};
      for (final incoming in draft.meetings) {
        final link = await ledger.get(
          _key(draft.sourceOrigin, 'meeting', incoming.sourceId),
        );
        if (link != null) knownMeetingIds.add(link.recordId);
      }
      for (final incoming in draft.meetings) {
        _checkAccount();
        final courseId = courseIds[incoming.courseSourceId];
        if (courseId == null) {
          kept++;
          continue;
        }
        // The existing schedule stores school wall-clock times. It has no
        // timezone column; a zoned source needs explicit conversion in phase 2.
        if (incoming.timeZone != null && incoming.timeZone!.trim().isNotEmpty) {
          kept++;
          continue;
        }
        final key = _key(draft.sourceOrigin, 'meeting', incoming.sourceId);
        final link = await ledger.get(key);
        final desiredHash = _hash([
          courseId,
          incoming.day.toLowerCase(),
          incoming.startTime,
          incoming.endTime,
          _normalize(incoming.venue),
          true,
          null,
        ]);
        final candidates = meetings
            .where((entry) => entry.studentCourseId == courseId)
            .toList();
        final matches = candidates
            .where(
              (entry) => link != null
                  ? entry.id == link.recordId
                  : _meetingHash(entry) == desiredHash,
            )
            .toList();
        if (matches.length > 1 || (link != null && matches.isEmpty)) {
          kept++;
          continue;
        }
        final existing = matches.isEmpty ? null : matches.single;
        if (existing == null &&
            link == null &&
            candidates.any((entry) => !knownMeetingIds.contains(entry.id))) {
          // A changed day/row order has no reliable identity. Ask for a manual
          // reconciliation rather than adding a potential duplicate meeting.
          kept++;
          continue;
        }
        if (existing != null &&
            link != null &&
            _meetingHash(existing) != link.baselineHash) {
          kept++;
          continue;
        }
        _checkAccount();
        ScheduleEntryEntity saved;
        if (existing == null) {
          final now = DateTime.now().toUtc();
          saved =
              (await repository.createScheduleEntry(
                ScheduleEntryEntity(
                  id: '',
                  studentCourseId: courseId,
                  dayOfWeek: incoming.day.toLowerCase(),
                  startTime: incoming.startTime,
                  endTime: incoming.endTime,
                  venue: incoming.venue,
                  createdAt: now,
                  updatedAt: now,
                ),
              )).fold(
                (_) => throw StateError('Could not save a meeting.'),
                (value) => value,
              );
          meetingsSaved++;
        } else if (_meetingHash(existing) != desiredHash) {
          saved =
              (await repository.updateScheduleEntry(
                existing.copyWith(
                  dayOfWeek: incoming.day.toLowerCase(),
                  startTime: incoming.startTime,
                  endTime: incoming.endTime,
                  venue: incoming.venue,
                  updatedAt: DateTime.now().toUtc(),
                ),
              )).fold(
                (_) => throw StateError('Could not update a meeting.'),
                (value) => value,
              );
          meetingsSaved++;
        } else {
          saved = existing;
        }
        await ledger.put(key, PortalImportLink(saved.id, _meetingHash(saved)));
      }
      return PortalImportResult(
        importedCourses: coursesSaved,
        importedMeetings: meetingsSaved,
        message: kept > 0
            ? 'Saved $coursesSaved courses and $meetingsSaved meetings. $kept existing or ambiguous records were kept; check them in your courses.'
            : 'Saved $coursesSaved courses and $meetingsSaved meetings. Your timetable uses the school’s local times.',
      );
    } finally {
      _saving = false;
    }
  }

  static String _normalize(String? value) => value?.trim().toLowerCase() ?? '';
  static String _hash(List<Object?> fields) =>
      sha256.convert(utf8.encode(jsonEncode(fields))).toString();
  static String _courseHash(CourseEntity value) =>
      _hash([value.title, value.code, value.termLabel]);
  static String _meetingHash(ScheduleEntryEntity value) => _hash([
    value.studentCourseId,
    value.dayOfWeek.toLowerCase(),
    value.startTime,
    value.endTime,
    _normalize(value.venue),
    value.isRecurring,
    value.specificDate?.toIso8601String(),
  ]);
}
