import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TodoListEntity> lists;
  final VoidCallback onAddPressed;
  final void Function(TodoListEntity) onLongPressList;
  final bool isLoading;

  const TodoListTabBar({
    super.key,
    required this.lists,
    required this.onAddPressed,
    required this.onLongPressList,
    this.isLoading = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(48);

  Color _colorFromHex(int? hex, BuildContext context) {
    if (hex == null) return Theme.of(context).colorScheme.primary;
    return Color(hex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            ...lists.map((list) {
              final todosCount = context.watch<TodoItemCubit>().state.maybeWhen(
                success: (item, _, _, _) => item
                    .where(
                      (item) =>
                          item.taskListLocalId == list.localId &&
                          (item.due?.isAfter(DateTime.now()) ?? true) &&
                          item.completed == null,
                    )
                    .length,
                orElse: () => 0,
              );
              final color = _colorFromHex(list.color, context);
              return GestureDetector(
                onLongPress: () => onLongPressList(list),
                child: Badge(
                  offset: Offset(10, 0),
                  backgroundColor: color.withAlpha(255),
                  isLabelVisible: list.taskCount > 0,
                  label: Text("$todosCount"),
                  child: Tab(
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        list.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              );
            }),
            Tab(
              child: TextButton.icon(
                onPressed: onAddPressed,
                icon: const Icon(Icons.add, size: 18),
                label: const Text("New List"),
              ),
            ),
          ],
        ),
        if (isLoading)
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(minHeight: 2),
          ),
      ],
    );
  }
}
