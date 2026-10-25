import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/pomodoro.dart';

class _MemorySessionStore implements PomodoroSessionStore {
  _MemorySessionStore(this.snapshot);

  PomodoroSessionSnapshot? snapshot;

  @override
  Future<PomodoroSessionSnapshot?> read() async => snapshot;

  @override
  Future<void> write(PomodoroSessionSnapshot snapshot) async {
    this.snapshot = snapshot;
  }
}

class _RecordingStatusSurface implements PomodoroStatusSurface {
  final shown = <PomodoroStatus>[];

  @override
  Future<void> start(PomodoroStatus status) async => shown.add(status);

  @override
  Future<void> update(PomodoroStatus status) async => shown.add(status);

  @override
  Future<void> stop(String sessionId) async {}
}

class _NoTodosGateway implements PomodoroTodoGateway {
  @override
  PomodoroTodoItemsSnapshot getAvailableTodoItems() =>
      const PomodoroTodoItemsSnapshot(
        items: [],
        isLoading: false,
        isLoadingMore: false,
        hasMore: false,
      );

  @override
  Stream<PomodoroTodoItemsSnapshot> watchAvailableTodoItems() =>
      const Stream.empty();

  @override
  Future<void> loadMoreAvailableTodoItems() async {}

  @override
  PomodoroTodoItem? findTodoItem(int localId) => null;

  @override
  Stream<PomodoroTodoItem?> watchTodoItem(int localId) => const Stream.empty();

  @override
  Future<void> addFocusedTime({
    required int todoLocalId,
    required Duration duration,
  }) async {}
}

PomodoroSessionSnapshot _runningSnapshot({required Duration activeFor}) {
  final now = DateTime.now();
  return PomodoroSessionSnapshot(
    phase: PomodoroPhase.focus,
    remainingSeconds: 600,
    isRunning: true,
    endsAtEpochMillis: now
        .add(const Duration(minutes: 10))
        .millisecondsSinceEpoch,
    completedFocusSessions: 2,
    focusDurationSeconds: 1500,
    shortBreakDurationSeconds: 300,
    longBreakDurationSeconds: 900,
    sessionsBeforeLongBreak: 4,
    sessionId: 'session',
    activeSinceEpochMillis: now.subtract(activeFor).millisecondsSinceEpoch,
  );
}

void main() {
  late _MemorySessionStore store;
  late _RecordingStatusSurface surface;
  late PomodoroCubit cubit;

  Future<PomodoroCubit> restore(PomodoroSessionSnapshot snapshot) async {
    store = _MemorySessionStore(snapshot);
    surface = _RecordingStatusSurface();
    cubit = PomodoroCubit(
      todoGateway: _NoTodosGateway(),
      sessionStore: store,
      statusSurface: surface,
    );
    await cubit.ready;
    return cubit;
  }

  tearDown(() => cubit.close());

  test('restores a session past the activity window paused', () async {
    await restore(_runningSnapshot(activeFor: const Duration(hours: 4)));

    expect(cubit.state.isRunning, isFalse);
    expect(cubit.state.awaitingActivityCheck, isTrue);
    expect(cubit.state.remaining.inMinutes, closeTo(10, 1));
    expect(store.snapshot!.isRunning, isFalse);
    expect(store.snapshot!.awaitingActivityCheck, isTrue);
    expect(surface.shown.last.isRunning, isFalse);
  });

  test('restores a session within the activity window running', () async {
    await restore(_runningSnapshot(activeFor: const Duration(hours: 1)));

    expect(cubit.state.isRunning, isTrue);
    expect(cubit.state.awaitingActivityCheck, isFalse);
  });

  test('starting again confirms activity and restarts the window', () async {
    await restore(_runningSnapshot(activeFor: const Duration(hours: 4)));

    await cubit.start();

    expect(cubit.state.isRunning, isTrue);
    expect(cubit.state.awaitingActivityCheck, isFalse);
    final activeSince = DateTime.fromMillisecondsSinceEpoch(
      store.snapshot!.activeSinceEpochMillis!,
    );
    expect(
      DateTime.now().difference(activeSince),
      lessThan(const Duration(minutes: 1)),
    );
  });

  test('dismissing the check leaves the timer paused', () async {
    await restore(_runningSnapshot(activeFor: const Duration(hours: 4)));

    await cubit.dismissActivityCheck();

    expect(cubit.state.isRunning, isFalse);
    expect(cubit.state.awaitingActivityCheck, isFalse);
    expect(store.snapshot!.awaitingActivityCheck, isFalse);
  });

  test('reset ends the session and clears the activity window', () async {
    await restore(_runningSnapshot(activeFor: const Duration(hours: 4)));

    await cubit.reset();

    expect(cubit.state.isRunning, isFalse);
    expect(cubit.state.awaitingActivityCheck, isFalse);
    expect(store.snapshot!.activeSinceEpochMillis, isNull);
  });
}
