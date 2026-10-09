import 'package:todos/src/domain/domain.dart';
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
            borderRadius: BorderRadius.circular(20),
            onTap: onToggleExpanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 20,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Completed',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${items.length}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSecondaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
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
