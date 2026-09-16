import 'package:academia/features/todos/domain/domain.dart';

class TodoTagPage {
  final List<TodoTagEntity> items;
  final String? nextUrl;

  const TodoTagPage({required this.items, this.nextUrl});
}
