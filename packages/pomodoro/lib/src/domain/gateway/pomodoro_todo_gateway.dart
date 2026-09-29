/// A lightweight snapshot used to display focus progress for a linked todo.
class PomodoroTodoItem {
  const PomodoroTodoItem({
    required this.localId,
    required this.title,
    required this.focusedSeconds,
  });

  final int localId;
  final String title;
  final int focusedSeconds;
}

/// Lets the host application connect Pomodoro sessions to its todo storage.
abstract interface class PomodoroTodoGateway {
  PomodoroTodoItem? findTodoItem(int localId);

  Stream<PomodoroTodoItem?> watchTodoItem(int localId);

  Future<void> addFocusedTime({
    required int todoLocalId,
    required Duration duration,
  });
}
