import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_list_state.freezed.dart';

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState.initial() = _Initial;
  const factory TodoListState.loading() = _Loading;
  const factory TodoListState.success({
    required List<TodoListEntity> todoLists,
    String? nextUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isSyncing,
  }) = TodoListSuccess;
  const factory TodoListState.failure(Failure failure) = _Failure;
}

extension TodoListStateX on TodoListState {
  T? maybeMap<T>({T Function(TodoListSuccess)? success}) {
    return mapOrNull(success: (s) => success?.call(s));
  }
}
