import '../domain/entities/portal_draft.dart';

enum PortalSyncPhase {
  idle,
  observing,
  analyzing,
  review,
  saving,
  saved,
  paused,
  blocked,
  error,
}

class PortalSyncState {
  const PortalSyncState({
    required this.phase,
    this.message,
    this.draft,
    this.hintNodeId,
    this.hintLabel,
    this.coursesCount = 0,
    this.meetingsCount = 0,
    this.fromCache = false,
    this.error,
    this.accessDenied = false,
    this.allowanceExhausted = false,
    this.isBusy = false,
  });

  final PortalSyncPhase phase;
  final String? message;
  final PortalDraft? draft;
  final String? hintNodeId;
  final String? hintLabel;
  final int coursesCount;
  final int meetingsCount;
  final bool fromCache;
  final String? error;

  /// Set when a server-verified inference gateway rejected a request
  /// because the account has no active entitlement. Distinct from the
  /// pre-existing UI-level [PortalAccessPolicy] billing gate, which sets
  /// this same flag today for the client-side-only subscription check.
  final bool accessDenied;

  /// Set when a server-verified inference gateway rejected a request
  /// because the account's usage allowance for the current period is
  /// exhausted. Distinct from the local, best-effort [PortalUsageStore]
  /// limit (`usage.local_limit_reached`), which blocks before a gateway
  /// call is even attempted.
  final bool allowanceExhausted;
  final bool isBusy;

  PortalSyncState copyWith({
    PortalSyncPhase? phase,
    String? message,
    PortalDraft? draft,
    bool clearDraft = false,
    String? hintNodeId,
    String? hintLabel,
    bool clearHint = false,
    int? coursesCount,
    int? meetingsCount,
    bool? fromCache,
    String? error,
    bool clearError = false,
    bool? accessDenied,
    bool? allowanceExhausted,
    bool? isBusy,
  }) => PortalSyncState(
    phase: phase ?? this.phase,
    message: message ?? this.message,
    draft: clearDraft ? null : draft ?? this.draft,
    hintNodeId: clearHint ? null : hintNodeId ?? this.hintNodeId,
    hintLabel: clearHint ? null : hintLabel ?? this.hintLabel,
    coursesCount: coursesCount ?? this.coursesCount,
    meetingsCount: meetingsCount ?? this.meetingsCount,
    fromCache: fromCache ?? this.fromCache,
    error: clearError ? null : error ?? this.error,
    accessDenied: accessDenied ?? this.accessDenied,
    allowanceExhausted: allowanceExhausted ?? this.allowanceExhausted,
    isBusy: isBusy ?? this.isBusy,
  );
}
