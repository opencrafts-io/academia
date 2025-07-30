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
  TodoBloc({
    required this.getCachedTodosUsecase,
    required this.refreshTodosUsecase,
    required this.createTodoUsecase,
    required this.updateTodoUsecase,
    required this.deleteTodoUsecase,
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
          // pass silently since the stream will be updated
        },
      );
    });

    on<AddTodoEvent>((event, emit) async {
      final result = await createTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) {
          // pass silently since the stream will be updated
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
          // pass silently since the stream will be updated
        },
      );
    });

    on<DeleteTodoEvent>((event, emit) async {
      final result = await deleteTodoUsecase(event.todo);
      return result.fold(
        (failure) {
          return emit(TodoErrorState(error: failure.message));
        },
        (todo) {
          // pass silently since the stream will be updated
        },
      );
    });
  }
}
