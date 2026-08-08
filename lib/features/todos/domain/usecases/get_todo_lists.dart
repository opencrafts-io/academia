import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTodoLists extends UseCase<TodoPage, GetTodoListsParams> {
  final TodoListRepository repository;

  GetTodoLists(this.repository);

  @override
  Future<Either<Failure, TodoPage>> call(GetTodoListsParams params) async {
    return await repository.getTodoLists(url: params.url);
  }
}

class GetTodoListsParams extends Equatable {
  final String? url;

  const GetTodoListsParams({this.url});

  @override
  List<Object?> get props => [url];
}
