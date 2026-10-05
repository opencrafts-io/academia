import 'dart:async';

import 'package:flutter/foundation.dart';

import '../diagnostics/portal_debug_log.dart';
import '../domain/entities/portal_analysis_plan.dart';
import '../domain/entities/portal_connection.dart';
import '../domain/entities/portal_draft_extractor.dart';
import '../domain/entities/portal_snapshot.dart';
import '../domain/repositories/portal_sync_repositories.dart';
import 'portal_sync_state.dart';

class PortalSyncController extends ChangeNotifier {
  PortalSyncController({
    required this._connection,
    required this.analysisClient,
    required this.cacheStore,
    required this.usageStore,
    required this.accessPolicy,
    required this.importer,
    this._extractor = const PortalDraftExtractor(),
    this.modelVersion = 'gemini-3.8-flash',
  });

  final PortalAnalysisClient analysisClient;
  final PortalCacheStore cacheStore;
  final PortalUsageStore usageStore;
  final PortalAccessPolicy accessPolicy;
  final PortalImporter importer;
  final PortalDraftExtractor _extractor;
  final String modelVersion;

  PortalConnection _connection;
  PortalConnection get connection => _connection;
  PortalSyncState _state = const PortalSyncState(phase: PortalSyncPhase.idle);
  PortalSyncState get state => _state;

  final List<PortalCapture> _captures = [];
  Future<void>? _captureFuture;
  PortalSnapshot? _queuedSnapshot;
  int _generation = 0;
  bool _paused = false;
  bool _stopped = false;
  PortalSnapshot? _lastSnapshot;
  final Map<String, int> _failedAttempts = {};
  final Set<String> _explicitRetryFingerprints = {};

  static final RegExp _authPattern = RegExp(
    r'(^|[/\s_-])(log\s*in|sign\s*in|oauth|authorize|password|passcode|mfa|two-factor)([/\s_-]|$)',
    caseSensitive: false,
  );

  void _emit(PortalSyncState state) {
    if (isDisposed) return;
    _state = state;
    notifyListeners();
  }

  bool _disposed = false;
  bool get isDisposed => _disposed;

  Future<void> capture(PortalSnapshot snapshot) {
    if (_disposed) return Future.value();
    if (_paused || _stopped || _state.phase == PortalSyncPhase.saving) {
      return Future.value();
    }
    if (snapshot.origin != _connection.origin) {
      _emit(
        _state.copyWith(
          phase: PortalSyncPhase.blocked,
          error: 'This page is outside the connected portal origin.',
          isBusy: false,
        ),
      );
      return Future.value();
    }
    _lastSnapshot = snapshot;
    final fingerprint = snapshot.structuralFingerprint;
    final failedAttempts = _failedAttempts[fingerprint] ?? 0;
    if (failedAttempts > 0 &&
        !_explicitRetryFingerprints.contains(fingerprint)) {
      _emit(
        _state.copyWith(
          phase: PortalSyncPhase.error,
          error: failedAttempts >= 2
              ? 'Analysis failed twice for this page structure. Change pages or reconnect before trying again.'
              : 'This page already failed once. Retry explicitly or continue browsing.',
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
    if (failedAttempts > 0) _explicitRetryFingerprints.remove(fingerprint);
    final generation = _generation;
    final future = _captureLoop(snapshot, generation);
    _captureFuture = future;
    return future.whenComplete(() {
      if (identical(_captureFuture, future)) _captureFuture = null;
      final queued = _queuedSnapshot;
      _queuedSnapshot = null;
      if (queued != null && !_paused && !_stopped && !_disposed) {
        unawaited(capture(queued));
      }
    });
  }

  Future<void> _captureLoop(PortalSnapshot first, int generation) async {
    var current = first;
    while (_isCurrent(generation) && !_paused && !_stopped) {
      _queuedSnapshot = null;
      await _process(current, generation);
      final queued = _queuedSnapshot;
      if (queued == null) break;
      current = queued;
    }
  }

  Future<void> _process(PortalSnapshot snapshot, int generation) async {
    if (_isAuthenticationPage(snapshot)) {
      _emit(
        _state.copyWith(
          phase: PortalSyncPhase.blocked,
          message: 'Sign in to your portal in the browser, then continue on an academic page.',
          error: null,
          clearError: true,
          accessDenied: false,
          isBusy: false,
        ),
      );
      return;
    }
    final keyPath = snapshot.path;
    var allowed = false;
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
          phase: PortalSyncPhase.blocked,
          message: 'Portal analysis is not available for this account.',
          accessDenied: true,
          isBusy: false,
        ),
      );
      return;
    }
    final cacheArgs = (
      accountId: _connection.accountId,
      origin: snapshot.origin,
      language: snapshot.language,
      fingerprint: snapshot.structuralFingerprint,
      modelVersion: modelVersion,
    );
    _emit(
      _state.copyWith(
        phase: PortalSyncPhase.observing,
        isBusy: true,
        clearError: true,
        accessDenied: false,
      ),
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
      // A broken cache must not block a fresh, bounded analysis.
    }
    if (!_isCurrent(generation)) return;
    if (plan != null && plan.validateFor(snapshot)) {
      fromCache = true;
      portalDebugLog('analysis.cache_hit', model: modelVersion);
    } else {
      plan = null;
    }
    if (plan == null) {
      var usageAllowed = false;
      try {
        usageAllowed = await usageStore.canAttempt(_connection.accountId);
      } catch (error, stack) {
        portalDebugLog('usage.check_failed', error: error, stackTrace: stack);
        usageAllowed = false;
      }
      if (!_isCurrent(generation)) return;
      if (!usageAllowed) {
        portalDebugLog('usage.local_limit_reached');
        _emit(
          _state.copyWith(
            phase: PortalSyncPhase.blocked,
            message: 'The local portal analysis limit has been reached. Try again later.',
            accessDenied: false,
            isBusy: false,
          ),
        );
        return;
      }
      _emit(
        _state.copyWith(
          phase: PortalSyncPhase.analyzing,
          message: 'Learning this page structure',
          isBusy: true,
        ),
      );
      try {
        // Count once the provider call is actually about to be made. Failures
        // and timeouts are model attempts too. A timeout bounds the coalescing
        // window even when the SDK request itself cannot be cancelled.
        await usageStore.recordAttempt(_connection.accountId);
        if (!_isCurrent(generation)) return;
      } catch (error, stack) {
        portalDebugLog('usage.record_failed', error: error, stackTrace: stack);
        if (_isCurrent(generation)) {
          _emit(
            _state.copyWith(
              phase: PortalSyncPhase.blocked,
              message:
                  'Local usage limits are unavailable, so analysis is paused.',
              isBusy: false,
            ),
          );
        }
        return;
      }
      try {
        portalDebugLog('analysis.started', model: modelVersion);
        plan = await analysisClient
            .analyze(
              PortalAnalysisRequest(
                structuralContent: snapshot.toAnalysisJson(),
                modelVersion: modelVersion,
              ),
            )
            .timeout(const Duration(seconds: 30));
      } catch (error, stack) {
        portalDebugLog(
          'analysis.failed',
          model: modelVersion,
          error: error,
          stackTrace: stack,
        );
        if (_isCurrent(generation)) {
          final failures =
              (_failedAttempts[snapshot.structuralFingerprint] ?? 0) + 1;
          _failedAttempts[snapshot.structuralFingerprint] = failures;
          _emit(
            _state.copyWith(
              phase: PortalSyncPhase.error,
              error: failures == 1
                  ? 'Could not analyze this page. Retry once or continue browsing.'
                  : 'Analysis failed twice for this page structure. Change pages or reconnect before trying again.',
              isBusy: false,
            ),
          );
        }
        return;
      }
      if (!_isCurrent(generation)) return;
      final failure = plan.validationFailureFor(snapshot);
      if (failure != null) {
        final adjusted = plan.supportedSubsetFor(snapshot);
        for (var i = 0; i < plan.tables.length; i++) {
          final tableFailure = PortalAnalysisPlan(
            pageType: plan.pageType,
            tables: [plan.tables[i]],
          ).validationFailureFor(snapshot);
          if (tableFailure != null) {
            portalDebugLog(
              'analysis.table_rejected mapping=$i reason=$tableFailure',
              model: modelVersion,
            );
          }
        }
        // Recover only validated mappings. Hints and unrelated tables may be
        // discarded without losing a valid course review or making another call.
        if (adjusted.validateFor(snapshot) &&
            (adjusted.tables.isNotEmpty ||
                plan.tables.isEmpty ||
                failure.startsWith('unsupported_page_context'))) {
          portalDebugLog(
            'analysis.mapping_adjusted reason=$failure '
            'retainedTables=${adjusted.tables.length} droppedTables=${plan.tables.length - adjusted.tables.length}',
            model: modelVersion,
          );
          plan = adjusted;
        } else {
          portalDebugLog(
            'analysis.validation_failed reason=$failure '
            'pageType=${plan.pageType.name} mappedTables=${plan.tables.length} '
            'snapshotTables=${snapshot.nodes.where((node) => node.kind == 'table').length}',
            model: modelVersion,
          );
          final failures =
              (_failedAttempts[snapshot.structuralFingerprint] ?? 0) + 1;
          _failedAttempts[snapshot.structuralFingerprint] = failures;
          _emit(
            _state.copyWith(
              phase: PortalSyncPhase.error,
              error: failures == 1
                  ? 'The page mapping could not be validated. Retry once or open a course list with course codes and titles.'
                  : 'This page could not be mapped reliably. Open another course or timetable page to continue.',
              isBusy: false,
            ),
          );
          return;
        }
      }
      portalDebugLog('analysis.succeeded', model: modelVersion);
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
        // The validated plan remains usable in this session if local storage fails.
      }
      if (!_isCurrent(generation)) return;
    }
    final chosen = plan;
    final existingIndex = _captures.indexWhere(
      (capture) =>
          capture.$1.path == keyPath &&
          capture.$1.structuralFingerprint == snapshot.structuralFingerprint,
    );
    if (existingIndex == -1) {
      if (_captures.length >= maxCapturedPages) {
        _emit(
          _state.copyWith(
            phase: PortalSyncPhase.error,
            error: 'This capture reached the 20 page limit. Review or save the current results, then start a new capture.',
            isBusy: false,
          ),
        );
        return;
      }
      _captures.add((snapshot, chosen));
    } else {
      final previous = _captures[existingIndex];
      _captures[existingIndex] = (
        _mergeSamePath(previous.$1, snapshot, chosen),
        chosen,
      );
    }
    final draft = _extractor.extract(_connection, _captures);
    _emit(
      _state.copyWith(
        phase: draft == null
            ? PortalSyncPhase.observing
            : PortalSyncPhase.review,
        draft: draft,
        clearDraft: draft == null,
        hintNodeId: chosen.hint?.nodeId,
        hintLabel: chosen.hint?.label,
        clearHint: chosen.hint == null,
        coursesCount: draft?.courses.length ?? 0,
        meetingsCount: draft?.meetings.length ?? 0,
        fromCache: fromCache,
        message: draft == null
            ? 'Open your courses or timetable page to continue.'
            : 'Review the detected courses and meetings.',
        isBusy: false,
        clearError: true,
      ),
    );
  }

  static const int maxCapturedPages = 20;

  PortalSnapshot _mergeSamePath(
    PortalSnapshot previous,
    PortalSnapshot incoming,
    PortalAnalysisPlan plan,
  ) {
    final tablePlans = {for (final table in plan.tables) table.nodeId: table};
    final oldNodes = {for (final node in previous.nodes) node.id: node};
    final nodes = incoming.nodes
        .map((node) {
          final old = oldNodes[node.id];
          final tablePlan = tablePlans[node.id];
          if (old == null || tablePlan == null) return node.toJson();
          final rows = <List<String>>[];
          final oldGroups = <String, List<List<String>>>{};
          for (final row in old.rows) {
            oldGroups.putIfAbsent(_rowGroup(row, tablePlan), () => []).add(row);
          }
          final newGroups = <String, List<List<String>>>{};
          for (final row in node.rows) {
            newGroups.putIfAbsent(_rowGroup(row, tablePlan), () => []).add(row);
          }
          final keys = {...oldGroups.keys, ...newGroups.keys};
          for (final key in keys) {
            final oldRows = oldGroups[key] ?? const <List<String>>[];
            final newRows = newGroups[key] ?? const <List<String>>[];
            if (newRows.isEmpty) {
              rows.addAll(oldRows);
            } else if (oldRows.isEmpty || newRows.length >= oldRows.length) {
              // Equal row counts represent refreshed values; larger groups contain
              // appended page rows. Replacing by group keeps changed times fresh.
              rows.addAll(newRows);
            } else {
              // A shorter capture may be a partial page. Preserve rows already
              // observed instead of treating absence as deletion.
              rows.addAll(oldRows);
            }
          }
          return {...node.toJson(), 'rows': rows};
        })
        .toList(growable: false);
    return PortalSnapshot.fromJson({
      'origin': incoming.origin,
      'path': incoming.path,
      'title': incoming.title,
      'language': incoming.language,
      'nodes': nodes,
    });
  }

  String _rowGroup(List<String> row, PortalTablePlan table) {
    final columns = table.columns;
    final values = [
      columns.code,
      columns.term,
      if (table.kind == PortalTableKind.meetings) columns.day,
    ];
    return values
        .map(
          (index) => index == null || index >= row.length
              ? ''
              : row[index].trim().toLowerCase(),
        )
        .join('|');
  }

  void pause() {
    if (_disposed) return;
    _paused = true;
    _generation++;
    _queuedSnapshot = null;
    _emit(
      _state.copyWith(
        phase: PortalSyncPhase.paused,
        message: 'Portal observation is paused.',
        isBusy: false,
      ),
    );
  }

  void resume() {
    if (_disposed) return;
    _paused = false;
    _stopped = false;
    _generation++;
    _emit(
      _state.copyWith(
        phase: PortalSyncPhase.observing,
        message: 'Portal observation is active.',
        isBusy: false,
      ),
    );
  }

  Future<void> retryAnalysis() {
    final snapshot = _lastSnapshot;
    if (snapshot == null || _disposed || _paused || _stopped) {
      return Future.value();
    }
    if ((_failedAttempts[snapshot.structuralFingerprint] ?? 0) != 1) {
      return Future.value();
    }
    _explicitRetryFingerprints.add(snapshot.structuralFingerprint);
    return capture(snapshot);
  }

  void stop() {
    if (_disposed) return;
    _stopped = true;
    _paused = false;
    _generation++;
    _queuedSnapshot = null;
    _captures.clear();
    _failedAttempts.clear();
    _explicitRetryFingerprints.clear();
    _lastSnapshot = null;
    _emit(
      const PortalSyncState(
        phase: PortalSyncPhase.idle,
        message: 'Portal observation stopped.',
      ),
    );
  }

  void setConnection(PortalConnection connection) {
    if (_disposed) return;
    _generation++;
    _queuedSnapshot = null;
    _captures.clear();
    _failedAttempts.clear();
    _explicitRetryFingerprints.clear();
    _lastSnapshot = null;
    _connection = connection;
    _paused = false;
    _stopped = false;
    _emit(
      const PortalSyncState(
        phase: PortalSyncPhase.idle,
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
          phase: PortalSyncPhase.error,
          error: 'There are no validated records to save.',
          isBusy: false,
        ),
      );
      return;
    }
    final generation = _generation;
    _emit(
      _state.copyWith(
        phase: PortalSyncPhase.saving,
        message: 'Saving reviewed records',
        isBusy: true,
        clearError: true,
      ),
    );
    try {
      final result = await importer.importDraft(draft);
      if (!_isCurrent(generation)) return;
      try {
        await usageStore.markSetupComplete(_connection.accountId);
      } catch (_) {
        // The academic import already succeeded; keep that result truthful.
      }
      if (!_isCurrent(generation)) return;
      _emit(
        _state.copyWith(
          phase: PortalSyncPhase.saved,
          message:
              result.message ??
              'Saved ${result.importedCourses} courses and ${result.importedMeetings} meetings.',
          isBusy: false,
        ),
      );
    } catch (error, stack) {
      portalDebugLog('import.failed', error: error, stackTrace: stack);
      if (_isCurrent(generation)) {
        _emit(
          _state.copyWith(
            phase: PortalSyncPhase.error,
            error:
                'Could not save these records. Your review is still available.',
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
        phase: PortalSyncPhase.observing,
        clearDraft: true,
        coursesCount: 0,
        meetingsCount: 0,
        message: 'Review discarded.',
        isBusy: false,
      ),
    );
  }

  bool _isCurrent(int generation) =>
      !_disposed && generation == _generation && !_paused && !_stopped;

  bool _isAuthenticationPage(PortalSnapshot snapshot) {
    final structuralText =
        '${snapshot.path} ${snapshot.title} ${snapshot.nodes.map((node) => node.label).join(' ')}';
    return _authPattern.hasMatch(structuralText) ||
        RegExp(
          r'\b(password|passcode|one-time code)\b',
          caseSensitive: false,
        ).hasMatch(structuralText);
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _queuedSnapshot = null;
    _captures.clear();
    super.dispose();
  }
}
