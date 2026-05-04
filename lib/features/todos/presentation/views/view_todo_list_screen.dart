import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/core/core.dart';

class ViewTodoListScreen extends StatefulWidget {
  const ViewTodoListScreen({super.key, required this.todoListId});
  final int todoListId;

  @override
  State<ViewTodoListScreen> createState() => _ViewTodoListScreenState();
}

class _ViewTodoListScreenState extends State<ViewTodoListScreen> {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TodoListEntity? todoList;
  Color? taskListColor;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<TodoListCubit>().updateTodoList(
        todoList!.copyWith(
          title: titleController.text,
          color: taskListColor!.toARGB32(),
        ),
      );
    }
  }

  bool get _hasUnsavedChanges {
    if (todoList == null) return false;
    final titleChanged = titleController.text != todoList!.title;
    final colorChanged = taskListColor?.toARGB32() != todoList!.color;
    return titleChanged || colorChanged;
  }

  Future<void> _handlePop(bool didPop) async {
    // If the system already popped the screen, do nothing
    if (didPop) return;

    // If no changes, just pop
    if (!_hasUnsavedChanges) {
      context.pop();
      return;
    }

    // Show the "Unsaved Changes" warning
    final shouldPop = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unsaved Changes"),
        content: const Text(
          "You have unsaved changes. Do you want to save them before leaving?",
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text("Keep Editing"),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text("Discard", style: TextStyle(color: Colors.red)),
          ),
          FilledButton(
            onPressed: () {
              _saveChanges();
              context.pop(true);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (shouldPop == true && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListCubit, TodoListState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (todoLists, _, _, _) {
            // Locate the specific list
            if (!_isInitialized) {
              try {
                todoList = todoLists.firstWhere(
                  (list) => list.localId == widget.todoListId,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  titleController.text = todoList?.title ?? "";
                  if (mounted) setState(() => _isInitialized = true);
                });
                taskListColor = Color(todoList!.color!);
                _isInitialized = true;
              } catch (_) {
                todoList = null;
              }
            }

            return PopScope(
              canPop: !_hasUnsavedChanges,
              onPopInvokedWithResult: (didPop, result) => _handlePop(didPop),
              child: SheetContentScaffold(
                topBar: _buildAppBar(context),
                body: SafeArea(
                  minimum: const EdgeInsets.all(16),
                  child: todoList == null ? _buildNotFound() : _buildEditForm(),
                ),
              ),
            );
          },
          orElse: () =>
              const Scaffold(body: Center(child: LoadingIndicatorM3E())),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Edit todo list"),
      actions: [
        IconButton(
          onPressed: () async {
            final confirmDelete = await showAdaptiveDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text(
                  "Deleting this task list will also delete associated tasks."
                  "\nThis action isn't reversible.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );

            if (confirmDelete == true && context.mounted) {
              context.read<TodoListCubit>().deleteTodoList(widget.todoListId);
              context.pop(); // Close the sheet
            }
          },
          icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -1.0,
              color: taskListColor?.withAlpha(255) ?? Colors.black,
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            validator: (input) =>
                (input?.length ?? 0) < 3 ? "Title too short" : null,
            decoration: InputDecoration(
              hintText: "Homework",
              hintStyle: TextStyle(color: taskListColor?.withAlpha(128)),
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 22),
          const Text("Please pick a color for this task list"),
          const SizedBox(height: 22),
          ColorSeedCard(
            currentColor: taskListColor!,
            onColorChanged: (color) {
              setState(() => taskListColor = color);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.plane.image(width: 200),
          const Text(
            "404! Not Found",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text("The selected todo list has been deleted."),
        ],
      ),
    );
  }
}
