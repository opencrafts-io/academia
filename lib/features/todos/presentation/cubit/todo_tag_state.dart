import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_tag_state.freezed.dart';

@freezed
class TodoTagState with _$TodoTagState {
  const factory TodoTagState.initial() = _TodoTagInitial;

  const factory TodoTagState.loading({
    /// Tags retained from the previous success state so the UI
    /// doesn't flash empty while reloading.
    @Default([]) List<TodoTagEntity> tags,
  }) = _TodoTagLoading;

  const factory TodoTagState.success({
    required List<TodoTagEntity> tags,
    String? nextUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isSyncing,
  }) = TodoTagSuccess;

  const factory TodoTagState.failure({
    required Failure failure,

    /// Tags retained so the UI can still display stale data on error.
    @Default([]) List<TodoTagEntity> tags,
  }) = _TodoTagFailure;
}

extension TodoTagStateX on TodoTagState {
  /// Returns current tags regardless of which state variant is active.
  List<TodoTagEntity> get currentTags => maybeWhen(
    loading: (tags) => tags,
    success: (tags, _, _, _) => tags,
    failure: (_, tags) => tags,
    orElse: () => [],
  );
}
