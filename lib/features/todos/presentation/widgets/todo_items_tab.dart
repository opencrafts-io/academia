import 'package:academia/features/todos/domain/domain.dart';
import 'package:academia/features/todos/presentation/cubit/todo_item_cubit.dart';
import 'package:academia/features/todos/presentation/cubit/todo_item_state.dart';
import 'package:academia/features/todos/presentation/widgets/todo_empty_state.dart';
import 'package:academia/features/todos/presentation/widgets/todo_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

/// A single tab's worth of todo items, scoped to [taskListLocalId] (or all
/// lists when null), sourced from the shared [TodoItemCubit].
class TodoItemsTab extends StatefulWidget {
  final int? taskListLocalId;
  const TodoItemsTab({super.key, this.taskListLocalId});

  @override
  State<TodoItemsTab> createState() => _TodoItemsTabState();
}

class _TodoItemsTabState extends State<TodoItemsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<TodoItemEntity> _filter(List<TodoItemEntity> items) {
    if (widget.taskListLocalId == null) return items;
    return items
        .where((i) => i.taskListLocalId == widget.taskListLocalId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<TodoItemCubit, TodoItemState>(
      builder: (context, state) {
        final items = _filter(state.currentItems);

        return state.when(
          initial: () => const TodoEmptyState(),
          loading: (_) => items.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    LoadingIndicatorM3E(),
                    Text("Your to-dos are just a sec away.."),
                  ],
                )
              : TodoItemsList(items: items),
          success: (_, _, _, _) => items.isEmpty
              ? const TodoEmptyState()
              : TodoItemsList(items: items),
          failure: (_, _) => items.isEmpty
              ? const TodoEmptyState()
              : TodoItemsList(items: items),
        );
      },
    );
  }
}
