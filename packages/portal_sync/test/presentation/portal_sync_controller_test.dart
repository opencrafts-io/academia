import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_connection.dart';
import 'package:portal_sync/src/domain/entities/portal_draft.dart';
import 'package:portal_sync/src/domain/entities/portal_snapshot.dart';
import 'package:portal_sync/src/domain/repositories/portal_sync_repositories.dart';
import 'package:portal_sync/src/presentation/portal_sync_controller.dart';
import 'package:portal_sync/src/presentation/portal_sync_state.dart';

void main() {
  final connection = PortalConnection(
    accountId: 'account-a',
    institutionId: 1,
    schoolName: 'Example',
    portalUri: Uri.parse('https://portal.example.edu'),
  );

  PortalSnapshot snapshot(String title, {String code = 'CS101'}) =>
      PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'title': 'My courses',
        'language': 'en',
        'nodes': [
          {
            'id': 'table-1',
            'kind': 'table',
            'label': 'Courses',
            'headers': ['Code', 'Title'],
            'rows': [
              [code, title],
            ],
          },
        ],
      });

  PortalAnalysisPlan coursePlan() => PortalAnalysisPlan.fromJson({
    'pageType': 'courses',
    'tables': [
      {
        'nodeId': 'table-1',
        'kind': 'courses',
        'columns': {'code': 0, 'title': 1},
      },
    ],
  });

  test(
    'cached plans extract refreshed values without a second model request',
    () async {
      final client = _AnalysisClient((_) async => coursePlan());
      final cache = _MemoryCache();
      final controller = _controller(connection, client, cache);

      await controller.capture(snapshot('Algorithms'));
      final firstSourceId = controller.state.draft!.courses.single.sourceId;
      await controller.capture(snapshot('Data structures'));

      expect(client.calls, 1);
      expect(controller.state.phase, PortalSyncPhase.review);
      expect(controller.state.fromCache, isTrue);
      expect(controller.state.draft!.courses.single.title, 'Data structures');
      expect(controller.state.draft!.courses.single.sourceId, firstSourceId);
      controller.dispose();
    },
  );

  test('analysis failures log diagnostics without student data or credentials', () async {
    final logs = <String>[];
    final previousPrint = debugPrint;
    debugPrint = (message, {wrapWidth}) {
      if (message != null) logs.add(message);
    };
    addTearDown(() => debugPrint = previousPrint);
    final client = _AnalysisClient((_) async {
      throw FirebaseAIException(
        'Permission denied: API key AIzaSecretForTest12345678901234567890123; '
        'Bearer secret-token; https://portal.example.edu/private?student=123 '
        '{"prompt":"Private course title"}',
      );
    });
    final controller = _controller(connection, client, _MemoryCache());
    addTearDown(controller.dispose);
    await controller.capture(snapshot('Private course title'));
    final output = logs.join('\n');
    expect(controller.state.phase, PortalSyncPhase.error);
    expect(output, contains('[portal_sync] analysis.failed'));
    expect(output, contains('FirebaseAIException'));
    expect(output, contains('Permission denied'));
    expect(output, contains('gemini-3.8-flash'));
    for (final privateValue in [
      'Private course title',
      'account-a',
      'AIzaSecretForTest',
      'secret-token',
      'student=123',
    ]) {
      expect(output, isNot(contains(privateValue)));
    }
  });

  test(
    'same path pagination accumulates courses without repeating analysis',
    () async {
      final client = _AnalysisClient((_) async => coursePlan());
      final controller = _controller(connection, client, _MemoryCache());
      await controller.capture(snapshot('Algorithms'));
      await controller.capture(snapshot('Data structures', code: 'CS202'));
      expect(client.calls, 1);
      expect(
        controller.state.draft!.courses.map((course) => course.code),
        containsAll(['CS101', 'CS202']),
      );
      expect(controller.state.coursesCount, 2);
      controller.dispose();
    },
  );

  test(
    'late model response after pause cannot change state or cache',
    () async {
      final completion = Completer<PortalAnalysisPlan>();
      final client = _AnalysisClient((_) => completion.future);
      final cache = _MemoryCache();
      final controller = _controller(connection, client, cache);

      final pending = controller.capture(snapshot('Algorithms'));
      await Future<void>.delayed(Duration.zero);
      expect(controller.state.phase, PortalSyncPhase.analyzing);
      controller.pause();
      completion.complete(coursePlan());
      await pending;

      expect(controller.state.phase, PortalSyncPhase.paused);
      expect(controller.state.draft, isNull);
      expect(cache.writes, 0);
      controller.dispose();
    },
  );

  test('a failed unchanged page requires explicit bounded retry', () async {
    var first = true;
    final client = _AnalysisClient((_) async {
      if (first) {
        first = false;
        throw StateError('provider failure');
      }
      return coursePlan();
    });
    final controller = _controller(connection, client, _MemoryCache());
    await controller.capture(snapshot('Algorithms'));
    await controller.capture(snapshot('Algorithms'));
    expect(client.calls, 1);
    await controller.retryAnalysis();
    expect(client.calls, 2);
    expect(controller.state.phase, PortalSyncPhase.review);
    await controller.retryAnalysis();
    expect(client.calls, 2);
    controller.dispose();
  });

  test(
    'an invented hint and invalid extra table do not discard valid courses',
    () async {
      final raw = coursePlan().toJson();
      raw['hint'] = {'nodeId': 'invented-node', 'label': 'Open courses'};
      (raw['tables'] as List).add({
        'nodeId': 'invented-table',
        'kind': 'courses',
        'columns': {'code': 0, 'title': 1},
      });
      final client = _AnalysisClient(
        (_) async => PortalAnalysisPlan.fromJson(raw),
      );
      final cache = _MemoryCache();
      final controller = _controller(connection, client, cache);
      addTearDown(controller.dispose);
      await controller.capture(snapshot('Algorithms'));
      expect(controller.state.phase, PortalSyncPhase.review);
      expect(controller.state.draft!.courses.single.title, 'Algorithms');
      expect(controller.state.hintNodeId, isNull);
      await controller.capture(snapshot('Updated title'));
      expect(client.calls, 1);
      expect(cache.writes, 1);
      expect(controller.state.draft!.courses.single.title, 'Updated title');
    },
  );

  test(
    'rejected mappings log a safe reason and preserve the existing review',
    () async {
      final logs = <String>[];
      final previousPrint = debugPrint;
      debugPrint = (message, {wrapWidth}) {
        if (message != null) logs.add(message);
      };
      addTearDown(() => debugPrint = previousPrint);
      var calls = 0;
      final client = _AnalysisClient((_) async {
        calls++;
        return calls == 1
            ? coursePlan()
            : PortalAnalysisPlan.fromJson({
                'pageType': 'courses',
                'tables': [
                  {
                    'nodeId': 'table-1',
                    'kind': 'courses',
                    'columns': {'code': 0, 'title': 9},
                  },
                ],
              });
      });
      final controller = _controller(connection, client, _MemoryCache());
      addTearDown(controller.dispose);
      await controller.capture(snapshot('Private course title'));
      final second = PortalSnapshot.fromJson({
        'origin': connection.origin,
        'path': '/student/next',
        'title': 'Courses',
        'language': 'en',
        'nodes': snapshot('Other private course').nodes
            .map((node) => node.toJson())
            .toList(),
      });
      await controller.capture(second);
      expect(
        controller.state.draft!.courses.single.title,
        'Private course title',
      );
      final output = logs.join('\n');
      expect(output, contains('reason=column_out_of_bounds'));
      expect(output, contains('column=9'));
      expect(output, isNot(contains('Private course title')));
      expect(output, isNot(contains('Other private course')));
      expect(output, isNot(contains('account-a')));
    },
  );

  test('queued capture after pause and resume is processed under the new generation', () async {
    final completion = Completer<PortalAnalysisPlan>();
    final client = _AnalysisClient((_) => completion.future);
    final controller = _controller(connection, client, _MemoryCache());
    final pending = controller.capture(snapshot('Old page'));
    await Future<void>.delayed(Duration.zero);
    controller.pause();
    controller.resume();
    final queued = controller.capture(snapshot('New page'));
    completion.complete(coursePlan());
    await pending;
    await queued;
    await Future<void>.delayed(Duration.zero);
    expect(client.calls, 2);
    expect(controller.state.draft?.courses.single.title, 'New page');
    controller.dispose();
  });

  test('saves only the validated review draft', () async {
    final importer = _RecordingImporter();
    final controller = _controller(
      connection,
      _AnalysisClient((_) async => coursePlan()),
      _MemoryCache(),
      importer: importer,
    );
    await controller.capture(snapshot('Algorithms'));
    await controller.saveDraft();

    expect(importer.saved, isNotNull);
    expect(importer.saved!.isValid, isTrue);
    expect(controller.state.phase, PortalSyncPhase.saved);
    controller.dispose();
  });

  test('capture during save cannot replace the reviewed draft', () async {
    final completion = Completer<PortalImportResult>();
    final importer = _DelayedImporter(completion);
    final controller = _controller(
      connection,
      _AnalysisClient((_) async => coursePlan()),
      _MemoryCache(),
      importer: importer,
    );
    await controller.capture(snapshot('Reviewed course'));
    final saving = controller.saveDraft();
    expect(controller.state.phase, PortalSyncPhase.saving);
    await controller.capture(snapshot('Unreviewed update'));
    expect(controller.state.draft!.courses.single.title, 'Reviewed course');
    completion.complete(
      const PortalImportResult(importedCourses: 1, importedMeetings: 0),
    );
    await saving;
    expect(controller.state.phase, PortalSyncPhase.saved);
    expect(importer.saved!.courses.single.title, 'Reviewed course');
    controller.dispose();
  });

  test('connection change discards accumulated student data', () async {
    final controller = _controller(
      connection,
      _AnalysisClient((_) async => coursePlan()),
      _MemoryCache(),
    );
    await controller.capture(snapshot('Algorithms'));
    controller.setConnection(
      PortalConnection(
        accountId: 'account-b',
        institutionId: 2,
        schoolName: 'Other',
        portalUri: Uri.parse('https://other.example.edu'),
      ),
    );
    expect(controller.state.draft, isNull);
    expect(controller.state.coursesCount, 0);
    expect(controller.state.phase, PortalSyncPhase.idle);
    controller.dispose();
  });
}

PortalSyncController _controller(
  PortalConnection connection,
  PortalAnalysisClient client,
  PortalCacheStore cache, {
  PortalImporter? importer,
}) => PortalSyncController(
  connection: connection,
  analysisClient: client,
  cacheStore: cache,
  usageStore: _Usage(),
  accessPolicy: _Access(),
  importer: importer ?? _RecordingImporter(),
);

class _AnalysisClient implements PortalAnalysisClient {
  _AnalysisClient(this.handler);
  final Future<PortalAnalysisPlan> Function(PortalAnalysisRequest) handler;
  int calls = 0;

  @override
  Future<PortalAnalysisPlan> analyze(PortalAnalysisRequest request) {
    calls++;
    return handler(request);
  }
}

class _MemoryCache implements PortalCacheStore {
  final Map<String, PortalAnalysisPlan> plans = {};
  int writes = 0;
  String _key(
    String account,
    String origin,
    String language,
    String fingerprint,
    String modelVersion,
  ) => '$account|$origin|$language|$fingerprint|$modelVersion';

  @override
  Future<PortalAnalysisPlan?> getPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
  }) async =>
      plans[_key(accountId, origin, language, fingerprint, modelVersion)];

  @override
  Future<void> putPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
    required PortalAnalysisPlan plan,
  }) async {
    writes++;
    plans[_key(accountId, origin, language, fingerprint, modelVersion)] = plan;
  }

  @override
  Future<void> clearAccount(String accountId) async =>
      plans.removeWhere((key, _) => key.startsWith('$accountId|'));
}

class _Usage implements PortalUsageStore {
  int attempts = 0;
  @override
  Future<bool> canAttempt(String accountId, {DateTime? now}) async =>
      attempts < 4;
  @override
  Future<void> recordAttempt(String accountId, {DateTime? now}) async =>
      attempts++;
  @override
  Future<void> markSetupComplete(String accountId) async {}
  @override
  Future<void> clearAccount(String accountId) async {}
}

class _Access implements PortalAccessPolicy {
  @override
  Future<bool> canAnalyze() async => true;
}

class _RecordingImporter implements PortalImporter {
  PortalDraft? saved;
  @override
  Future<PortalImportResult> importDraft(PortalDraft draft) async {
    saved = draft;
    return const PortalImportResult(importedCourses: 1, importedMeetings: 0);
  }
}

class _DelayedImporter implements PortalImporter {
  _DelayedImporter(this.completion);
  final Completer<PortalImportResult> completion;
  PortalDraft? saved;

  @override
  Future<PortalImportResult> importDraft(PortalDraft draft) {
    saved = draft;
    return completion.future;
  }
}
