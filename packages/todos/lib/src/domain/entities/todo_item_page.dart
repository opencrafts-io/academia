import 'package:todos/src/domain/domain.dart';

class TodoItemPage {
  final List<TodoItemEntity> items;
  final String? nextUrl;

  const TodoItemPage({required this.items, this.nextUrl});
}
