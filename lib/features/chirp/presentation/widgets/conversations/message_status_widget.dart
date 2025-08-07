import 'package:flutter/material.dart';

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageStatusWidget extends StatelessWidget {
  final MessageStatus status;
  final bool isOwnMessage;

  const MessageStatusWidget({
    super.key,
    required this.status,
    required this.isOwnMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOwnMessage) return const SizedBox.shrink();

    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        icon = Icons.schedule;
        color = Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.5);
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7);
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Theme.of(context).colorScheme.primary;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = Theme.of(context).colorScheme.error;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }
}
