part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {}

class TodoInitialState extends TodoState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class TodoErrorState extends TodoState {
  final String error;
  TodoErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

class TodoLoadedState implements TodoState {
  final Stream<List<Todo>> todosStream;
  TodoLoadedState({required this.todosStream});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [todosStream];
}
