import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  final connection = PortalConnection(
    accountId: 'account-a',
    institutionId: 9,
    schoolName: 'Example University',
    portalUri: Uri.parse('https://portal.example.edu'),
  );

  PortalSnapshot feeSnapshot() => PortalSnapshot.fromJson({
    'origin': 'https://portal.example.edu',
    'path': '/fees',
    'title': 'Fee statement',
    'language': 'en',
    'nodes': [
      {
        'id': 'fee-table',
        'kind': 'table',
        'label': 'Fee statement',
        'headers': ['Description', 'Debit', 'Credit', 'Balance', 'Currency'],
        'rows': [
          ['Tuition fee', '1,500,000', '', '', 'UGX'],
        ],
      },
    ],
  });

  PortalAnalysisPlan feePlan() => PortalAnalysisPlan.fromJson({
    'pageType': 'feeStatement',
    'tables': [
      {
        'nodeId': 'fee-table',
        'kind': 'feeLineItems',
        'columns': {
          'description': 0,
          'debit': 1,
          'credit': 2,
          'balance': 3,
          'currency': 4,
        },
      },
    ],
  });

  test('a new page triggers analysis, validates and reaches review', () async {
    final client = _AnalysisClient((_) async => feePlan());
    final controller = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: client,
      cacheStore: _MemoryCache(),
      usageStore: _Usage(),
      accessPolicy: _Access(),
      importer: _RecordingImporter(),
    );
    await controller.capture(feeSnapshot());
    expect(client.calls, 1);
    expect(controller.state.phase, PortalProfileFeePhase.review);
    expect(controller.state.feeLineItemsCount, 1);
    controller.dispose();
  });

  test('a cached validated plan is reused without a second model call', () async {
    final client = _AnalysisClient((_) async => feePlan());
    final cache = _MemoryCache();
    final controllerOne = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: client,
      cacheStore: cache,
      usageStore: _Usage(),
      accessPolicy: _Access(),
      importer: _RecordingImporter(),
    );
    await controllerOne.capture(feeSnapshot());
    controllerOne.dispose();

    final controllerTwo = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: client,
      cacheStore: cache,
      usageStore: _Usage(),
      accessPolicy: _Access(),
      importer: _RecordingImporter(),
    );
    await controllerTwo.capture(feeSnapshot());
    expect(client.calls, 1);
    expect(controllerTwo.state.fromCache, isTrue);
    controllerTwo.dispose();
  });

  test('saves only the validated review draft', () async {
    final importer = _RecordingImporter();
    final controller = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: _AnalysisClient((_) async => feePlan()),
      cacheStore: _MemoryCache(),
      usageStore: _Usage(),
      accessPolicy: _Access(),
      importer: importer,
    );
    await controller.capture(feeSnapshot());
    await controller.saveDraft();
    expect(importer.saved, isNotNull);
    expect(controller.state.phase, PortalProfileFeePhase.saved);
    controller.dispose();
  });

  test('discard clears the draft and resumes observing', () async {
    final controller = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: _AnalysisClient((_) async => feePlan()),
      cacheStore: _MemoryCache(),
      usageStore: _Usage(),
      accessPolicy: _Access(),
      importer: _RecordingImporter(),
    );
    await controller.capture(feeSnapshot());
    controller.discard();
    expect(controller.state.draft, isNull);
    expect(controller.state.phase, PortalProfileFeePhase.observing);
    controller.dispose();
  });

  test('access denial blocks analysis', () async {
    final controller = PortalProfileFeeController(
      connection: connection,
      inferenceGateway: _AnalysisClient((_) async => feePlan()),
      cacheStore: _MemoryCache(),
      usageStore: _Usage(),
      accessPolicy: _Access(allowed: false),
      importer: _RecordingImporter(),
    );
    await controller.capture(feeSnapshot());
    expect(controller.state.phase, PortalProfileFeePhase.blocked);
    controller.dispose();
  });
}

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
  }) async => plans[_key(accountId, origin, language, fingerprint, modelVersion)];

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
  @override
  Future<bool> canAttempt(String accountId, {DateTime? now}) async => true;
  @override
  Future<void> recordAttempt(String accountId, {DateTime? now}) async {}
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

class _RecordingImporter implements PortalProfileFeeImporter {
  PortalProfileFeeDraft? saved;

  @override
  Future<PortalProfileFeeImportResult> importProfileFeeDraft(
    PortalProfileFeeDraft draft,
  ) async {
    saved = draft;
    return PortalProfileFeeImportResult(
      importedProfileFields: draft.profileFields.length,
      importedFeeLineItems: draft.feeLineItems.length,
    );
  }
}
