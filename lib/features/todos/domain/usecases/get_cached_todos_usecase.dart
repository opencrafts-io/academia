import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';

class GetCachedTodosUsecase implements StreamUseCase<List<Todo>, NoParams> {
  final TodoRepository todoRepository;
  GetCachedTodosUsecase({required this.todoRepository});

  @override
  Stream<List<Todo>> call(NoParams params) {
    return todoRepository.getCachedTodos();
  }
}
