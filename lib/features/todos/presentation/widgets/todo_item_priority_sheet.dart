import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';

class TodoItemPrioritySheet extends StatelessWidget {
  const TodoItemPrioritySheet({
    super.key,
    required this.current,
    required this.onSelected,
  });
  final TodoPriority current;
  final ValueChanged<TodoPriority> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final options = [
      (
        TodoPriority.high,
        "High",
        Icons.keyboard_double_arrow_up_rounded,
        Colors.red.shade400,
      ),
      (
        TodoPriority.medium,
        "Medium",
        Icons.drag_handle_rounded,
        Colors.orange.shade400,
      ),
      (
        TodoPriority.low,
        "Low",
        Icons.keyboard_double_arrow_down_rounded,
        Colors.blue.shade400,
      ),
      (TodoPriority.none, "None", Icons.remove, Colors.grey),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Priority",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...options.map((o) {
            final (priority, label, icon, color) = o;
            final selected = current == priority;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withAlpha(30),
                radius: 18,
                child: Icon(icon, color: color, size: 18),
              ),
              title: Text(label),
              trailing: selected
                  ? Icon(
                      Icons.check_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              selected: selected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () => onSelected(priority),
            );
          }),
        ],
      ),
    );
  }
}
