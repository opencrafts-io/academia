import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class UpdateTodoUsecase implements UseCase<Todo, Todo> {
  TodoRepository todoRepository;
  UpdateTodoUsecase({required this.todoRepository});

  @override
  Future<Either<Failure, Todo>> call(Todo todoParam) {
    return todoRepository.updateTodo(todoParam);
  }
}
