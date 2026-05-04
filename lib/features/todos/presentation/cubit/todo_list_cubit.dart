import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final GetTodoLists getTodoListsUseCase;
  final CreateTodoList createTodoListUseCase;
  final UpdateTodoList updateTodoListUseCase;
  final DeleteTodoList deleteTodoListUseCase;
  final SyncTodoLists syncTodoListsUseCase;

  TodoListCubit({
    required this.getTodoListsUseCase,
    required this.createTodoListUseCase,
    required this.updateTodoListUseCase,
    required this.deleteTodoListUseCase,
    required this.syncTodoListsUseCase,
  }) : super(const TodoListState.initial());

  /// Initial fetch
  Future<void> loadTodoLists() async {
    emit(const TodoListState.loading());
    final result = await getTodoListsUseCase(const GetTodoListsParams());

    result.fold(
      (f) => emit(TodoListState.failure(f)),
      (page) => emit(
        TodoListState.success(todoLists: page.items, nextUrl: page.nextUrl),
      ),
    );
  }

  /// Load next page (Endless Scroll)
  Future<void> loadMore() async {
    final currentState = state
        .mapOrNull<TodoListSuccess>(); // Helper to get current success state
    if (currentState == null ||
        currentState.nextUrl == null ||
        currentState.isPaginating) {
      return;
    }

    emit(currentState.copyWith(isPaginating: true));

    final result = await getTodoListsUseCase(
      GetTodoListsParams(url: currentState.nextUrl),
    );

    result.fold(
      (f) => emit(
        currentState.copyWith(isPaginating: false),
      ), // Handle silently or show toast
      (page) => emit(
        currentState.copyWith(
          todoLists: [...currentState.todoLists, ...page.items],
          nextUrl: page.nextUrl,
          isPaginating: false,
        ),
      ),
    );
  }

  Future<void> createTodoList(TodoListEntity todoList) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ??
        const TodoListSuccess(todoLists: []);

    final todoLists = [todoList, ...currentState.todoLists];
    emit(currentState.copyWith(todoLists: todoLists));

    final result = await createTodoListUseCase(todoList);

    result.fold((failure) => null, (newTodoList) {
      final latestState = state.mapOrNull(success: (s) => s);
      if (latestState == null) return;

      final syncedList = latestState.todoLists.map((existingItem) {
        if (existingItem.title == todoList.title &&
            existingItem.syncStatus == SyncStatus.pending) {
          return newTodoList;
        }
        return existingItem;
      }).toList();

      emit(latestState.copyWith(todoLists: syncedList));
    });
  }

  Future<void> sync() async {
    final currentState = state.mapOrNull<TodoListSuccess>();
    if (currentState != null) emit(currentState.copyWith(isSyncing: true));

    await syncTodoListsUseCase(NoParams());

    await loadTodoLists();
  }

  Future<void> updateTodoList(TodoListEntity todoList) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ??
        const TodoListSuccess(todoLists: []);

    final updatedLists = currentState.todoLists.map((existing) {
      return existing.localId == todoList.localId ? todoList : existing;
    }).toList();

    emit(currentState.copyWith(todoLists: updatedLists));

    final result = await updateTodoListUseCase(todoList);
    result.fold(
      (error) {
        emit(currentState);
      },
      (updated) {
        final latestState = state.mapOrNull(success: (s) => s);
        if (latestState == null) return;
        final syncedLists = latestState.todoLists.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latestState.copyWith(todoLists: syncedLists));
      },
    );
  }

  //
  Future<void> deleteTodoList(int todoListId) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ??
        const TodoListSuccess(todoLists: []);

    final lists = currentState.todoLists.toList();
    final deletedList = lists.firstWhere((list) => list.localId == todoListId);
    lists.removeWhere((list) => list.localId == todoListId);

    emit(currentState.copyWith(todoLists: lists));

    try {
      await deleteTodoListUseCase(todoListId);
    } catch (e) {
      lists.add(deletedList);
      emit(currentState.copyWith(todoLists: lists));
      print("Delete failed: $e");
    }
  }
}
