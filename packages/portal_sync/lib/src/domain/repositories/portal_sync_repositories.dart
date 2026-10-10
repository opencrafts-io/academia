import '../entities/portal_analysis_plan.dart';
import '../entities/portal_calendar_draft.dart';
import '../entities/portal_draft.dart';
import '../entities/portal_inference_outcome.dart';
import '../entities/portal_media_analysis_request.dart';
import '../entities/portal_media_extraction_plan.dart';
import '../entities/portal_media_selection.dart';
import '../entities/portal_profile_fee_draft.dart';

export '../entities/portal_identity_bridge.dart';
export '../entities/portal_inference_outcome.dart';

/// Analysis-adapter seam: the direct Firebase AI Logic client and the
/// server-callable adapter both implement this so swapping between them is
/// a DI registration change, not a rewrite of capture, extraction, review,
/// or import logic. See docs/portal-sync-plan.md, "Package boundaries and
/// migration" and the Phase 3 acceptance gate.
abstract interface class PortalInferenceGateway {
  Future<PortalInferenceOutcome> analyze(PortalInferenceRequest request);
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

abstract interface class PortalProfileFeeImporter {
  Future<PortalProfileFeeImportResult> importProfileFeeDraft(
    PortalProfileFeeDraft draft,
  );
}

/// Result of importing a classified calendar feed draft. Class-meeting-shaped
/// events are never auto-imported (see [PortalCalendarDraft.classMeetings]
/// docs), so [heldForReview] always includes them alongside anything
/// ambiguous; only [importedDeadlines] were actually written.
class PortalCalendarImportResult {
  const PortalCalendarImportResult({
    required this.importedDeadlines,
    required this.heldForReview,
    this.message,
  });

  final int importedDeadlines;
  final int heldForReview;
  final String? message;
}

/// Imports a classified calendar feed draft through the existing
/// agenda/task boundary. Implementations live at the app composition root
/// so this package never depends on `agenda`/`todos` directly.
abstract interface class PortalCalendarImporter {
  Future<PortalCalendarImportResult> importCalendarDraft(
    PortalCalendarDraft draft,
  );
}

/// Analyzes an explicitly selected image or document via Gemini's
/// multimodal input. A separate interface from [PortalAnalysisClient] keeps
/// the DOM-structure contract untouched; [FirebasePortalAnalysisClient]
/// implements both over the same injected Firebase AI Logic SDK instance.
abstract interface class PortalMediaAnalysisClient {
  Future<PortalMediaExtractionPlan> analyzeMedia(
    PortalMediaAnalysisRequest request,
  );
}

/// Obtains an explicitly, student-initiated media selection. Implementations
/// (image_picker/file_picker) live at the app composition root; this keeps
/// portal_sync's own dependency surface unchanged and keeps the selection
/// flow fakeable in tests.
abstract interface class PortalMediaPickerSource {
  Future<PortalMediaSelection?> pickImage();
  Future<PortalMediaSelection?> pickDocument();
}
