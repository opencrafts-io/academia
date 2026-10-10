import 'dart:async';

import 'package:flutter/foundation.dart';

import '../diagnostics/portal_debug_log.dart';
import '../domain/entities/portal_analysis_plan.dart';
import '../domain/entities/portal_connection.dart';
import '../domain/entities/portal_draft_extractor.dart' show PortalCapture;
import '../domain/entities/portal_profile_fee_draft_extractor.dart';
import '../domain/entities/portal_snapshot.dart';
import '../domain/repositories/portal_sync_repositories.dart';
import 'portal_profile_fee_state.dart';

/// Capture/analysis/review/save controller for the profile and
/// fee_statement page categories, mirroring `PortalSyncController`'s
/// courses/timetable flow at a smaller scope: no pause/resume/retry
/// bookkeeping yet, and captures of the same page path are replaced rather
/// than merged row-group by row-group. See `docs/portal-sync-internal.md`
/// for what remains open on this controller.
class PortalProfileFeeController extends ChangeNotifier {
  PortalProfileFeeController({
    required this._connection,
    required this.inferenceGateway,
    required this.cacheStore,
    required this.usageStore,
    required this.accessPolicy,
    required this.importer,
    this._extractor = const PortalProfileFeeDraftExtractor(),
    this.modelVersion = 'gemini-3.8-flash',
  });

  /// The same adapter seam the courses/timetable controller uses, so a future
  /// server-verified gateway covers profile/fee analysis too rather than
  /// leaving it on an unenforced parallel path.
  final PortalInferenceGateway inferenceGateway;
  final PortalCacheStore cacheStore;
  final PortalUsageStore usageStore;
  final PortalAccessPolicy accessPolicy;
  final PortalProfileFeeImporter importer;
  final PortalProfileFeeDraftExtractor _extractor;
  final String modelVersion;

  PortalConnection _connection;
  PortalConnection get connection => _connection;
  PortalProfileFeeState _state = const PortalProfileFeeState(
    phase: PortalProfileFeePhase.idle,
  );
  PortalProfileFeeState get state => _state;

  final List<PortalCapture> _captures = [];
  Future<void>? _captureFuture;
  PortalSnapshot? _queuedSnapshot;
  int _generation = 0;
  bool _disposed = false;
  bool get isDisposed => _disposed;

  static const int maxCapturedPages = 20;

  static final RegExp _authPattern = RegExp(
    r'(^|[/\s_-])(log\s*in|sign\s*in|oauth|authorize|password|passcode|mfa|two-factor)([/\s_-]|$)',
    caseSensitive: false,
  );

  void _emit(PortalProfileFeeState state) {
    if (_disposed) return;
    _state = state;
    notifyListeners();
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  Future<void> capture(PortalSnapshot snapshot) {
    if (_disposed || _state.phase == PortalProfileFeePhase.saving) {
      return Future.value();
    }
    if (snapshot.origin != _connection.origin) {
      _emit(
        _state.copyWith(
          phase: PortalProfileFeePhase.blocked,
          error: 'This page is outside the connected portal origin.',
          isBusy: false,
        ),
      );
      return Future.value();
    }
    final current = _captureFuture;
    if (current != null) {
      _queuedSnapshot = snapshot;
      return current;
    }
    final generation = _generation;
    final future = _captureLoop(snapshot, generation);
    _captureFuture = future;
    return future.whenComplete(() {
      if (identical(_captureFuture, future)) _captureFuture = null;
      final queued = _queuedSnapshot;
      _queuedSnapshot = null;
      if (queued != null && !_disposed) unawaited(capture(queued));
    });
  }

  Future<void> _captureLoop(PortalSnapshot first, int generation) async {
    var current = first;
    while (_isCurrent(generation)) {
      _queuedSnapshot = null;
      await _process(current, generation);
      final queued = _queuedSnapshot;
      if (queued == null) break;
      current = queued;
    }
  }

  bool _isAuthenticationPage(PortalSnapshot snapshot) {
    final text =
        '${snapshot.path} ${snapshot.title} ${snapshot.nodes.map((n) => n.label).join(' ')}';
    return _authPattern.hasMatch(text) ||
        RegExp(
          r'\b(password|passcode|one-time code)\b',
          caseSensitive: false,
        ).hasMatch(text);
  }

  Future<void> _process(PortalSnapshot snapshot, int generation) async {
    if (_isAuthenticationPage(snapshot)) {
      _emit(
        _state.copyWith(
          phase: PortalProfileFeePhase.blocked,
          message: 'Sign in to your portal in the browser, then continue on your profile or fee page.',
          clearError: true,
          isBusy: false,
        ),
      );
      return;
    }
    bool allowed;
    try {
      allowed = await accessPolicy.canAnalyze();
    } catch (error, stack) {
      portalDebugLog('access.failed', error: error, stackTrace: stack);
      allowed = false;
    }
    if (!_isCurrent(generation)) return;
    if (!allowed) {
      _emit(
        _state.copyWith(
          phase: PortalProfileFeePhase.blocked,
          message: 'Portal analysis is not available for this account.',
          isBusy: false,
        ),
      );
      return;
    }
    _emit(
      _state.copyWith(
        phase: PortalProfileFeePhase.observing,
        isBusy: true,
        clearError: true,
      ),
    );
    final cacheArgs = (
      accountId: _connection.accountId,
      origin: snapshot.origin,
      language: snapshot.language,
      fingerprint: snapshot.structuralFingerprint,
      modelVersion: modelVersion,
    );
    PortalAnalysisPlan? plan;
    var fromCache = false;
    try {
      plan = await cacheStore.getPlan(
        accountId: cacheArgs.accountId,
        origin: cacheArgs.origin,
        language: cacheArgs.language,
        fingerprint: cacheArgs.fingerprint,
        modelVersion: cacheArgs.modelVersion,
      );
    } catch (error, stack) {
      portalDebugLog('cache.read_failed', error: error, stackTrace: stack);
    }
    if (!_isCurrent(generation)) return;
    if (plan != null && plan.validateFor(snapshot)) {
      fromCache = true;
    } else {
      plan = null;
    }
    if (plan == null) {
      bool usageAllowed;
      try {
        usageAllowed = await usageStore.canAttempt(_connection.accountId);
      } catch (error, stack) {
        portalDebugLog('usage.check_failed', error: error, stackTrace: stack);
        usageAllowed = false;
      }
      if (!_isCurrent(generation)) return;
      if (!usageAllowed) {
        _emit(
          _state.copyWith(
            phase: PortalProfileFeePhase.blocked,
            message: 'The local portal analysis limit has been reached. Try again later.',
            isBusy: false,
          ),
        );
        return;
      }
      try {
        await usageStore.recordAttempt(_connection.accountId);
        if (!_isCurrent(generation)) return;
      } catch (error, stack) {
        portalDebugLog('usage.record_failed', error: error, stackTrace: stack);
        if (_isCurrent(generation)) {
          _emit(
            _state.copyWith(
              phase: PortalProfileFeePhase.blocked,
              message: 'Local usage limits are unavailable, so analysis is paused.',
              isBusy: false,
            ),
          );
        }
        return;
      }
      PortalInferenceOutcome outcome;
      try {
        portalDebugLog('profile_fee.analysis.started', model: modelVersion);
        outcome = await inferenceGateway
            .analyze(
              PortalInferenceRequest(
                accountId: _connection.accountId,
                budgetKey: _budgetKey(snapshot),
                structuralContent: snapshot.toAnalysisJson(),
                modelVersion: modelVersion,
              ),
            )
            .timeout(const Duration(seconds: 30));
      } catch (error, stack) {
        portalDebugLog(
          'profile_fee.analysis.failed',
          model: modelVersion,
          error: error,
          stackTrace: stack,
        );
        if (_isCurrent(generation)) {
          _emit(
            _state.copyWith(
              phase: PortalProfileFeePhase.error,
              error: 'Could not analyze this page.',
              isBusy: false,
            ),
          );
        }
        return;
      }
      if (!_isCurrent(generation)) return;
      if (outcome is PortalInferenceRejected) {
        // A typed, non-exceptional rejection from a server-verified gateway.
        // Today's direct Firebase client never produces this branch; it has
        // no server-side entitlement or allowance check to reject against.
        portalDebugLog(
          'profile_fee.inference.rejected reason=${outcome.reason.name}',
          model: modelVersion,
        );
        _emit(
          _state.copyWith(
            phase: PortalProfileFeePhase.blocked,
            message: outcome.message ?? _rejectionMessage(outcome.reason),
            isBusy: false,
          ),
        );
        return;
      }
      plan = (outcome as PortalInferenceSuccess).plan;
      final failure = plan.validationFailureFor(snapshot);
      if (failure != null) {
        final adjusted = plan.supportedSubsetFor(snapshot);
        if (adjusted.validateFor(snapshot)) {
          portalDebugLog(
            'profile_fee.analysis.mapping_adjusted reason=$failure',
            model: modelVersion,
          );
          plan = adjusted;
        } else {
          portalDebugLog(
            'profile_fee.analysis.validation_failed reason=$failure',
            model: modelVersion,
          );
          _emit(
            _state.copyWith(
              phase: PortalProfileFeePhase.error,
              error: 'This page could not be mapped reliably.',
              isBusy: false,
            ),
          );
          return;
        }
      }
      portalDebugLog('profile_fee.analysis.succeeded', model: modelVersion);
      try {
        await cacheStore.putPlan(
          accountId: cacheArgs.accountId,
          origin: cacheArgs.origin,
          language: cacheArgs.language,
          fingerprint: cacheArgs.fingerprint,
          modelVersion: cacheArgs.modelVersion,
          plan: plan,
        );
      } catch (error, stack) {
        portalDebugLog('cache.write_failed', error: error, stackTrace: stack);
      }
      if (!_isCurrent(generation)) return;
    }
    final chosen = plan;
    final existingIndex = _captures.indexWhere(
      (capture) => capture.$1.path == snapshot.path,
    );
    if (existingIndex == -1) {
      if (_captures.length >= maxCapturedPages) {
        _emit(
          _state.copyWith(
            phase: PortalProfileFeePhase.error,
            error: 'This capture reached the page limit. Review or save, then start again.',
            isBusy: false,
          ),
        );
        return;
      }
      _captures.add((snapshot, chosen));
    } else {
      _captures[existingIndex] = (snapshot, chosen);
    }
    final draft = _extractor.extract(_connection, _captures);
    _emit(
      _state.copyWith(
        phase: draft == null
            ? PortalProfileFeePhase.observing
            : PortalProfileFeePhase.review,
        draft: draft,
        clearDraft: draft == null,
        profileFieldsCount: draft?.profileFields.length ?? 0,
        feeLineItemsCount: draft?.feeLineItems.length ?? 0,
        fromCache: fromCache,
        message: draft == null
            ? 'Open your profile or fee statement page to continue.'
            : 'Review the detected profile fields and fee statement.',
        isBusy: false,
        clearError: true,
      ),
    );
  }

  void setConnection(PortalConnection connection) {
    if (_disposed) return;
    _generation++;
    _queuedSnapshot = null;
    _captures.clear();
    _connection = connection;
    _emit(
      const PortalProfileFeeState(
        phase: PortalProfileFeePhase.idle,
        message: 'Connected portal changed.',
      ),
    );
  }

  Future<void> saveDraft() async {
    if (_disposed || _state.isBusy) return;
    final draft = _state.draft;
    if (draft == null || !draft.isValid) {
      _emit(
        _state.copyWith(
          phase: PortalProfileFeePhase.error,
          error: 'There are no validated records to save.',
          isBusy: false,
        ),
      );
      return;
    }
    final generation = _generation;
    _emit(
      _state.copyWith(
        phase: PortalProfileFeePhase.saving,
        message: 'Saving reviewed records',
        isBusy: true,
        clearError: true,
      ),
    );
    try {
      final result = await importer.importProfileFeeDraft(draft);
      if (!_isCurrent(generation)) return;
      _emit(
        _state.copyWith(
          phase: PortalProfileFeePhase.saved,
          message:
              result.message ??
              'Saved ${result.importedProfileFields} profile fields and ${result.importedFeeLineItems} fee line items.',
          isBusy: false,
        ),
      );
    } catch (error, stack) {
      portalDebugLog('profile_fee.import.failed', error: error, stackTrace: stack);
      if (_isCurrent(generation)) {
        _emit(
          _state.copyWith(
            phase: PortalProfileFeePhase.error,
            error: 'Could not save these records. Your review is still available.',
            isBusy: false,
          ),
        );
      }
    }
  }

  void discard() {
    if (_disposed) return;
    _captures.clear();
    _emit(
      _state.copyWith(
        phase: PortalProfileFeePhase.observing,
        clearDraft: true,
        profileFieldsCount: 0,
        feeLineItemsCount: 0,
        message: 'Review discarded.',
        isBusy: false,
      ),
    );
  }

  String _rejectionMessage(PortalInferenceRejectionReason reason) =>
      reason.studentMessage;

  /// Stable per-request key a server-side atomic reservation would key its
  /// allowance decrement on: account, connection, and content fingerprint.
  /// Today's direct client ignores this; it is here so the request shape
  /// already matches what a callable gateway needs.
  String _budgetKey(PortalSnapshot snapshot) => [
    _connection.accountId,
    _connection.institutionId,
    snapshot.origin,
    snapshot.structuralFingerprint,
    modelVersion,
    PortalAnalysisPlan.promptVersion,
  ].join('|');

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _queuedSnapshot = null;
    _captures.clear();
    super.dispose();
  }
}
