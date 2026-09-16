import 'dart:async';

import 'package:flutter/material.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:intl/intl.dart';
import 'package:time_since/time_since.dart';

class TodoCard extends StatelessWidget {
  final TodoItemEntity item;
  final VoidCallback onComplete;
  final VoidCallback onReopen;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const TodoCard({
    super.key,
    required this.item,
    required this.onComplete,
    required this.onReopen,
    required this.onDelete,
    this.onTap,
  });

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Dismissible(
      key: ValueKey(item.localId),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(scheme),
      confirmDismiss: (_) async {
        late Completer<void> delayCompleter;
        bool shouldDelete = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${item.title} has been deleted"),
            duration: Duration(seconds: 5),
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
          Future.delayed(Duration(seconds: 5)),
          delayCompleter.future,
        ]);
        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (shouldDelete) {
            onDelete();
          }
        }
        return false;
      },
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4),
        ),
        leading: Checkbox.adaptive(
          value: _isCompleted,
          onChanged: (_) => _isCompleted ? onReopen() : onComplete(),
          shape: CircleBorder(),
        ),
        onTap: onTap,
        title: Text(
          item.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            decoration: _isCompleted ? TextDecoration.lineThrough : null,
            color: _isCompleted
                ? scheme.onSurface.withAlpha(100)
                : scheme.onSurface,
          ),
        ),
        titleAlignment: ListTileTitleAlignment.top,
        isThreeLine: true,
        contentPadding: EdgeInsets.zero,
        subtitle: _buildContent(context),
        trailing: _isCompleted
            ? null
            : Column(
                spacing: 4,
                children: [
                  if (item.syncStatus == SyncStatus.pending)
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 14,
                      color: scheme.onSurfaceVariant.withAlpha(128),
                    ),

                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: _priorityColor(context),
                      borderRadius: BorderRadiusGeometry.circular(32),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // A completed task is done - showing its (now stale) due date and
    // priority would make a finished task look urgent/overdue. Show when
    // it was completed instead.
    if (_isCompleted) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          item.completed != null
              ? "Completed: ${DateFormat('EEE d MMM').format(item.completed!)}"
              : "Completed",
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant.withAlpha(180),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.notes != null && item.notes!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            item.notes!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 8),
        // Tags + due date row
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            if (item.due != null) DueDateTime(dateTime: item.due!),
            ...item.tags.map((tag) => _buildTagChip(context, tag)),
          ],
        ),
        const SizedBox(height: 6),
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(12),
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
