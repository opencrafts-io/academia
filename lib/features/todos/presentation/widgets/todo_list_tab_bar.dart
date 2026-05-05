import 'package:academia/features/todos/todos.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:flutter/material.dart';

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
              final color = _colorFromHex(list.color, context);
              return GestureDetector(
                onLongPress: () => onLongPressList(list),
                child: Badge(
                  offset: Offset(10, 0),
                  backgroundColor: color,
                  isLabelVisible: list.taskCount > 0,
                  label: Text("${list.taskCount}"),
                  child: Tab(child: Text(list.title)),
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
