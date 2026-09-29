import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/src/domain/gateway/pomodoro_todo_gateway.dart';
import 'package:pomodoro/src/presentation/cubit/pomodoro_cubit.dart';
import 'package:pomodoro/src/presentation/utils/duration_format.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// A result returned from the picker. A null [localId] means clear selection;
/// a null route result means the sheet was dismissed without a choice.
class PomodoroTodoSelection {
  const PomodoroTodoSelection(this.localId);

  final int? localId;
}

class PomodoroTodoPickerScreen extends StatefulWidget {
  const PomodoroTodoPickerScreen({super.key, this.selectedTodoLocalId});

  final int? selectedTodoLocalId;

  @override
  State<PomodoroTodoPickerScreen> createState() =>
      _PomodoroTodoPickerScreenState();
}

class _PomodoroTodoPickerScreenState extends State<PomodoroTodoPickerScreen> {
  late final PomodoroTodoGateway _todoGateway;
  late final Stream<PomodoroTodoItemsSnapshot> _snapshots;
  late PomodoroTodoItemsSnapshot _currentSnapshot;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _todoGateway = context.read<PomodoroCubit>().todoGateway;
    _currentSnapshot = _todoGateway.getAvailableTodoItems();
    _snapshots = _todoGateway.watchAvailableTodoItems();
    _scrollController.addListener(_loadMoreNearBottom);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreNearBottom)
      ..dispose();
    super.dispose();
  }

  void _loadMoreNearBottom() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final todos = _currentSnapshot;
    if (position.pixels >= position.maxScrollExtent - 200 &&
        todos.hasMore &&
        !todos.isLoadingMore) {
      _todoGateway.loadMoreAvailableTodoItems();
    }
  }

  void _select(BuildContext context, int? localId) {
    Navigator.of(context).pop(PomodoroTodoSelection(localId));
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(title: const Text("Choose a Todo")),
      body: StreamBuilder<PomodoroTodoItemsSnapshot>(
        stream: _snapshots,
        initialData: _currentSnapshot,
        builder: (context, snapshot) {
          final todos = snapshot.data ?? _currentSnapshot;
          _currentSnapshot = todos;
          final showEmpty = todos.items.isEmpty && !todos.isLoading;
          final showInitialProgress = todos.items.isEmpty && todos.isLoading;

          return ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              ListTile(
                leading: Icon(
                  widget.selectedTodoLocalId == null
                      ? Icons.check_circle_rounded
                      : Icons.link_off_rounded,
                  color: widget.selectedTodoLocalId == null
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: const Text("Clear selection"),
                subtitle: const Text("Focus without linking a Todo"),
                onTap: () => _select(context, null),
              ),
              const Divider(height: 16),
              if (showInitialProgress)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                )
              else if (showEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    "No active Todos available",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              else
                ...todos.items.map((todo) {
                  final isSelected = todo.localId == widget.selectedTodoLocalId;
                  return ListTile(
                    leading: Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    title: Text(todo.title),
                    subtitle: todo.focusedSeconds == 0
                        ? null
                        : Text(
                            "Tracked ${formatFocusedDuration(Duration(seconds: todo.focusedSeconds))}",
                          ),
                    selected: isSelected,
                    onTap: () => _select(context, todo.localId),
                  );
                }),
              if (todos.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
              if (todos.hasMore && !todos.isLoadingMore)
                TextButton(
                  onPressed: _todoGateway.loadMoreAvailableTodoItems,
                  child: const Text("Load more Todos"),
                ),
            ],
          );
        },
      ),
    );
  }
}
