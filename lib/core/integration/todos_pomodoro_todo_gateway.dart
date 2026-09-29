import 'package:pomodoro/pomodoro.dart';
import 'package:todos/todos.dart';

/// Adapts the Todo module's local focus tracking to Pomodoro's host port.
class TodosPomodoroTodoGateway implements PomodoroTodoGateway {
  const TodosPomodoroTodoGateway(this.todoItemCubit);

  final TodoItemCubit todoItemCubit;

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
