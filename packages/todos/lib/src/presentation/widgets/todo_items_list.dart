import 'package:material3_indicators/material3_indicators.dart';
import 'package:pomodoro/pomodoro.dart' as pomodoro;
import 'package:todos/src/domain/domain.dart';
import 'package:todos/src/presentation/cubit/todo_item_cubit.dart';
import 'package:todos/src/presentation/cubit/todo_item_state.dart';
import 'package:todos/src/presentation/routes/routes.dart';
import 'package:todos/src/presentation/widgets/completed_todo_section.dart';
import 'package:todos/src/presentation/widgets/todo_card.dart';
import 'package:todos/src/presentation/widgets/todo_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Renders a tasklist's items grouped into an active-items card and a
/// collapsible "Completed" card, with infinite-scroll pagination.
class TodoItemsList extends StatefulWidget {
  final List<TodoItemEntity> items;
  const TodoItemsList({super.key, required this.items});

  @override
  State<TodoItemsList> createState() => _TodoItemsListState();
}

class _TodoItemsListState extends State<TodoItemsList> {
  final _scrollController = ScrollController();
  bool _completedExpanded = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    final nearBottom = position.pixels >= position.maxScrollExtent - 200;

    if (nearBottom) {
      context.read<TodoItemCubit>().loadMore();
    }
  }

  Widget _buildCard(BuildContext context, TodoItemEntity item) {
    return TodoCard(
      item: item,
      onEdit: () =>
          UpdateTodoItemRoute(todoLocalID: item.localId).push(context),
      onFocusTimer: () =>
          pomodoro.PomodoroTimerRoute(todoLocalID: item.localId).push(context),
      onComplete: () =>
          context.read<TodoItemCubit>().completeItem(item.localId),
      onReopen: () => context.read<TodoItemCubit>().reopenItem(item.localId),
      onDelete: () => context.read<TodoItemCubit>().deleteItem(item.localId),
    );
  }

  Widget _buildFooter(BuildContext context, {required bool hasActiveItems}) {
    return BlocBuilder<TodoItemCubit, TodoItemState>(
      builder: (context, state) {
        final isPaginating = state.maybeWhen(
          success: (_, _, isPaginating, _) => isPaginating,
          orElse: () => false,
        );
        final hasMore = state.maybeWhen(
          success: (_, nextUrl, _, _) => nextUrl != null,
          orElse: () => false,
        );

        if (isPaginating) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: WavyCircularProgressIndicator(
                size: 24,
                amplitude: 2,
                frequency: 8,
              ),
            ),
          );
        }

        if (!hasMore && !hasActiveItems) {
          final theme = Theme.of(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 36),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    size: 36,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'All done for now',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your next task will show up here.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeItems = widget.items
        .where((i) => i.status != TodoStatus.completed)
        .toList();
    final completedItems = widget.items
        .where((i) => i.status == TodoStatus.completed)
        .toList();

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        if (activeItems.isNotEmpty)
          TodoSectionCard(
            children: activeItems
                .map((item) => _buildCard(context, item))
                .toList(),
          ),
        if (completedItems.isNotEmpty) ...[
          if (activeItems.isNotEmpty) const SizedBox(height: 12),
          CompletedTodoSection(
            items: completedItems,
            expanded: _completedExpanded,
            onToggleExpanded: () =>
                setState(() => _completedExpanded = !_completedExpanded),
            itemBuilder: _buildCard,
          ),
        ],
        _buildFooter(context, hasActiveItems: activeItems.isNotEmpty),
      ],
    );
  }
}
