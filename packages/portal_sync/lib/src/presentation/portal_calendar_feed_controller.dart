import 'package:flutter/foundation.dart';

import '../data/datasources/ics_calendar_parser.dart';
import '../data/datasources/ics_feed_fetcher.dart';
import '../diagnostics/portal_debug_log.dart';
import '../domain/entities/portal_calendar_draft.dart';
import '../domain/repositories/portal_sync_repositories.dart';
import 'portal_calendar_feed_state.dart';

/// Drives the calendar-subscription import path: fetch a student-supplied
/// `.ics` feed URL under hard SSRF guardrails, parse it, classify events
/// along the existing agenda/task boundary, and import the deadline-shaped
/// ones. This never calls the model and does not share the portal-sync
/// Gemini usage allowance — only the document/image fallback does that.
///
/// The feed URL itself is never retained on this controller once fetched
/// and never appears in any emitted [PortalCalendarFeedState] or debug log.
class PortalCalendarFeedController extends ChangeNotifier {
  PortalCalendarFeedController({
    required this.fetcher,
    required this.accountId,
    this.importer,
  });

  final IcsFeedFetcher fetcher;
  final String accountId;
  final PortalCalendarImporter? importer;

  PortalCalendarFeedState _state = const PortalCalendarFeedState(
    phase: PortalCalendarFeedPhase.idle,
  );
  PortalCalendarFeedState get state => _state;

  bool _disposed = false;
  int _generation = 0;

  void _emit(PortalCalendarFeedState state) {
    if (_disposed) return;
    _state = state;
    notifyListeners();
  }

  /// Fetches, parses, and classifies [feedUrl]. [feedUrl] is read once and
  /// never stored on this controller or logged; only safe reason codes are
  /// logged on failure.
  Future<void> loadFeed(Uri feedUrl) async {
    if (_disposed || _state.isBusy) return;
    final generation = ++_generation;
    _emit(
      const PortalCalendarFeedState(
        phase: PortalCalendarFeedPhase.fetching,
        message: 'Checking your calendar feed',
      ),
    );
    String text;
    try {
      text = await fetcher.fetchIcsText(feedUrl);
    } catch (error, stack) {
      portalDebugLog(
        'calendar_feed.fetch_failed',
        error: error,
        stackTrace: stack,
      );
      if (generation != _generation || _disposed) return;
      _emit(
        PortalCalendarFeedState(
          phase: PortalCalendarFeedPhase.error,
          error: _friendlyFetchError(error),
        ),
      );
      return;
    }
    if (generation != _generation || _disposed) return;
    IcsParsedCalendar parsed;
    try {
      parsed = IcsCalendarParser.parse(text);
    } catch (error, stack) {
      portalDebugLog(
        'calendar_feed.parse_failed',
        error: error,
        stackTrace: stack,
      );
      if (generation != _generation || _disposed) return;
      _emit(
        const PortalCalendarFeedState(
          phase: PortalCalendarFeedPhase.error,
          error: 'This does not look like a valid calendar feed.',
        ),
      );
      return;
    }
    final draft = buildPortalCalendarDraft(
      events: parsed.events,
      accountId: accountId,
      feedUrl: feedUrl,
    );
    portalDebugLog(
      'calendar_feed.classified '
      'classMeetings=${draft.classMeetings.length} '
      'deadlines=${draft.deadlines.length} '
      'needsReview=${draft.needsReview.length}',
    );
    _emit(
      PortalCalendarFeedState(
        phase: PortalCalendarFeedPhase.needsReview,
        draft: draft,
        message: draft.totalEvents == 0
            ? 'No events were found in this feed.'
            : 'Review the detected events before importing.',
      ),
    );
  }

  /// Imports the deadline-shaped events from the current draft through the
  /// injected [importer]. Class-meeting-shaped and ambiguous events are
  /// never imported automatically; they remain in the draft for the
  /// student to review and link manually.
  Future<void> importDeadlines() async {
    final draft = _state.draft;
    final activeImporter = importer;
    if (_disposed || _state.isBusy || draft == null || activeImporter == null) {
      return;
    }
    final generation = _generation;
    _emit(
      _state.copyWith(
        phase: PortalCalendarFeedPhase.importing,
        message: 'Saving deadlines',
        clearError: true,
      ),
    );
    try {
      final result = await activeImporter.importCalendarDraft(draft);
      if (generation != _generation || _disposed) return;
      _emit(
        _state.copyWith(
          phase: PortalCalendarFeedPhase.imported,
          importedDeadlines: result.importedDeadlines,
          heldForReview: result.heldForReview,
          message:
              result.message ??
              'Saved ${result.importedDeadlines} deadlines. '
                  '${result.heldForReview} events need your review.',
        ),
      );
    } catch (error, stack) {
      portalDebugLog(
        'calendar_feed.import_failed',
        error: error,
        stackTrace: stack,
      );
      if (generation != _generation || _disposed) return;
      _emit(
        _state.copyWith(
          phase: PortalCalendarFeedPhase.error,
          error:
              'Could not save these deadlines. Your review is still available.',
        ),
      );
    }
  }

  void discard() {
    if (_disposed) return;
    _generation++;
    _emit(const PortalCalendarFeedState(phase: PortalCalendarFeedPhase.idle));
  }

  String _friendlyFetchError(Object error) {
    final reason = error is IcsFeedFetchException ? error.reasonCode : null;
    return switch (reason) {
      'scheme_not_allowed' ||
      'host_not_allowed' ||
      'host_missing' ||
      'user_info_not_allowed' => 'This feed address is not supported. Use the HTTPS calendar link from your school.',
      'response_too_large' => 'This calendar feed is too large to import.',
      'timeout' => 'The calendar feed took too long to respond.',
      'too_many_redirects' ||
      'invalid_redirect' ||
      'redirect_missing_location' =>
        'This calendar link could not be followed safely.',
      _ =>
        'Could not reach this calendar feed. Check the address and try again.',
    };
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
