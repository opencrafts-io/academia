import 'package:flutter/material.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:intl/intl.dart';

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
        onDelete();
        return false; // Let the cubit handle removal from state
      },
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4),
        ),
        leading: Checkbox.adaptive(
          value: _isCompleted,
          onChanged: (_) => _isCompleted ? onReopen() : onComplete(),
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
        trailing: Column(
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
              decoration: _isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
        const SizedBox(height: 8),
        // Tags + due date row
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            if (item.due != null) _buildDueChip(context),
            ...item.tags.map((tag) => _buildTagChip(context, tag)),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildDueChip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final due = item.due!;
    final isOverdue = !_isCompleted && due.isBefore(now);
    final isDueToday =
        !_isCompleted &&
        due.year == now.year &&
        due.month == now.month &&
        due.day == now.day;

    final Color chipColor = switch (true) {
      _ when isOverdue => Colors.red.shade400,
      _ when isDueToday => Colors.orange.shade400,
      _ => scheme.onSurfaceVariant,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isOverdue
              ? Icons.warning_amber_rounded
              : Icons.calendar_today_outlined,
          size: 12,
          color: chipColor,
        ),
        const SizedBox(width: 3),
        Text(
          _formatDue(due, now),
          style: TextStyle(
            fontSize: 11,
            color: chipColor,
            fontWeight: isOverdue || isDueToday
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _formatDue(DateTime due, DateTime now) {
    final diff = due.difference(now).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Tomorrow";
    if (diff == -1) return "Yesterday";
    if (diff < 0) return "${diff.abs()}d overdue";
    if (diff < 7) return DateFormat('EEEE').format(due); // "Monday"
    return DateFormat('MMM d').format(due); // "Jan 5"
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
