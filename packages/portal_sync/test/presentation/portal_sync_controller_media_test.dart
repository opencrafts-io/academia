import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_connection.dart';
import 'package:portal_sync/src/domain/entities/portal_draft.dart';
import 'package:portal_sync/src/domain/entities/portal_media_analysis_request.dart';
import 'package:portal_sync/src/domain/entities/portal_media_extraction_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_media_selection.dart';
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

  PortalMediaSelection selection() => PortalMediaSelection.validated(
    bytes: Uint8List.fromList([1, 2, 3, 4]),
    mimeType: 'image/jpeg',
    kind: PortalMediaKind.image,
  );

  PortalMediaExtractionPlan mediaPlan({
    String code = 'CS101',
    String title = 'Algorithms',
  }) => PortalMediaExtractionPlan.fromJson({
    'pageType': 'courses',
    'courses': [
      {'code': code, 'title': title},
    ],
    'meetings': [],
  });

  PortalSyncController controller({
    required PortalMediaAnalysisClient? mediaClient,
    required _Usage usage,
    required _Access access,
    PortalImporter? importer,
  }) => PortalSyncController(
    connection: connection,
    inferenceGateway: _UnusedAnalysisClient(),
    cacheStore: _MemoryCache(),
    usageStore: usage,
    accessPolicy: access,
    importer: importer ?? _RecordingImporter(),
    mediaAnalysisClient: mediaClient,
  );

  test(
    'a successful media analysis shares the DOM path usage allowance',
    () async {
      final usage = _Usage();
      final mediaClient = _MediaClient((_) async => mediaPlan());
      final sut = controller(
        mediaClient: mediaClient,
        usage: usage,
        access: _Access(),
      );
      addTearDown(sut.dispose);

      await sut.analyzeMediaFallback(selection());

      expect(usage.canAttemptCalls, 1);
      expect(
        usage.attempts,
        1,
        reason: 'recordAttempt must be called exactly once',
      );
      expect(sut.state.phase, PortalSyncPhase.review);
      expect(sut.state.draft!.courses.single.code, 'CS101');
    },
  );

  test(
    'the shared usage limit blocks the media path without calling the model',
    () async {
      final usage = _Usage(limit: 0);
      final mediaClient = _MediaClient((_) async {
        fail('The model must not be called once the shared limit is reached.');
      });
      final sut = controller(
        mediaClient: mediaClient,
        usage: usage,
        access: _Access(),
      );
      addTearDown(sut.dispose);

      await sut.analyzeMediaFallback(selection());

      expect(sut.state.phase, PortalSyncPhase.blocked);
      expect(usage.attempts, 0);
    },
  );

  test(
    'a failed call to the provider still counts as a used attempt',
    () async {
      final usage = _Usage();
      final mediaClient = _MediaClient(
        (_) async => throw StateError('provider failure'),
      );
      final sut = controller(
        mediaClient: mediaClient,
        usage: usage,
        access: _Access(),
      );
      addTearDown(sut.dispose);

      await sut.analyzeMediaFallback(selection());

      expect(usage.attempts, 1);
      expect(sut.state.phase, PortalSyncPhase.error);
    },
  );

  test(
    'access policy denial blocks the media path before spending usage',
    () async {
      final usage = _Usage();
      final mediaClient = _MediaClient((_) async {
        fail('The model must not be called when access is denied.');
      });
      final sut = controller(
        mediaClient: mediaClient,
        usage: usage,
        access: _Access(allowed: false),
      );
      addTearDown(sut.dispose);

      await sut.analyzeMediaFallback(selection());

      expect(sut.state.phase, PortalSyncPhase.blocked);
      expect(sut.state.accessDenied, isTrue);
      expect(usage.attempts, 0);
    },
  );

  test('is a no-op when no media analysis client was injected', () async {
    final usage = _Usage();
    final sut = controller(mediaClient: null, usage: usage, access: _Access());
    addTearDown(sut.dispose);

    await sut.analyzeMediaFallback(selection());

    expect(usage.attempts, 0);
    expect(sut.state.phase, PortalSyncPhase.idle);
  });

  test(
    'an on-device DOM value is kept over a media-extracted duplicate',
    () async {
      final usage = _Usage();
      final mediaClient = _MediaClient(
        (_) async => mediaPlan(code: 'CS101', title: 'From the image'),
      );
      final sut = controller(
        mediaClient: mediaClient,
        usage: usage,
        access: _Access(),
      );
      addTearDown(sut.dispose);

      final domClient = _AnalysisClient(
        (_) async => PortalAnalysisPlan.fromJson({
          'pageType': 'courses',
          'tables': [
            {
              'nodeId': 'table-1',
              'kind': 'courses',
              'columns': {'code': 0, 'title': 1},
            },
          ],
        }),
      );
      final domController = PortalSyncController(
        connection: connection,
        inferenceGateway: domClient,
        cacheStore: _MemoryCache(),
        usageStore: usage,
        accessPolicy: _Access(),
        importer: _RecordingImporter(),
        mediaAnalysisClient: mediaClient,
      );
      addTearDown(domController.dispose);
      await domController.capture(
        PortalSnapshot.fromJson({
          'origin': connection.origin,
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
                ['CS101', 'From the DOM'],
              ],
            },
          ],
        }),
      );
      expect(domController.state.draft!.courses.single.title, 'From the DOM');

      await domController.analyzeMediaFallback(selection());

      expect(domController.state.draft!.courses.single.title, 'From the DOM');
      expect(domController.state.draft!.courses, hasLength(1));
    },
  );
}

class _MediaClient implements PortalMediaAnalysisClient {
  _MediaClient(this.handler);
  final Future<PortalMediaExtractionPlan> Function(PortalMediaAnalysisRequest)
  handler;
  int calls = 0;

  @override
  Future<PortalMediaExtractionPlan> analyzeMedia(
    PortalMediaAnalysisRequest request,
  ) {
    calls++;
    return handler(request);
  }
}

class _AnalysisClient implements PortalInferenceGateway {
  _AnalysisClient(this.handler);
  final Future<PortalAnalysisPlan> Function(PortalInferenceRequest) handler;

  @override
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request) async =>
      PortalInferenceSuccess(await handler(request));
}

class _UnusedAnalysisClient implements PortalInferenceGateway {
  @override
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request) =>
      throw UnimplementedError(
        'The DOM analysis gateway is not used by these tests.',
      );
}

class _MemoryCache implements PortalCacheStore {
  final Map<String, PortalAnalysisPlan> plans = {};
  String _key(String a, String o, String l, String f, String m) =>
      '$a|$o|$l|$f|$m';

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
    plans[_key(accountId, origin, language, fingerprint, modelVersion)] = plan;
  }

  @override
  Future<void> clearAccount(String accountId) async {}
}

class _Usage implements PortalUsageStore {
  _Usage({this.limit = 4});
  final int limit;
  int attempts = 0;
  int canAttemptCalls = 0;

  @override
  Future<bool> canAttempt(String accountId, {DateTime? now}) async {
    canAttemptCalls++;
    return attempts < limit;
  }

  @override
  Future<void> recordAttempt(String accountId, {DateTime? now}) async =>
      attempts++;
  @override
  Future<void> markSetupComplete(String accountId) async {}
  @override
  Future<void> clearAccount(String accountId) async {}
}

class _Access implements PortalAccessPolicy {
  _Access({this.allowed = true});
  final bool allowed;
  @override
  Future<bool> canAnalyze() async => allowed;
}

class _RecordingImporter implements PortalImporter {
  PortalDraft? saved;
  @override
  Future<PortalImportResult> importDraft(PortalDraft draft) async {
    saved = draft;
    return const PortalImportResult(importedCourses: 1, importedMeetings: 0);
  }
}
