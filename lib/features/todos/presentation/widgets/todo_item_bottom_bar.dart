import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';

class TodoItemBottomBar extends StatelessWidget {
  final DateTime? dueDate;
  final TodoPriority priority;
  final int tagCount;
  final VoidCallback onTimerTap;
  final VoidCallback onTagTap;
  final VoidCallback onPriorityTap;
  final VoidCallback onMoreTap;

  const TodoItemBottomBar({
    super.key,
    required this.dueDate,
    required this.priority,
    required this.tagCount,
    required this.onTimerTap,
    required this.onTagTap,
    required this.onPriorityTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(color: scheme.outlineVariant.withAlpha(80)),
        ),
      ),
      child: Row(
        children: [
          _BarButton(
            icon: Icons.calendar_today_outlined,
            label: dueDate != null ? "Due" : null,
            active: dueDate != null,
            onTap: onTimerTap,
          ),
          const SizedBox(width: 4),
          _BarButton(
            icon: priority == TodoPriority.none
                ? Icons.flag_outlined
                : Icons.flag_rounded,
            label: priority != TodoPriority.none ? "Priority" : null,
            active: priority != TodoPriority.none,
            activeColor: switch (priority) {
              TodoPriority.high => Colors.red.shade400,
              TodoPriority.medium => Colors.orange.shade400,
              TodoPriority.low => Colors.blue.shade400,
              _ => null,
            },
            onTap: onPriorityTap,
          ),
          const SizedBox(width: 4),
          _BarButton(
            icon: Icons.tag_rounded,
            label: tagCount > 0 ? "$tagCount" : null,
            active: tagCount > 0,
            onTap: onTagTap,
          ),
          const Spacer(),
          // IconButton.filledTonal(
          //   onPressed: onMoreTap,
          //   icon: const Icon(Icons.more_horiz_rounded),
          // ),
        ],
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool active;
  final Color? activeColor;
  final VoidCallback onTap;

  const _BarButton({
    required this.icon,
    required this.active,
    required this.onTap,
    this.label,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? (activeColor ?? scheme.primary) : null;

    if (active && label != null) {
      return ActionChip(
        avatar: Icon(icon, size: 16, color: color),
        label: Text(label!, style: TextStyle(color: color, fontSize: 12)),
        onPressed: onTap,
        side: BorderSide(color: color?.withAlpha(80) ?? scheme.outlineVariant),
        backgroundColor: color?.withAlpha(20),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      );
    }

    return IconButton.filledTonal(
      onPressed: onTap,
      icon: Icon(icon),
      iconSize: 20,
    );
  }
}
