import 'package:flutter/material.dart';
import 'package:academia/features/notifications/notifications.dart';

/// Widget to display notification count badge
class NotificationBadge extends StatelessWidget {
  final int count;
  final double size;
  final Color color;

  const NotificationBadge({
    super.key,
    required this.count,
    this.size = 16.0,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count > 99 ? '99+' : count.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Widget to display a single notification item
class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: notification.isRead ? Colors.grey : Colors.blue,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.body),
          const SizedBox(height: 4),
          Text(
            _formatDate(notification.createdAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

