import 'package:academia/features/todos/domain/domain.dart';
import 'package:flutter/material.dart';

/// A collapsible "Completed (n)" section, kept separate from active items so
/// a finished task's due date/priority no longer reads as still pending.
class CompletedTodoSection extends StatelessWidget {
  final List<TodoItemEntity> items;
  final bool expanded;
  final VoidCallback onToggleExpanded;
  final Widget Function(BuildContext, TodoItemEntity) itemBuilder;

  const CompletedTodoSection({
    super.key,
    required this.items,
    required this.expanded,
    required this.onToggleExpanded,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onToggleExpanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Completed (${items.length})",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubicEmphasized,
          alignment: Alignment.topCenter,
          child: expanded
              ? Column(
                  children: items
                      .map((item) => itemBuilder(context, item))
                      .toList(),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
