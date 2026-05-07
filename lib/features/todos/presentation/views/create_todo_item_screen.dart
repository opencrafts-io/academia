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
    Navigator.of(context).pop();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _dueDate = picked);
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
      builder: (context) => _PrioritySheet(
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
      builder: (context) => _TagsSheet(
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
      builder: (context) => _MoreOptionsSheet(
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
                        _MetaChip(
                          icon: Icons.calendar_today_outlined,
                          label: _formatDate(_dueDate!),
                          color: _dueDateColor(scheme),
                          onDeleted: () => setState(() => _dueDate = null),
                        ),
                      if (_priority != TodoPriority.none)
                        _MetaChip(
                          icon: _priorityIcon(_priority),
                          label:
                              _priority.name[0].toUpperCase() +
                              _priority.name.substring(1),
                          color: _priorityColor(_priority),
                          onDeleted: () =>
                              setState(() => _priority = TodoPriority.none),
                        ),
                      ..._selectedTags.map(
                        (tag) => _MetaChip(
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

                _BottomBar(
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

class _BottomBar extends StatelessWidget {
  final DateTime? dueDate;
  final TodoPriority priority;
  final int tagCount;
  final VoidCallback onTimerTap;
  final VoidCallback onTagTap;
  final VoidCallback onPriorityTap;
  final VoidCallback onMoreTap;

  const _BottomBar({
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
          IconButton.filledTonal(
            onPressed: onMoreTap,
            icon: const Icon(Icons.more_horiz_rounded),
          ),
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

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onDeleted;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      deleteIcon: Icon(Icons.close, size: 14, color: color.withAlpha(180)),
      onDeleted: onDeleted,
      backgroundColor: color.withAlpha(20),
      side: BorderSide(color: color.withAlpha(80)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _PrioritySheet extends StatelessWidget {
  final TodoPriority current;
  final ValueChanged<TodoPriority> onSelected;

  const _PrioritySheet({required this.current, required this.onSelected});

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

class _TagsSheet extends StatefulWidget {
  final List<TodoTagEntity> selectedTags;
  final ValueChanged<List<TodoTagEntity>> onChanged;

  const _TagsSheet({required this.selectedTags, required this.onChanged});

  @override
  State<_TagsSheet> createState() => _TagsSheetState();
}

class _TagsSheetState extends State<_TagsSheet> {
  late List<TodoTagEntity> _selected;
  final _newTagController = TextEditingController();
  bool _showCreateField = false;
  Color _newTagColor = const Color(0xFF0061A4);

  static const _swatchColors = [
    Color(0xFF0061A4),
    Color(0xFF9C4DFF),
    Color(0xFF00B37E),
    Color(0xFFFF5A5F),
    Color(0xFFFF9A00),
    Color(0xFF00A3FF),
    Color(0xFFFF3D00),
    Color(0xFFB00020),
  ];

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedTags);
  }

  @override
  void dispose() {
    _newTagController.dispose();
    super.dispose();
  }

  void _toggleTag(TodoTagEntity tag) {
    setState(() {
      if (_selected.any((t) => t.localId == tag.localId)) {
        _selected.removeWhere((t) => t.localId == tag.localId);
      } else {
        _selected.add(tag);
      }
    });
    widget.onChanged(_selected);
  }

  void _createTag() {
    final name = _newTagController.text.trim();
    if (name.isEmpty) return;

    final hex =
        '#${_newTagColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    context.read<TodoTagCubit>().createTag(
      TodoTagEntity(
        localId: 0,
        name: name,
        color: hex,
        syncStatus: SyncStatus.pending,
        isPendingDeletion: false,
        isDirty: true,
      ),
    );

    _newTagController.clear();
    setState(() => _showCreateField = false);
  }

  Color _tagColor(TodoTagEntity tag, ColorScheme scheme) {
    if (tag.color == null) return scheme.primary;
    final hex = tag.color!.replaceFirst('#', '');
    final parsed = int.tryParse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
    return parsed != null ? Color(parsed) : scheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Tags",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () =>
                    setState(() => _showCreateField = !_showCreateField),
                icon: Icon(
                  _showCreateField ? Icons.close : Icons.add,
                  size: 16,
                ),
                label: Text(_showCreateField ? "Cancel" : "New tag"),
              ),
            ],
          ),

          if (_showCreateField) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                // Color swatch picker
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Pick a color"),
                        content: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _swatchColors.map((c) {
                            return GestureDetector(
                              onTap: () {
                                setState(() => _newTagColor = c);
                                Navigator.pop(context);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: _newTagColor == c
                                      ? Border.all(
                                          color: scheme.onSurface,
                                          width: 3,
                                        )
                                      : null,
                                ),
                                child: _newTagColor == c
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _newTagColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _newTagColor.withAlpha(100),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _newTagController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Tag name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _createTag(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _createTag, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 4),

          BlocBuilder<TodoTagCubit, TodoTagState>(
            builder: (context, state) {
              final tags = state.currentTags;

              if (tags.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.label_outline,
                          size: 40,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "No tags yet",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Tap 'New tag' to create one",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    final isSelected = _selected.any(
                      (t) => t.localId == tag.localId,
                    );
                    final color = _tagColor(tag, scheme);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withAlpha(30),
                        radius: 16,
                        child: Icon(Icons.circle, color: color, size: 10),
                      ),
                      title: Text(tag.name),
                      trailing: isSelected
                          ? Icon(Icons.check_circle_rounded, color: color)
                          : Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: scheme.outlineVariant,
                            ),
                      onTap: () => _toggleTag(tag),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _MoreOptionsSheet extends StatelessWidget {
  final DateTime? dueDate;
  final TodoPriority priority;
  final ValueChanged<DateTime?> onDueDateChanged;
  final ValueChanged<TodoPriority> onPriorityChanged;
  final VoidCallback onClearDueDate;

  const _MoreOptionsSheet({
    required this.dueDate,
    required this.priority,
    required this.onDueDateChanged,
    required this.onPriorityChanged,
    required this.onClearDueDate,
  });

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
                builder: (_) => _PrioritySheet(
                  current: priority,
                  onSelected: onPriorityChanged,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
