import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/features/todos/domain/entities/todo_list_entity.dart';

abstract class TodoListRepository {
  /// Fetches a paginated list of todo lists.
  /// [url] is optional for fetching subsequent pages in an endless scroll.
  Future<Either<Failure, TodoPage>> getTodoLists({String? url});

  /// Retrieves a specific todo list by its remote UUID.
  Future<Either<Failure, TodoListEntity>> getTodoListById(String id);

  /// Creates a new todo list.
  /// Usually handles local creation first, then marks for remote sync.
  Future<Either<Failure, TodoListEntity>> createTodoList(
    TodoListEntity todoList,
  );

  /// Updates an existing todo list.
  Future<Either<Failure, TodoListEntity>> updateTodoList(
    TodoListEntity todoList,
  );

  /// Deletes a todo list.
  /// In a sync-enabled app, this often marks the item as 'pending deletion'
  /// locally before removing it from the server.
  Future<Either<Failure, Unit>> deleteTodoList(int todoListLocalId);

  /// Specific helper to retrieve the user's default list.
  Future<Either<Failure, TodoListEntity>> getDefaultTodoList();

  /// Trigger a manual synchronization between Local and Remote datasources.
  Future<Either<Failure, Unit>> syncTodoLists();
}

/// A simple wrapper for pagination at the Domain level
class TodoPage {
  final List<TodoListEntity> items;
  final String? nextUrl;

  TodoPage({required this.items, this.nextUrl});
}
