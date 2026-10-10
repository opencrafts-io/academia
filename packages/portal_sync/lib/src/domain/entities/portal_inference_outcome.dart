/// Request/response contract shared by every [PortalInferenceGateway]
/// implementation — today's direct Firebase AI Logic client and the future
/// server-verified callable adapter alike. Keeping this contract identical
/// across adapters is what makes swapping the adapter a DI registration
/// change instead of a rewrite of capture, extraction, review, or import
/// logic (see docs/portal-sync-plan.md, "Package boundaries and migration").
library;

import 'portal_analysis_plan.dart';

/// A single bounded analysis request. [structuralContent] is the same
/// reduced, redacted structural description regardless of adapter: node
/// ids, table headers, and coarse cell types, never raw values, screenshots,
/// passwords, or cookies (see docs/portal-sync-plan.md, "Capture and
/// extraction").
class PortalInferenceRequest {
  const PortalInferenceRequest({
    required this.accountId,
    required this.budgetKey,
    required this.structuralContent,
    required this.modelVersion,
  });

  /// The signed-in Academia account this request is attributed to. A
  /// server-verified gateway uses this (via the Verisafe-to-Firebase
  /// identity bridge, once deployed) to resolve the account's entitlement
  /// and remaining allowance before calling the model. Today's direct
  /// client has no server-side entitlement check and ignores this field
  /// beyond passing it through; it is not yet a security boundary.
  final String accountId;

  /// A stable per-request key — account, connection, and content fingerprint
  /// — that a server-side atomic reservation would key its allowance
  /// decrement on (docs/portal-sync-plan.md, "Cost and abuse controls":
  /// "Private analysis results: keyed by account, connection, goal, content
  /// hash, and model and prompt versions"). Today's direct client ignores
  /// this field; it carries no server-side meaning without a deployed
  /// reservation service.
  final String budgetKey;

  final Map<String, Object?> structuralContent;
  final String modelVersion;
}

/// Why a [PortalInferenceGateway] declined to run inference for a request,
/// as opposed to a transient/technical failure (network error, timeout,
/// malformed model output) which callers continue to surface as a thrown
/// exception from [PortalInferenceGateway.analyze].
enum PortalInferenceRejectionReason {
  /// The account has no active entitlement for cloud portal analysis.
  noEntitlement,

  /// The account's request/token allowance for the current period is
  /// exhausted.
  allowanceExhausted,
}

/// Result of a [PortalInferenceGateway.analyze] call that completed without
/// a technical failure: either a usable plan, or a typed, non-exceptional
/// rejection the caller can branch on directly instead of parsing error
/// strings or depending on a specific SDK's exception type.
sealed class PortalInferenceOutcome {
  const PortalInferenceOutcome();
}

class PortalInferenceSuccess extends PortalInferenceOutcome {
  const PortalInferenceSuccess(this.plan);
  final PortalAnalysisPlan plan;
}

class PortalInferenceRejected extends PortalInferenceOutcome {
  const PortalInferenceRejected(this.reason, {this.message});
  final PortalInferenceRejectionReason reason;
  final String? message;
}

/// Student-facing copy for a rejection a gateway did not word itself. Shared
/// by every capture controller so the same rejection never reads differently
/// depending on which page category the student happened to be on.
extension PortalInferenceRejectionCopy on PortalInferenceRejectionReason {
  String get studentMessage => switch (this) {
    PortalInferenceRejectionReason.noEntitlement =>
      'Portal analysis is not available for this account.',
    PortalInferenceRejectionReason.allowanceExhausted =>
      'The portal analysis allowance for this account is used up for now. Try again later.',
  };
}
