import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:pomodoro/pomodoro.dart' show formatFocusedDuration;
import 'package:intl/intl.dart';

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
    final cardColor = _isCompleted
        ? scheme.surfaceContainerLow
        : isDark
        ? scheme.surfaceContainerHigh
        : scheme.surfaceContainerLowest;

    return Dismissible(
      key: ValueKey(item.localId),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(scheme),
      confirmDismiss: (_) async {
        await _deleteWithUndo(context);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Material(
          color: cardColor,
          elevation: isDark || _isCompleted ? 0 : 1,
          shadowColor: scheme.shadow.withAlpha(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    tooltip: _isCompleted
                        ? 'Reopen ${item.title}'
                        : 'Complete ${item.title}',
                    onPressed: _isCompleted
                        ? widget.onReopen
                        : widget.onComplete,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      switchInCurve: Curves.easeOutCubic,
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        _isCompleted
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        key: ValueKey(_isCompleted),
                        size: 28,
                        color: _isCompleted
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: _buildContent(context, theme, scheme),
                    ),
                  ),
                  const SizedBox(width: 4),
                  _buildActionsButton(context, scheme),
                ],
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
      if (!_isCompleted && item.priority != TodoPriority.none)
        _buildPriorityChip(scheme),
      if (item.focusedSeconds > 0) _buildFocusedTimeChip(context),
      if (!_isCompleted) ...item.tags.map((tag) => _buildTagChip(context, tag)),
      if (item.syncStatus == SyncStatus.pending)
        _TodoMetaPill(
          icon: Icons.cloud_upload_outlined,
          label: 'Syncing',
          background: scheme.surfaceContainerHigh,
          foreground: scheme.onSurfaceVariant,
        ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            maxLines: _expanded ? null : 2,
            overflow: _expanded ? null : TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.25,
              decoration: _isCompleted ? TextDecoration.lineThrough : null,
              color: _isCompleted ? scheme.onSurfaceVariant : scheme.onSurface,
            ),
          ),
          if (_isCompleted)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                item.completed != null
                    ? "Finished ${DateFormat('d MMM').format(item.completed!.toLocal())}"
                    : 'Finished',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            )
          else if (hasNotes)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                item.notes!,
                maxLines: _expanded ? null : 2,
                overflow: _expanded ? null : TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          if (metaChips.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(spacing: 6, runSpacing: 6, children: metaChips),
            ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(ColorScheme scheme) {
    final style = switch (item.priority) {
      TodoPriority.high => (
        label: 'High priority',
        background: scheme.errorContainer,
        foreground: scheme.onErrorContainer,
      ),
      TodoPriority.medium => (
        label: 'Medium priority',
        background: scheme.tertiaryContainer,
        foreground: scheme.onTertiaryContainer,
      ),
      TodoPriority.low => (
        label: 'Low priority',
        background: scheme.secondaryContainer,
        foreground: scheme.onSecondaryContainer,
      ),
      TodoPriority.none => (
        label: '',
        background: scheme.surfaceContainerHigh,
        foreground: scheme.onSurfaceVariant,
      ),
    };
    return _TodoMetaPill(
      icon: Icons.flag_outlined,
      label: style.label,
      background: style.background,
      foreground: style.foreground,
    );
  }

  Widget _buildActionsButton(BuildContext context, ColorScheme scheme) {
    return PopupMenuButton<_TodoCardAction>(
      tooltip: 'Options for ${item.title}',
      icon: Icon(
        Icons.more_vert_rounded,
        size: 24,
        color: scheme.onSurfaceVariant,
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
            leading: Icon(Icons.delete_outline_rounded, color: scheme.error),
            title: Text('Delete', style: TextStyle(color: scheme.error)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusedTimeChip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _TodoMetaPill(
      icon: Icons.timer_outlined,
      label: formatFocusedDuration(Duration(seconds: item.focusedSeconds)),
      background: scheme.primaryContainer,
      foreground: scheme.onPrimaryContainer,
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

    return _TodoMetaPill(
      dotColor: tagColor,
      label: tag.name,
      background: scheme.surfaceContainerHigh,
      foreground: scheme.onSurfaceVariant,
    );
  }

  Widget _buildDismissBackground(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_outline_rounded, color: scheme.onErrorContainer),
          const SizedBox(height: 4),
          Text(
            "Delete",
            style: TextStyle(
              color: scheme.onErrorContainer,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class DueDateTime extends StatelessWidget {
  final DateTime dateTime;

  const DueDateTime({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final due = dateTime.toLocal();
    final now = DateTime.now();
    final isOverdue = due.isBefore(now);
    final isToday = DateUtils.isSameDay(due, now);
    final isTomorrow = DateUtils.isSameDay(
      due,
      now.add(const Duration(days: 1)),
    );
    final time = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(due),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    final label = isOverdue
        ? 'Overdue · ${isToday ? time : DateFormat('d MMM').format(due)}'
        : isToday
        ? 'Today · $time'
        : isTomorrow
        ? 'Tomorrow · $time'
        : DateFormat('EEE, d MMM').format(due);

    return _TodoMetaPill(
      icon: isOverdue ? Icons.error_outline_rounded : Icons.event_outlined,
      label: label,
      background: isOverdue
          ? scheme.errorContainer
          : isToday
          ? scheme.tertiaryContainer
          : scheme.surfaceContainerHigh,
      foreground: isOverdue
          ? scheme.onErrorContainer
          : isToday
          ? scheme.onTertiaryContainer
          : scheme.onSurfaceVariant,
    );
  }
}

class _TodoMetaPill extends StatelessWidget {
  const _TodoMetaPill({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
    this.dotColor,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 5),
            ],
            if (dotColor != null) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(width: 7, height: 7),
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              fit: FlexFit.loose,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 190),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
