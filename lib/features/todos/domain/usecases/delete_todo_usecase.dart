import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoUsecase implements UseCase<Todo, Todo> {
  final TodoRepository todoRepository;

  DeleteTodoUsecase({required this.todoRepository});

  @override
  Future<Either<Failure, Todo>> call(Todo todoParams) {
    return todoRepository.deleteTodo(todoParams);
  }
}
