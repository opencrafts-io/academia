import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';

class TodoTagCubit extends SafeCubit<TodoTagState> {
  final GetTodoTags getTagsUseCase;
  final CreateTodoTag createTagUseCase;
  final UpdateTodoTag updateTagUseCase;
  final DeleteTodoTag deleteTagUseCase;
  final SyncTodoTags syncTagsUseCase;

  TodoTagCubit({
    required this.getTagsUseCase,
    required this.createTagUseCase,
    required this.updateTagUseCase,
    required this.deleteTagUseCase,
    required this.syncTagsUseCase,
  }) : super(const TodoTagState.initial()) {
    _init();
  }

  /// Kicks off initial tag load on cubit creation.
  Future<void> _init() async {
    await loadTags();
  }

  /// Fetches the first page of tags from the repository,
  /// retaining stale tags in state during the load.
  Future<void> loadTags() async {
    emit(TodoTagState.loading(tags: state.currentTags));

    final result = await getTagsUseCase(const GetTodoTagsParams());
    result.fold(
      (failure) =>
          emit(TodoTagState.failure(failure: failure, tags: state.currentTags)),
      (page) =>
          emit(TodoTagState.success(tags: page.items, nextUrl: page.nextUrl)),
    );
  }

  /// Loads the next page of tags and appends them to the current list.
  Future<void> loadMore() async {
    final currentState = state.mapOrNull(success: (s) => s);
    if (currentState == null ||
        currentState.nextUrl == null ||
        currentState.isPaginating) {
      return;
    }

    emit(currentState.copyWith(isPaginating: true));

    final result = await getTagsUseCase(
      GetTodoTagsParams(url: currentState.nextUrl),
    );

    result.fold(
      (_) => emit(currentState.copyWith(isPaginating: false)),
      (page) => emit(
        currentState.copyWith(
          tags: [...currentState.tags, ...page.items],
          nextUrl: page.nextUrl,
          isPaginating: false,
        ),
      ),
    );
  }

  /// Optimistically inserts a new tag then reconciles with the
  /// server-confirmed entity once the use case completes.
  Future<void> createTag(TodoTagEntity tag) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoTagSuccess(tags: []);

    emit(currentState.copyWith(tags: [tag, ...currentState.tags]));

    final result = await createTagUseCase(tag);
    result.fold(
      (_) => null, // Optimistic entry stays; sync will reconcile later
      (newTag) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.tags.map((existing) {
          // Replace the optimistic placeholder with the confirmed entity
          return existing.name == tag.name &&
                  existing.syncStatus == SyncStatus.pending
              ? newTag
              : existing;
        }).toList();
        emit(latest.copyWith(tags: synced));
      },
    );
  }

  /// Optimistically applies the update to state then reconciles
  /// with the server-confirmed entity once the use case completes.
  Future<void> updateTag(TodoTagEntity tag) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoTagSuccess(tags: []);

    // Optimistic update
    final optimistic = currentState.tags.map((existing) {
      return existing.localId == tag.localId ? tag : existing;
    }).toList();
    emit(currentState.copyWith(tags: optimistic));

    final result = await updateTagUseCase(tag);
    result.fold(
      (_) => emit(currentState), // Roll back on failure
      (updated) {
        final latest = state.mapOrNull(success: (s) => s);
        if (latest == null) return;
        final synced = latest.tags.map((existing) {
          return existing.localId == updated.localId ? updated : existing;
        }).toList();
        emit(latest.copyWith(tags: synced));
      },
    );
  }

  /// Optimistically removes the tag from state then calls the use case.
  /// Restores the tag if deletion fails.
  Future<void> deleteTag(int tagLocalId) async {
    final currentState =
        state.mapOrNull(success: (s) => s) ?? const TodoTagSuccess(tags: []);

    final deleted = currentState.tags
        .where((t) => t.localId == tagLocalId)
        .firstOrNull;
    final optimistic = currentState.tags
        .where((t) => t.localId != tagLocalId)
        .toList();

    emit(currentState.copyWith(tags: optimistic));

    final result = await deleteTagUseCase(tagLocalId);
    result.fold((_) {
      // Restore on failure
      if (deleted != null) {
        emit(currentState.copyWith(tags: [...currentState.tags, deleted]));
      }
    }, (_) => null);
  }

  /// Pushes all locally dirty or pending-deletion tags to the remote,
  /// then reloads the tag list to reflect the synced state.
  Future<void> sync() async {
    final currentState = state.mapOrNull(success: (s) => s);
    if (currentState != null) emit(currentState.copyWith(isSyncing: true));

    await syncTagsUseCase(NoParams());
    await loadTags();
  }
}
