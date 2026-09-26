import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';

class TodoItemMoreOptionsSheet extends StatelessWidget {
  const TodoItemMoreOptionsSheet({
    super.key,
    required this.dueDate,
    required this.priority,
    required this.onDueDateChanged,
    required this.onPriorityChanged,
    required this.onClearDueDate,
    this.onStartFocusTimer,
    this.focusedSeconds = 0,
  });

  final DateTime? dueDate;
  final TodoPriority priority;
  final ValueChanged<DateTime?> onDueDateChanged;
  final ValueChanged<TodoPriority> onPriorityChanged;
  final VoidCallback onClearDueDate;

  /// Shown as a "Focus timer" option when set. Omitted for todos that
  /// haven't been saved yet, since there's nothing to attribute time to.
  final VoidCallback? onStartFocusTimer;

  /// Cumulative focus time already tracked against this task.
  final int focusedSeconds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More options",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Due date
          ListTile(
            leading: CircleAvatar(
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                Icons.calendar_today_outlined,
                color: scheme.onPrimaryContainer,
                size: 18,
              ),
            ),
            title: const Text("Due date"),
            subtitle: dueDate != null
                ? Text(dueDate!.toLocal().toString().split(' ')[0])
                : const Text("Not set"),
            trailing: dueDate != null
                ? IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: onClearDueDate,
                  )
                : const Icon(Icons.chevron_right),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: dueDate ?? now,
                firstDate: now,
                lastDate: now.add(const Duration(days: 365 * 5)),
              );
              onDueDateChanged(picked);
            },
          ),

          // Priority
          ListTile(
            leading: CircleAvatar(
              backgroundColor: scheme.secondaryContainer,
              child: Icon(
                Icons.flag_outlined,
                color: scheme.onSecondaryContainer,
                size: 18,
              ),
            ),
            title: const Text("Priority"),
            subtitle: Text(
              priority.name[0].toUpperCase() + priority.name.substring(1),
            ),
            trailing: const Icon(Icons.chevron_right),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (_) => TodoItemPrioritySheet(
                  current: priority,
                  onSelected: onPriorityChanged,
                ),
              );
            },
          ),

          if (onStartFocusTimer != null) ...[
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.tertiaryContainer,
                child: Icon(
                  Icons.timer_outlined,
                  color: scheme.onTertiaryContainer,
                  size: 18,
                ),
              ),
              title: const Text("Focus timer"),
              subtitle: Text(
                focusedSeconds > 0
                    ? "${formatFocusedDuration(Duration(seconds: focusedSeconds))} tracked"
                    : "Start a Pomodoro session",
              ),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {
                Navigator.pop(context);
                onStartFocusTimer!();
              },
            ),
          ],
        ],
      ),
    );
  }
}
