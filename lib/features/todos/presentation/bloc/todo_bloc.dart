import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetCachedTodosUsecase getCachedTodosUsecase;
  final RefreshTodosUsecase refreshTodosUsecase;
  final CreateTodoUsecase createTodoUsecase;
  final UpdateTodoUsecase updateTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;
  final CompleteTodoUsecase completeTodoUsecase;
  final SyncTodosWithGoogleTasksUsecase syncTodosWithGoogleTasksUsecase;
  TodoBloc({
    required this.syncTodosWithGoogleTasksUsecase,
    required this.getCachedTodosUsecase,
    required this.refreshTodosUsecase,
    required this.createTodoUsecase,
    required this.updateTodoUsecase,
    required this.deleteTodoUsecase,
    required this.completeTodoUsecase,
  }) : super(TodoInitialState()) {
    on<FetchCachedTodosEvent>((event, emit) {
      final todosStream = getCachedTodosUsecase(NoParams());
      emit(TodoLoadedState(todosStream: todosStream));
    });

    on<FetchTodoEvent>((event, emit) async {
      final result = await refreshTodosUsecase(
        RefreshTodosParams(page: event.page, pageSize: event.pageSize),
      );
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (stream) {
          add(FetchCachedTodosEvent());
        },
      );
    });

    on<AddTodoEvent>((event, emit) async {
      final result = await createTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) async {
          // add(FetchCachedTodosEvent());
        },
      );
    });

    on<UpdateTodoEvent>((event, emit) async {
      final result = await updateTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) {
          add(FetchCachedTodosEvent());
        },
      );
    });

    on<CompleteTodoEvent>((event, emit) async {
      final result = await completeTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) async {
          // add(FetchCachedTodosEvent());
        },
      );
    });

    on<SyncTodosWithGoogleCalendar>((event, emit) async {
      syncTodosWithGoogleTasksUsecase(NoParams());
    });

    on<DeleteTodoEvent>((event, emit) async {
      final result = await deleteTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) async {
          // add(FetchCachedTodosEvent());
        },
      );
    });
  }
}
