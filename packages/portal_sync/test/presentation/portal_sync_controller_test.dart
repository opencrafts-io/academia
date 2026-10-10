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

  group('inference gateway adapter selection', () {
    test('the controller behaves identically against any PortalInferenceGateway implementation', () async {
      // Stands in for swapping FirebasePortalAnalysisClient for a future
      // CallableInferenceGateway: nothing in the controller changes, only
      // the DI registration of `inferenceGateway`.
      final gatewayA = _AnalysisClient((_) async => coursePlan());
      final controllerA = _controller(connection, gatewayA, _MemoryCache());
      await controllerA.capture(snapshot('Algorithms'));
      expect(controllerA.state.phase, PortalSyncPhase.review);
      expect(controllerA.state.draft?.courses.single.title, 'Algorithms');
      controllerA.dispose();

      final gatewayB = _AnalysisClient((_) async => coursePlan());
      final controllerB = _controller(connection, gatewayB, _MemoryCache());
      await controllerB.capture(snapshot('Algorithms'));
      expect(controllerB.state.phase, PortalSyncPhase.review);
      expect(controllerB.state.draft?.courses.single.title, 'Algorithms');
      controllerB.dispose();
    });

    test('the request sent to the gateway carries account identity and a budget key', () async {
      final gateway = _AnalysisClient((_) async => coursePlan());
      final controller = _controller(connection, gateway, _MemoryCache());
      await controller.capture(snapshot('Algorithms'));
      expect(gateway.requests, hasLength(1));
      expect(gateway.requests.single.accountId, connection.accountId);
      expect(gateway.requests.single.budgetKey, isNotEmpty);
      controller.dispose();
    });
  });

  group('typed inference rejection handling', () {
    test('a no-entitlement rejection blocks without being treated as a page failure', () async {
      final gateway = _OutcomeGateway(
        (_) async => const PortalInferenceRejected(
          PortalInferenceRejectionReason.noEntitlement,
        ),
      );
      final controller = _controller(connection, gateway, _MemoryCache());
      await controller.capture(snapshot('Algorithms'));
      expect(controller.state.phase, PortalSyncPhase.blocked);
      expect(controller.state.accessDenied, isTrue);
      expect(controller.state.allowanceExhausted, isFalse);
      // A rejection is not a technical failure: the bounded single-retry
      // counter must not treat it as one.
      await controller.retryAnalysis();
      expect(
        gateway.calls,
        1,
        reason: 'retryAnalysis is a no-op without a prior failed attempt',
      );
      controller.dispose();
    });

    test(
      'an allowance-exhausted rejection is distinguishable from no entitlement',
      () async {
        final gateway = _OutcomeGateway(
          (_) async => const PortalInferenceRejected(
            PortalInferenceRejectionReason.allowanceExhausted,
            message: 'Try again next month.',
          ),
        );
        final controller = _controller(connection, gateway, _MemoryCache());
        await controller.capture(snapshot('Algorithms'));
        expect(controller.state.phase, PortalSyncPhase.blocked);
        expect(controller.state.accessDenied, isFalse);
        expect(controller.state.allowanceExhausted, isTrue);
        expect(controller.state.message, 'Try again next month.');
        controller.dispose();
      },
    );

    test('a later successful capture on the same session clears a prior rejection flag', () async {
      // A single gateway that rejects once, then succeeds — simulating an
      // account regaining allowance (for example, after a period rollover)
      // within one browsing session, without needing a second controller.
      var callCount = 0;
      final gateway = _OutcomeGateway((_) async {
        callCount++;
        if (callCount == 1) {
          return const PortalInferenceRejected(
            PortalInferenceRejectionReason.allowanceExhausted,
          );
        }
        return PortalInferenceSuccess(coursePlan());
      });
      final controller = _controller(connection, gateway, _MemoryCache());

      await controller.capture(snapshot('Algorithms'));
      expect(controller.state.allowanceExhausted, isTrue);
      expect(controller.state.phase, PortalSyncPhase.blocked);

      await controller.capture(snapshot('Algorithms'));
      expect(controller.state.allowanceExhausted, isFalse);
      expect(controller.state.phase, PortalSyncPhase.review);
      expect(callCount, 2);
      controller.dispose();
    });
  });

  group('reconnect does not wait on an abandoned in-flight call', () {
    test('setConnection frees the in-flight slot for the new connection immediately', () async {
      final stuck = Completer<PortalAnalysisPlan>();
      var callCount = 0;
      final gateway = _AnalysisClient((_) {
        callCount++;
        return callCount == 1 ? stuck.future : Future.value(coursePlan());
      });
      final controller = _controller(connection, gateway, _MemoryCache());

      // Starts an analysis that never resolves on its own — simulating a
      // slow/abandoned network call on the old connection.
      final firstCapture = controller.capture(snapshot('Algorithms'));
      await Future<void>.delayed(Duration.zero);
      expect(controller.state.phase, PortalSyncPhase.analyzing);

      final otherConnection = PortalConnection(
        accountId: 'account-b',
        institutionId: 2,
        schoolName: 'Other',
        portalUri: Uri.parse('https://other.example.edu'),
      );
      controller.setConnection(otherConnection);

      final secondCapture = controller.capture(
        PortalSnapshot.fromJson({
          'origin': 'https://other.example.edu',
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
                ['CS101', 'New school course'],
              ],
            },
          ],
        }),
      );
      // The new connection's capture must resolve without waiting on the
      // old connection's still-pending (abandoned) completer. Before the
      // `_captureFuture` reset fix, this would hang until `stuck` completed.
      await secondCapture.timeout(const Duration(seconds: 2));
      expect(controller.state.phase, PortalSyncPhase.review);
      expect(controller.state.draft?.courses.single.title, 'New school course');
      expect(callCount, 2);

      stuck.complete(coursePlan());
      await firstCapture;
      controller.dispose();
    });
  });
}

PortalSyncController _controller(
  PortalConnection connection,
  PortalInferenceGateway client,
  PortalCacheStore cache, {
  PortalImporter? importer,
  PortalUsageStore? usageStore,
  PortalAccessPolicy? accessPolicy,
}) => PortalSyncController(
  connection: connection,
  inferenceGateway: client,
  cacheStore: cache,
  usageStore: usageStore ?? _Usage(),
  accessPolicy: accessPolicy ?? _Access(),
  importer: importer ?? _RecordingImporter(),
);

/// Fake gateway standing in for either adapter in tests: both
/// [FirebasePortalAnalysisClient] and a future [CallableInferenceGateway]
/// implement the exact same [PortalInferenceGateway] contract this fake
/// does, which is what a DI-swap test exercises.
class _AnalysisClient implements PortalInferenceGateway {
  _AnalysisClient(this.handler);
  final Future<PortalAnalysisPlan> Function(PortalInferenceRequest) handler;
  int calls = 0;
  final requests = <PortalInferenceRequest>[];

  @override
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request) async {
    calls++;
    requests.add(request);
    return PortalInferenceSuccess(await handler(request));
  }
}

/// A gateway whose handler controls the outcome directly — success or a
/// typed rejection — for exercising branches [_AnalysisClient] cannot
/// reach, since [_AnalysisClient] always wraps its handler's plan in
/// [PortalInferenceSuccess].
class _OutcomeGateway implements PortalInferenceGateway {
  _OutcomeGateway(this.handler);
  final Future<PortalInferenceOutcome> Function(PortalInferenceRequest) handler;
  int calls = 0;

  @override
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request) {
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
