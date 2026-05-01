import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './todo_list_state.dart';

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

  Future<void> createTodo(TodoListEntity todo) async {
    final currentState = state.mapOrNull<TodoListSuccess>();
    if (currentState == null) return;

    // Eagerly add to UI
    final updatedList = [todo, ...currentState.todoLists];
    emit(currentState.copyWith(todoLists: updatedList));

    final result = await createTodoListUseCase(todo);

    // On success,replace the "temp" item with the server-verified one (with real ID)
    result.fold((f) => null, (newTodo) {
      final syncedList = updatedList
          .map((e) => e.localId == todo.localId ? newTodo : e)
          .toList();
      emit(currentState.copyWith(todoLists: syncedList));
    });
  }

  Future<void> sync() async {
    final currentState = state.mapOrNull<TodoListSuccess>();
    if (currentState != null) emit(currentState.copyWith(isSyncing: true));

    await syncTodoListsUseCase(NoParams());

    await loadTodoLists();
  }
}
