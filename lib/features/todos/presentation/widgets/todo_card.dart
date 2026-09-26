import 'dart:async';

import 'package:flutter/material.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:academia/features/todos/presentation/utils/focused_duration_format.dart';
import 'package:intl/intl.dart';
import 'package:time_since/time_since.dart';

enum _TodoCardAction { edit, focus, delete }

class TodoCard extends StatefulWidget {
  final TodoItemEntity item;
  final VoidCallback onComplete;
  final VoidCallback onReopen;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onFocusTimer;

  const TodoCard({
    super.key,
    required this.item,
    required this.onComplete,
    required this.onReopen,
    required this.onDelete,
    required this.onEdit,
    required this.onFocusTimer,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool _expanded = false;

  TodoItemEntity get item => widget.item;
  bool get _isCompleted => item.status == TodoStatus.completed;

  Color _priorityColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (item.priority) {
      TodoPriority.high => Colors.red.shade400,
      TodoPriority.medium => Colors.orange.shade400,
      TodoPriority.low => scheme.primary,
      TodoPriority.none => Colors.transparent,
    };
  }

  Future<void> _deleteWithUndo(BuildContext context) async {
    late Completer<void> delayCompleter;
    bool shouldDelete = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.title} has been deleted"),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            shouldDelete = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            delayCompleter.complete();
          },
        ),
      ),
    );
    delayCompleter = Completer();
    await Future.any([
      Future.delayed(const Duration(seconds: 5)),
      delayCompleter.future,
    ]);
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (shouldDelete) widget.onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(item.localId),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(scheme),
      confirmDismiss: (_) async {
        await _deleteWithUndo(context);
        return false;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: _isCompleted
              ? scheme.surfaceContainerLow
              : scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: scheme.outlineVariant.withAlpha(_isCompleted ? 30 : 70),
          ),
          boxShadow: isDark || _isCompleted
              ? null
              : [
                  BoxShadow(
                    color: scheme.shadow.withAlpha(18),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 14, 10),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 4,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: _priorityColor(context),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Checkbox.adaptive(
                      value: _isCompleted,
                      onChanged: (_) => _isCompleted
                          ? widget.onReopen()
                          : widget.onComplete(),
                      activeColor: scheme.primary,
                      shape: const CircleBorder(),
                      side: BorderSide(
                        color: scheme.outline.withAlpha(150),
                        width: 1.5,
                      ),
                    ),
                    Expanded(child: _buildContent(context, theme, scheme)),
                    _buildActionsButton(context, scheme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme,
    ColorScheme scheme,
  ) {
    final hasNotes = item.notes != null && item.notes!.isNotEmpty;
    final metaChips = [
      if (!_isCompleted && item.due != null) DueDateTime(dateTime: item.due!),
      if (item.focusedSeconds > 0) _buildFocusedTimeChip(context),
      if (!_isCompleted) ...item.tags.map((tag) => _buildTagChip(context, tag)),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: _isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: _isCompleted
                        ? scheme.onSurface.withAlpha(100)
                        : scheme.onSurface,
                  ),
                ),
              ),
              if (item.syncStatus == SyncStatus.pending)
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    size: 14,
                    color: scheme.onSurfaceVariant.withAlpha(128),
                  ),
                ),
            ],
          ),
          if (_isCompleted)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.completed != null
                    ? "Completed: ${DateFormat('EEE d MMM').format(item.completed!)}"
                    : "Completed",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant.withAlpha(180),
                ),
              ),
            )
          else if (hasNotes)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.notes!,
                maxLines: _expanded ? null : 1,
                overflow: _expanded ? null : TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          if (metaChips.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Wrap(spacing: 6, runSpacing: 4, children: metaChips),
            ),
        ],
      ),
    );
  }

  Widget _buildActionsButton(BuildContext context, ColorScheme scheme) {
    return PopupMenuButton<_TodoCardAction>(
      tooltip: "More actions",
      icon: Icon(
        Icons.more_vert_rounded,
        size: 20,
        color: scheme.onSurfaceVariant.withAlpha(180),
      ),
      padding: EdgeInsets.zero,
      onSelected: (action) {
        switch (action) {
          case _TodoCardAction.edit:
            widget.onEdit();
          case _TodoCardAction.focus:
            widget.onFocusTimer();
          case _TodoCardAction.delete:
            _deleteWithUndo(context);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _TodoCardAction.edit,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text("Edit"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        if (!_isCompleted)
          const PopupMenuItem(
            value: _TodoCardAction.focus,
            child: ListTile(
              leading: Icon(Icons.timer_outlined),
              title: Text("Focus timer"),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        PopupMenuItem(
          value: _TodoCardAction.delete,
          child: ListTile(
            leading: Icon(
              Icons.delete_outline_rounded,
              color: Colors.red.shade400,
            ),
            title: Text("Delete", style: TextStyle(color: Colors.red.shade400)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusedTimeChip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, size: 12, color: scheme.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          formatFocusedDuration(Duration(seconds: item.focusedSeconds)),
          style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildTagChip(BuildContext context, TodoTagEntity tag) {
    final scheme = Theme.of(context).colorScheme;

    // Parse hex color from tag, fallback to scheme primary
    Color tagColor = scheme.primary;
    if (tag.color != null) {
      final hex = tag.color!.replaceFirst('#', '');
      final parsed = int.tryParse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
      if (parsed != null) tagColor = Color(parsed);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: tagColor.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tagColor.withAlpha(80), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            tag.name,
            style: TextStyle(
              fontSize: 11,
              color: tagColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissBackground(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_outline_rounded, color: Colors.white),
          SizedBox(height: 4),
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class DueDateTime extends StatefulWidget {
  final DateTime dateTime;
  final bool isCompleted;
  final IconData? overdueIcon;
  final IconData? upcomingIcon;
  final double fontSize;
  final bool showBold;

  const DueDateTime({
    super.key,
    required this.dateTime,
    this.isCompleted = false,
    this.overdueIcon = Icons.warning_amber_rounded,
    this.upcomingIcon = Icons.calendar_today_outlined,
    this.fontSize = 11,
    this.showBold = true,
  });

  @override
  State<DueDateTime> createState() => _DueDateTimeState();
}

class _DueDateTimeState extends State<DueDateTime> {
  late DateTime _due;
  late bool _isOverdue;
  late bool _isDueToday;

  @override
  void initState() {
    super.initState();
    _due = widget.dateTime;
    _updateStatus();

    // Rebuild once a minute to update timeago text
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        setState(_updateStatus);
      }
    });
  }

  void _updateStatus() {
    final now = DateTime.now();
    _isOverdue = !widget.isCompleted && _due.isBefore(now);
    _isDueToday =
        !widget.isCompleted &&
        _due.year == now.year &&
        _due.month == now.month &&
        _due.day == now.day;
  }

  String _formatDisplay() {
    if (_isOverdue) {
      return timeSince(_due);
    } else {
      return DateFormat('EEE d MMM, HH:mm').format(_due);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final Color chipColor = switch (true) {
      _ when _isOverdue => Colors.red.shade400,
      _ when _isDueToday => Colors.orange.shade400,
      _ => scheme.onSurfaceVariant,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _isOverdue ? widget.overdueIcon : widget.upcomingIcon,
          size: widget.fontSize + 1,
          color: chipColor,
        ),
        const SizedBox(width: 3),
        Text(
          _formatDisplay(),
          style: TextStyle(
            fontSize: widget.fontSize,
            color: chipColor,
            fontWeight: (widget.showBold && (_isOverdue || _isDueToday))
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
