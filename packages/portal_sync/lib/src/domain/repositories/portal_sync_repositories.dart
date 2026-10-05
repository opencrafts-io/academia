import '../entities/portal_analysis_plan.dart';
import '../entities/portal_draft.dart';

class PortalAnalysisRequest {
  PortalAnalysisRequest({
    required Map<String, Object?> structuralContent,
    required this.modelVersion,
  }) : structuralContent = Map.unmodifiable(structuralContent);
  final Map<String, Object?> structuralContent;
  final String modelVersion;
}

abstract interface class PortalAnalysisClient {
  Future<PortalAnalysisPlan> analyze(PortalAnalysisRequest request);
}

abstract interface class PortalCacheStore {
  Future<PortalAnalysisPlan?> getPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
  });

  Future<void> putPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
    required PortalAnalysisPlan plan,
  });

  Future<void> clearAccount(String accountId);
}

abstract interface class PortalUsageStore {
  Future<bool> canAttempt(String accountId, {DateTime? now});
  Future<void> recordAttempt(String accountId, {DateTime? now});
  Future<void> markSetupComplete(String accountId);
  Future<void> clearAccount(String accountId);
}

abstract interface class PortalAccessPolicy {
  Future<bool> canAnalyze();
}

abstract interface class PortalImporter {
  Future<PortalImportResult> importDraft(PortalDraft draft);
}
