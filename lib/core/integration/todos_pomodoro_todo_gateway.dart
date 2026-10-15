import 'package:pomodoro/pomodoro.dart';
import 'package:todos/todos.dart';

/// Adapts the Todo module's local focus tracking to Pomodoro's host port.
class TodosPomodoroTodoGateway implements PomodoroTodoGateway {
  const TodosPomodoroTodoGateway(this.todoItemCubit);

  final TodoItemCubit todoItemCubit;

  @override
  PomodoroTodoItemsSnapshot getAvailableTodoItems() {
    final state = todoItemCubit.state;
    final pagination = state.mapOrNull(success: (success) => success);

    return PomodoroTodoItemsSnapshot(
      items: state.currentItems
          .where(
            (item) =>
                item.localId != 0 &&
                item.status == TodoStatus.needsAction &&
                !item.hidden &&
                !item.isPendingDeletion,
          )
          .map(
            (item) => PomodoroTodoItem(
              localId: item.localId,
              title: item.title,
              focusedSeconds: item.focusedSeconds,
            ),
          )
          .toList(growable: false),
      isLoading: state.maybeWhen(
        initial: () => true,
        loading: (_) => true,
        orElse: () => false,
      ),
      isLoadingMore: pagination?.isPaginating ?? false,
      hasMore: pagination?.nextUrl != null,
    );
  }

  @override
  Stream<PomodoroTodoItemsSnapshot> watchAvailableTodoItems() async* {
    yield getAvailableTodoItems();
    await for (final _ in todoItemCubit.stream) {
      yield getAvailableTodoItems();
    }
  }

  @override
  Future<void> loadMoreAvailableTodoItems() => todoItemCubit.loadMore();

  @override
  PomodoroTodoItem? findTodoItem(int localId) {
    for (final item in todoItemCubit.state.currentItems) {
      if (item.localId == localId) {
        return PomodoroTodoItem(
          localId: item.localId,
          title: item.title,
          focusedSeconds: item.focusedSeconds,
        );
      }
    }
    return null;
  }

  @override
  Stream<PomodoroTodoItem?> watchTodoItem(int localId) async* {
    yield findTodoItem(localId);
    await for (final _ in todoItemCubit.stream) {
      yield findTodoItem(localId);
    }
  }

  @override
  Future<void> addFocusedTime({
    required int todoLocalId,
    required Duration duration,
  }) async {
    await todoItemCubit.addFocusedTime(
      localId: todoLocalId,
      duration: duration,
    );
  }
}
