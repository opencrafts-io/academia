part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {}

class FetchTodoEvent extends TodoEvent {
  final int page;
  final int pageSize;

  FetchTodoEvent({this.page = 1, this.pageSize = 100});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [page, pageSize];
}

class FetchCachedTodosEvent extends TodoEvent {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  AddTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];

  @override
  bool? get stringify => true;
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  UpdateTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];

  @override
  bool? get stringify => true;
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;
  DeleteTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];

  @override
  bool? get stringify => true;
}
