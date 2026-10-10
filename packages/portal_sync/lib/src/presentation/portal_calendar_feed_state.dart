import '../domain/entities/portal_calendar_draft.dart';

enum PortalCalendarFeedPhase {
  idle,
  fetching,
  needsReview,
  importing,
  imported,
  blocked,
  error,
}

class PortalCalendarFeedState {
  const PortalCalendarFeedState({
    required this.phase,
    this.draft,
    this.message,
    this.error,
    this.importedDeadlines = 0,
    this.heldForReview = 0,
  });

  final PortalCalendarFeedPhase phase;
  final PortalCalendarDraft? draft;
  final String? message;
  final String? error;
  final int importedDeadlines;
  final int heldForReview;

  bool get isBusy =>
      phase == PortalCalendarFeedPhase.fetching ||
      phase == PortalCalendarFeedPhase.importing;

  PortalCalendarFeedState copyWith({
    PortalCalendarFeedPhase? phase,
    PortalCalendarDraft? draft,
    bool clearDraft = false,
    String? message,
    String? error,
    bool clearError = false,
    int? importedDeadlines,
    int? heldForReview,
  }) => PortalCalendarFeedState(
    phase: phase ?? this.phase,
    draft: clearDraft ? null : draft ?? this.draft,
    message: message ?? this.message,
    error: clearError ? null : error ?? this.error,
    importedDeadlines: importedDeadlines ?? this.importedDeadlines,
    heldForReview: heldForReview ?? this.heldForReview,
  );
}
