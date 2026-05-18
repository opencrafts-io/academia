import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:academia/features/todos/todos.dart';

class CreateTodoItemScreen extends StatefulWidget {
  const CreateTodoItemScreen({super.key});

  @override
  State<CreateTodoItemScreen> createState() => _CreateTodoItemScreenState();
}

class _CreateTodoItemScreenState extends State<CreateTodoItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _dueDate;
  TodoPriority _priority = TodoPriority.none;
  final List<TodoTagEntity> _selectedTags = [];
  TodoListEntity? _selectedList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedList == null) {
      final lists =
          context.read<TodoListCubit>().state.mapOrNull(
            success: (s) => s.todoLists,
          ) ??
          [];
      _selectedList =
          lists.where((l) => l.isDefault).firstOrNull ?? lists.firstOrNull;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_selectedList == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a list first")),
      );
      return;
    }

    final entity = TodoItemEntity(
      localId: 0,
      taskListLocalId: _selectedList!.localId,
      title: _titleController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      status: TodoStatus.needsAction,
      priority: _priority,
      due: _dueDate,
      completed: null,
      subtaskCount: 0,
      hidden: false,
      tags: _selectedTags,
      syncStatus: SyncStatus.pending,
      isPendingDeletion: false,
      isDirty: true,
    );

    context.read<TodoItemCubit>().createItem(entity);
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null) return;

    if (!mounted) return;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _dueDate != null
          ? TimeOfDay.fromDateTime(_dueDate!)
          : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _dueDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _showListPicker() {
    final lists =
        context.read<TodoListCubit>().state.mapOrNull(
          success: (s) => s.todoLists,
        ) ??
        [];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a list",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...lists.map((list) {
              final color = list.color != null
                  ? Color(list.color!)
                  : Theme.of(context).colorScheme.primary;
              final isSelected = _selectedList?.localId == list.localId;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withAlpha(30),
                  radius: 16,
                  child: Icon(Icons.list_rounded, color: color, size: 16),
                ),
                title: Text(list.title),
                subtitle: list.isDefault ? const Text("Default") : null,
                trailing: isSelected
                    ? Icon(Icons.check_circle_rounded, color: color)
                    : null,
                selected: isSelected,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  setState(() => _selectedList = list);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showPrioritySheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => TodoItemPrioritySheet(
        current: _priority,
        onSelected: (p) {
          setState(() => _priority = p);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showTagsSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      builder: (context) => TodoTagSheet(
        selectedTags: List.from(_selectedTags),
        onChanged: (tags) => setState(() {
          _selectedTags
            ..clear()
            ..addAll(tags);
        }),
      ),
    );
  }

  void _showMoreSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => TodoItemMoreOptionsSheet(
        dueDate: _dueDate,
        priority: _priority,
        onDueDateChanged: (d) => setState(() => _dueDate = d),
        onPriorityChanged: (p) => setState(() => _priority = p),
        onClearDueDate: () => setState(() => _dueDate = null),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Tomorrow";
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.day}";
  }

  Color _dueDateColor(ColorScheme scheme) {
    if (_dueDate == null) return scheme.primary;
    final now = DateTime.now();
    if (_dueDate!.isBefore(now)) return Colors.red.shade400;
    if (_dueDate!.difference(now).inDays == 0) return Colors.orange.shade400;
    return scheme.primary;
  }

  Color _priorityColor(TodoPriority p) => switch (p) {
    TodoPriority.high => Colors.red.shade400,
    TodoPriority.medium => Colors.orange.shade400,
    TodoPriority.low => Colors.blue.shade400,
    TodoPriority.none => Colors.grey,
  };

  IconData _priorityIcon(TodoPriority p) => switch (p) {
    TodoPriority.high => Icons.keyboard_double_arrow_up_rounded,
    TodoPriority.medium => Icons.drag_handle_rounded,
    TodoPriority.low => Icons.keyboard_double_arrow_down_rounded,
    TodoPriority.none => Icons.flag_outlined,
  };

  Color _parseTagColor(TodoTagEntity tag, ColorScheme scheme) {
    if (tag.color == null) return scheme.primary;
    final hex = tag.color!.replaceFirst('#', '');
    final parsed = int.tryParse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
    return parsed != null ? Color(parsed) : scheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasMeta =
        _dueDate != null ||
        _priority != TodoPriority.none ||
        _selectedTags.isNotEmpty;

    return SheetContentScaffold(
      extendBodyBehindBottomBar: false,
      topBar: AppBar(
        title: const Text("New task"),
        actions: [TextButton(onPressed: _submit, child: const Text("Done"))],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _showListPicker,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.list_rounded,
                          size: 16,
                          color: _selectedList?.color != null
                              ? Color(_selectedList!.color!).withAlpha(128)
                              : scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _selectedList?.title ?? "Select a list",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: _selectedList?.color != null
                                ? Color(_selectedList!.color!).withAlpha(255)
                                : scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 18,
                          color: scheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),

                TextFormField(
                  controller: _titleController,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                  ),
                  maxLength: 100,
                  cursorHeight: 32,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                  validator: (input) {
                    if ((input?.trim().length ?? 0) < 3) {
                      return "Please try a longer title";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "New task",
                    hintStyle: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface.withAlpha(80),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _notesController,
                  style: theme.textTheme.bodyMedium,
                  maxLines: null,
                  minLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Add details",
                    hintStyle: TextStyle(color: scheme.onSurface.withAlpha(80)),
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 12),

                if (hasMeta) ...[
                  const Divider(),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_dueDate != null)
                        TodoItemMetaChip(
                          icon: Icons.calendar_today_outlined,
                          label: _formatDate(_dueDate!),
                          color: _dueDateColor(scheme),
                          onDeleted: () => setState(() => _dueDate = null),
                        ),
                      if (_priority != TodoPriority.none)
                        TodoItemMetaChip(
                          icon: _priorityIcon(_priority),
                          label:
                              _priority.name[0].toUpperCase() +
                              _priority.name.substring(1),
                          color: _priorityColor(_priority),
                          onDeleted: () =>
                              setState(() => _priority = TodoPriority.none),
                        ),
                      ..._selectedTags.map(
                        (tag) => TodoItemMetaChip(
                          icon: Icons.circle,
                          label: tag.name,
                          color: _parseTagColor(tag, scheme),
                          onDeleted: () =>
                              setState(() => _selectedTags.remove(tag)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                TodoItemBottomBar(
                  dueDate: _dueDate,
                  priority: _priority,
                  tagCount: _selectedTags.length,
                  onTimerTap: _pickDueDate,
                  onTagTap: _showTagsSheet,
                  onPriorityTap: _showPrioritySheet,
                  onMoreTap: _showMoreSheet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
