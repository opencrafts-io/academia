import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';

class TodoItemCubit extends SafeCubit<TodoItemState> {
  final GetTodoItems getItemsUseCase;
  final GetTodoItemById getItemByIdUseCase;
  final CreateTodoItem createItemUseCase;
  final UpdateTodoItem updateItemUseCase;
  final DeleteTodoItem deleteItemUseCase;
  final CompleteTodoItem completeItemUseCase;
  final ReopenTodoItem reopenItemUseCase;
  final MoveTodoItem moveItemUseCase;
  final SyncTodoItems syncItemsUseCase;

  /// The local ID of the task list this cubit is scoped to.
  /// Null means all lists are shown.
  final int? taskListLocalId;

  TodoItemCubit({
    required this.getItemsUseCase,
    required this.getItemByIdUseCase,
    required this.createItemUseCase,
    required this.updateItemUseCase,
    required this.deleteItemUseCase,
    required this.completeItemUseCase,
    required this.reopenItemUseCase,
    required this.moveItemUseCase,
    required this.syncItemsUseCase,
    this.taskListLocalId,
  }) : super(const TodoItemState.initial()) {
    _init();
  }

  /// Kicks off initial item load on cubit creation.
  Future<void> _init() async {
    await loadItems();
  }

  /// Fetches the first page of items, optionally scoped to [taskListLocalId],
  /// retaining stale items in state during the load.
  Future<void> loadItems() async {
    emit(TodoItemState.loading(items: state.currentItems));

    final result = await getItemsUseCase(
      GetTodoItemsParams(taskListLocalId: taskListLocalId),
    );

    result.fold(
      (failure) => emit(
        TodoItemState.failure(failure: failure, items: state.currentItems),
      ),
      (page) =>
          emit(TodoItemState.success(items: page.items, nextUrl: page.nextUrl)),
    );
  }

  /// Loads the next page of items and appends them to the current list.
  Future<void> loadMore() async {
    final currentState = state.mapOrNull(success: (s) => s);
    if (currentState == null ||
        currentState.nextUrl == null ||
        currentState.isPaginating)
      return;

    emit(currentState.copyWith(isPaginating: true));

    final result = await getItemsUseCase(
      GetTodoItemsParams(
        url: currentState.nextUrl,
        taskListLocalId: taskListLocalId,
      ),
    );

    result.fold(
      (_) => emit(currentState.copyWith(isPaginating: false)),
      (page) => emit(
        currentState.copyWith(
          items: [...currentState.items, ...page.items],
          nextUrl: page.nextUrl,
          isPaginating: false,
        ),
      ),
    );
  }

  /// Optimistically inserts a new item then reconciles with the
  /// server-confirmed entity once the use case completes.
  Future<void> createItem(TodoItemEntity item) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    emit(currentState.copyWith(items: [item, ...currentState.items]));

    final result = await createItemUseCase(item);
    result.fold(
      (_) => null, // Optimistic entry stays; sync will reconcile later
      (newItem) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.items.map((existing) {
          // Replace the optimistic placeholder with the confirmed entity
          return existing.title == item.title &&
                  existing.syncStatus == SyncStatus.pending
              ? newItem
              : existing;
        }).toList();
        emit(latest.copyWith(items: synced));
      },
    );
  }

  /// Optimistically applies the update to state then reconciles
  /// with the server-confirmed entity once the use case completes.
  Future<void> updateItem(TodoItemEntity item) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    // Optimistic update
    final optimistic = currentState.items.map((existing) {
      return existing.localId == item.localId ? item : existing;
    }).toList();
    emit(currentState.copyWith(items: optimistic));

    final result = await updateItemUseCase(item);
    result.fold(
      (_) => emit(currentState), // Roll back on failure
      (updated) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.items.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latest.copyWith(items: synced));
      },
    );
  }

  /// Optimistically removes the item from state then calls the use case.
  /// Restores the item if deletion fails.
  Future<void> deleteItem(int localId) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    final deleted = currentState.items
        .where((i) => i.localId == localId)
        .firstOrNull;
    final optimistic = currentState.items
        .where((i) => i.localId != localId)
        .toList();

    emit(currentState.copyWith(items: optimistic));

    final result = await deleteItemUseCase(localId);
    result.fold((_) {
      // Restore on failure
      if (deleted != null) {
        emit(currentState.copyWith(items: [...currentState.items, deleted]));
      }
    }, (_) => null);
  }

  /// Optimistically marks an item as complete in state then syncs to remote.
  /// Rolls back to the previous item state if the use case fails.
  Future<void> completeItem(int localId) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    final original = currentState.items
        .where((i) => i.localId == localId)
        .firstOrNull;
    if (original == null) return;

    // Optimistic complete
    final optimistic = currentState.items.map((existing) {
      return existing.localId == localId
          ? existing.copyWith(
              status: TodoStatus.completed,
              completed: DateTime.now(),
            )
          : existing;
    }).toList();
    emit(currentState.copyWith(items: optimistic));

    final result = await completeItemUseCase(localId);
    result.fold(
      (_) => emit(currentState), // Roll back on failure
      (updated) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.items.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latest.copyWith(items: synced));
      },
    );
  }

  /// Optimistically marks a completed item as needing action in state
  /// then syncs to remote. Rolls back if the use case fails.
  Future<void> reopenItem(int localId) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    final original = currentState.items
        .where((i) => i.localId == localId)
        .firstOrNull;
    if (original == null) return;

    // Optimistic reopen
    final optimistic = currentState.items.map((existing) {
      return existing.localId == localId
          ? existing.copyWith(status: TodoStatus.needsAction, completed: null)
          : existing;
    }).toList();
    emit(currentState.copyWith(items: optimistic));

    final result = await reopenItemUseCase(localId);
    result.fold(
      (_) => emit(currentState), // Roll back on failure
      (updated) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.items.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latest.copyWith(items: synced));
      },
    );
  }

  /// Optimistically updates the item's task list reference in state
  /// then syncs the move to remote. Rolls back if the use case fails.
  Future<void> moveItem({
    required int localId,
    required int targetListLocalId,
  }) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoItemSuccess(items: []);

    final original = currentState.items
        .where((i) => i.localId == localId)
        .firstOrNull;
    if (original == null) return;

    // Optimistic move — update taskListLocalId immediately
    final optimistic = currentState.items.map((existing) {
      return existing.localId == localId
          ? existing.copyWith(taskListLocalId: targetListLocalId)
          : existing;
    }).toList();
    emit(currentState.copyWith(items: optimistic));

    final result = await moveItemUseCase(
      MoveTodoItemParams(
        localId: localId,
        targetListLocalId: targetListLocalId,
      ),
    );
    result.fold(
      (_) => emit(currentState), // Roll back on failure
      (updated) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.items.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latest.copyWith(items: synced));
      },
    );
  }

  /// Pushes all locally dirty or pending-deletion items to the remote,
  /// then reloads the item list to reflect the synced state.
  Future<void> sync() async {
    final currentState = state.mapOrNull(success: (s) => s);
    if (currentState != null) emit(currentState.copyWith(isSyncing: true));

    await syncItemsUseCase(NoParams());
    await loadItems();
  }
}
