import 'dart:async';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:pomodoro/src/domain/domain.dart';
import 'package:pomodoro/src/presentation/cubit/pomodoro_state.dart';
import 'package:vibration/vibration.dart';

/// Drives an in-app Pomodoro focus timer: alternating focus sessions and
/// breaks, optionally tracked against a linked todo item.
///
/// Registered as a lazy singleton so a running session survives navigation
/// away from the timer screen.
@lazySingleton
class PomodoroCubit extends SafeCubit<PomodoroState> {
  PomodoroCubit({
    required this.todoGateway,
    required this.sessionStore,
    required this.statusSurface,
  }) : super(PomodoroState.initial()) {
    _ready = _restoreSession();
  }

  /// Used to attribute completed focus time to the linked todo item.
  final PomodoroTodoGateway todoGateway;
  final PomodoroSessionStore sessionStore;
  final PomodoroStatusSurface statusSurface;

  Future<void> get ready => _ready;

  Timer? _ticker;
  late final Future<void> _ready;
  DateTime? _phaseEndsAt;
  String? _sessionId;
  StreamSubscription<PomodoroTodoItem?>? _linkedTodoSubscription;

  Future<void> start() async {
    await _ready;
    if (state.isRunning) return;

    _phaseEndsAt = DateTime.now().add(state.remaining);
    _sessionId ??= DateTime.now().microsecondsSinceEpoch.toString();
    emit(state.copyWith(isRunning: true));
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    await _persistSession();
    await _showStatus(start: true);
  }

  Future<void> pause() async {
    await _ready;
    if (!state.isRunning) return;
    final remaining = _currentRemaining();
    _ticker?.cancel();
    _phaseEndsAt = null;
    emit(state.copyWith(isRunning: false, remaining: remaining));
    await _persistSession();
    await _showStatus(start: false);
  }

  Future<void> reset() async {
    await _ready;
    final sessionId = _sessionId;
    _ticker?.cancel();
    _phaseEndsAt = null;
    _sessionId = null;
    emit(state.copyWith(isRunning: false, remaining: state.totalDuration));
    if (sessionId != null) {
      await statusSurface.stop(sessionId);
    }
    await _persistSession();
  }

  /// Ends the current phase early and advances to the next one.
  Future<void> skip() async {
    await _ready;
    await _advancePhase();
  }

  /// Associates the running session with a todo item so progress is
  /// attributed to it. Pass `null` to detach.
  Future<void> linkTodoItem(int? localId) async {
    await _ready;
    final previousSubscription = _linkedTodoSubscription;
    _linkedTodoSubscription = null;
    if (previousSubscription != null) {
      unawaited(previousSubscription.cancel());
    }

    final item = localId == null ? null : todoGateway.findTodoItem(localId);
    emit(
      state.copyWith(
        linkedTodoItemLocalId: item?.localId,
        linkedTodoItemTitle: item?.title,
        trackedFocusedSeconds: item?.focusedSeconds ?? 0,
      ),
    );

    if (item != null) {
      _linkedTodoSubscription = todoGateway
          .watchTodoItem(item.localId)
          .listen(
            (updatedItem) => _updateLinkedTodoItem(item.localId, updatedItem),
          );
    }

    await _persistSession();
    if (_sessionId != null) {
      await _showStatus(start: false);
    }
  }

  Future<void> updateSettings({
    Duration? focusDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
    int? sessionsBeforeLongBreak,
  }) async {
    await _ready;
    final updated = state.copyWith(
      focusDuration: focusDuration ?? state.focusDuration,
      shortBreakDuration: shortBreakDuration ?? state.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? state.longBreakDuration,
      sessionsBeforeLongBreak:
          sessionsBeforeLongBreak ?? state.sessionsBeforeLongBreak,
    );

    // Only resync the visible countdown if the timer isn't already running,
    // otherwise a settings change mid-session would jump the clock.
    emit(
      state.isRunning
          ? updated
          : updated.copyWith(remaining: updated.totalDuration),
    );
    await _persistSession();
    if (_sessionId != null) {
      await _showStatus(start: false);
    }
  }

  void _tick() {
    final next = _currentRemaining();
    if (next.isNegative || next == Duration.zero) {
      // The phase completed naturally — count it as the full duration
      // rather than the stale pre-tick `state.remaining` (which is still
      // 1 second), so a completed session isn't undercounted by 1s.
      unawaited(_advancePhase(remainingOverride: Duration.zero));
      return;
    }
    emit(state.copyWith(remaining: next));
  }

  Future<void> _advancePhase({Duration? remainingOverride}) async {
    _ticker?.cancel();
    _vibrate();

    final effectiveRemaining = remainingOverride ?? state.remaining;
    final wasFocus = state.phase == PomodoroPhase.focus;

    // Count whatever was actually focused, including a session skipped
    // early — not just full sessions that ran to completion.
    if (wasFocus && state.linkedTodoItemLocalId != null) {
      final elapsed = state.totalDuration - effectiveRemaining;
      if (elapsed > Duration.zero) {
        unawaited(
          _recordFocusedTime(
            todoLocalId: state.linkedTodoItemLocalId!,
            duration: elapsed,
          ),
        );
      }
    }

    final completed = wasFocus
        ? state.completedFocusSessions + 1
        : state.completedFocusSessions;

    final nextPhase = wasFocus
        ? (completed % state.sessionsBeforeLongBreak == 0
              ? PomodoroPhase.longBreak
              : PomodoroPhase.shortBreak)
        : PomodoroPhase.focus;

    final completedSessionId = _sessionId;
    _phaseEndsAt = null;
    _sessionId = null;
    final updated = state.copyWith(
      phase: nextPhase,
      completedFocusSessions: nextPhase == PomodoroPhase.longBreak
          ? 0
          : completed,
      isRunning: false,
    );

    emit(updated.copyWith(remaining: updated.totalDuration));
    if (completedSessionId != null) {
      await statusSurface.stop(completedSessionId);
    }
    await _persistSession();
  }

  Duration _currentRemaining() {
    final endsAt = _phaseEndsAt;
    if (endsAt == null) return state.remaining;
    final milliseconds = endsAt.difference(DateTime.now()).inMilliseconds;
    if (milliseconds <= 0) return Duration.zero;
    return Duration(seconds: (milliseconds / 1000).ceil());
  }

  PomodoroStatus _status() {
    final remaining = state.isRunning ? _currentRemaining() : state.remaining;
    final now = DateTime.now();
    final endsAt = state.isRunning ? _phaseEndsAt : null;
    final elapsed = state.totalDuration - remaining;
    final startedAt = state.isRunning
        ? now.subtract(elapsed.isNegative ? Duration.zero : elapsed)
        : null;
    return PomodoroStatus(
      sessionId: _sessionId!,
      phase: state.phase,
      remainingSeconds: remaining.inSeconds,
      totalDurationSeconds: state.totalDuration.inSeconds,
      isRunning: state.isRunning,
      startAtEpochMillis: startedAt?.millisecondsSinceEpoch,
      endsAtEpochMillis: endsAt?.millisecondsSinceEpoch,
      todoTitle: state.linkedTodoItemTitle,
    );
  }

  Future<void> _showStatus({required bool start}) async {
    final sessionId = _sessionId;
    if (sessionId == null) return;
    final status = _status();
    if (start) {
      await statusSurface.start(status);
    } else {
      await statusSurface.update(status);
    }
  }

  Future<void> _restoreSession() async {
    final snapshot = await sessionStore.read();
    if (snapshot == null || isClosed) return;

    final storedRemaining = Duration(seconds: snapshot.remainingSeconds);
    final endsAt = snapshot.endsAtEpochMillis == null
        ? (snapshot.isRunning ? DateTime.now().add(storedRemaining) : null)
        : DateTime.fromMillisecondsSinceEpoch(snapshot.endsAtEpochMillis!);
    final restoredRemaining = snapshot.isRunning && endsAt != null
        ? endsAt.difference(DateTime.now())
        : storedRemaining;
    final remaining = restoredRemaining.isNegative
        ? Duration.zero
        : Duration(seconds: (restoredRemaining.inMilliseconds / 1000).ceil());
    final isRunning = snapshot.isRunning && remaining > Duration.zero;
    _phaseEndsAt = isRunning ? endsAt : null;
    _sessionId = snapshot.sessionId;

    final linkedItem = snapshot.linkedTodoLocalId == null
        ? null
        : todoGateway.findTodoItem(snapshot.linkedTodoLocalId!);

    emit(
      state.copyWith(
        phase: snapshot.phase,
        remaining: remaining,
        isRunning: isRunning,
        completedFocusSessions: snapshot.completedFocusSessions,
        focusDuration: Duration(seconds: snapshot.focusDurationSeconds),
        shortBreakDuration: Duration(
          seconds: snapshot.shortBreakDurationSeconds,
        ),
        longBreakDuration: Duration(seconds: snapshot.longBreakDurationSeconds),
        sessionsBeforeLongBreak: snapshot.sessionsBeforeLongBreak,
        linkedTodoItemLocalId: snapshot.linkedTodoLocalId,
        linkedTodoItemTitle: linkedItem?.title,
        trackedFocusedSeconds: linkedItem?.focusedSeconds ?? 0,
      ),
    );

    if (snapshot.linkedTodoLocalId != null) {
      _watchLinkedTodoItem(snapshot.linkedTodoLocalId!);
    }

    if (snapshot.isRunning && remaining == Duration.zero) {
      await _advancePhase(remainingOverride: Duration.zero);
      return;
    }

    if (isRunning) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
      await _showStatus(start: true);
    } else if (_sessionId != null) {
      await _showStatus(start: true);
    }
  }

  Future<void> _persistSession() => sessionStore.write(
    PomodoroSessionSnapshot(
      phase: state.phase,
      remainingSeconds: state.remaining.inSeconds,
      isRunning: state.isRunning,
      endsAtEpochMillis: _phaseEndsAt?.millisecondsSinceEpoch,
      completedFocusSessions: state.completedFocusSessions,
      focusDurationSeconds: state.focusDuration.inSeconds,
      shortBreakDurationSeconds: state.shortBreakDuration.inSeconds,
      longBreakDurationSeconds: state.longBreakDuration.inSeconds,
      sessionsBeforeLongBreak: state.sessionsBeforeLongBreak,
      sessionId: _sessionId,
      linkedTodoLocalId: state.linkedTodoItemLocalId,
    ),
  );

  Future<void> _recordFocusedTime({
    required int todoLocalId,
    required Duration duration,
  }) async {
    await todoGateway.addFocusedTime(
      todoLocalId: todoLocalId,
      duration: duration,
    );
  }

  void _updateLinkedTodoItem(int localId, PomodoroTodoItem? item) {
    if (isClosed || state.linkedTodoItemLocalId != localId) {
      return;
    }
    final trackedFocusedSeconds = item?.focusedSeconds ?? 0;
    final title = item?.title ?? state.linkedTodoItemTitle;
    if (state.trackedFocusedSeconds == trackedFocusedSeconds &&
        state.linkedTodoItemTitle == title) {
      return;
    }
    emit(
      state.copyWith(
        trackedFocusedSeconds: trackedFocusedSeconds,
        linkedTodoItemTitle: title,
      ),
    );
    if (_sessionId != null) {
      unawaited(_showStatus(start: false));
    }
  }

  void _watchLinkedTodoItem(int localId) {
    _linkedTodoSubscription = todoGateway
        .watchTodoItem(localId)
        .listen((updatedItem) => _updateLinkedTodoItem(localId, updatedItem));
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: const [0, 200, 100, 200]);
    }
  }

  @override
  Future<void> close() async {
    _ticker?.cancel();
    await _linkedTodoSubscription?.cancel();
    return super.close();
  }
}
