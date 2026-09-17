import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item_state.freezed.dart';

@freezed
class TodoItemState with _$TodoItemState {
  const factory TodoItemState.initial() = _TodoItemInitial;

  const factory TodoItemState.loading({
    /// Items retained from the previous success state so the UI
    /// doesn't flash empty while reloading.
    @Default([]) List<TodoItemEntity> items,
  }) = _TodoItemLoading;

  const factory TodoItemState.success({
    required List<TodoItemEntity> items,
    String? nextUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isSyncing,
  }) = TodoItemSuccess;

  const factory TodoItemState.failure({
    required Failure failure,

    /// Items retained so the UI can still display stale data on error.
    @Default([]) List<TodoItemEntity> items,
  }) = _TodoItemFailure;
}

extension TodoItemStateX on TodoItemState {
  /// Returns current items regardless of which state variant is active.
  List<TodoItemEntity> get currentItems => maybeWhen(
    loading: (items) => items,
    success: (items, _, __, ___) => items,
    failure: (_, items) => items,
    orElse: () => [],
  );
}
