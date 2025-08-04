import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class CreateTodoUsecase implements UseCase<Todo, Todo> {
  final TodoRepository todoRepository;
  CreateTodoUsecase({required this.todoRepository});

  @override
  Future<Either<Failure, Todo>> call(Todo todoParam) {
    return todoRepository.createTodo(todoParam);
  }
}
