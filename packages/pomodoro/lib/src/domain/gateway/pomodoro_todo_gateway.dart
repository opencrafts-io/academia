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

/// The available Todo items and pagination status shown by the picker.
class PomodoroTodoItemsSnapshot {
  const PomodoroTodoItemsSnapshot({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
  });

  final List<PomodoroTodoItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
}

/// Lets the host application connect Pomodoro sessions to its todo storage.
abstract interface class PomodoroTodoGateway {
  PomodoroTodoItemsSnapshot getAvailableTodoItems();

  Stream<PomodoroTodoItemsSnapshot> watchAvailableTodoItems();

  Future<void> loadMoreAvailableTodoItems();

  PomodoroTodoItem? findTodoItem(int localId);

  Stream<PomodoroTodoItem?> watchTodoItem(int localId);

  Future<void> addFocusedTime({
    required int todoLocalId,
    required Duration duration,
  });
}
