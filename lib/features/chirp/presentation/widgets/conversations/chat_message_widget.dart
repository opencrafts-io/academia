import 'package:flutter/material.dart';
import 'package:academia/features/chirp/domain/entities/conversations/message.dart';
import 'package:time_since/time_since.dart';
import 'message_status_widget.dart';
import 'image_message_widget.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  final bool isOwnMessage;
  final VoidCallback? onTap;
  final bool showAvatar;
  final bool isFirstInGroup;
  final bool isLastInGroup;
  final MessageStatus? messageStatus;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.isOwnMessage,
    this.onTap,
    this.showAvatar = true,
    this.isFirstInGroup = true,
    this.isLastInGroup = true,
    this.messageStatus,
  });

  @override
  Widget build(BuildContext context) {
    // If message has an image, use ImageMessageWidget
    if (message.imageUrl != null && message.imageUrl!.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: isFirstInGroup ? 4 : 2,
          bottom: isLastInGroup ? 4 : 2,
        ),
        child: ImageMessageWidget(
          message: message,
          isOwnMessage: isOwnMessage,
          showAvatar: showAvatar,
          isFirstInGroup: isFirstInGroup,
          isLastInGroup: isLastInGroup,
        ),
      );
    }

    // Otherwise, show regular text message
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: isFirstInGroup ? 4 : 2,
        bottom: isLastInGroup ? 4 : 2,
      ),
      child: Row(
        mainAxisAlignment: isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for other person's messages (left side)
          if (!isOwnMessage && showAvatar) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundImage: message.sender.avatarUrl != null
                  ? NetworkImage(message.sender.avatarUrl!)
                  : null,
              child: message.sender.avatarUrl == null
                  ? Text(
                      message.sender.name.isNotEmpty
                          ? message.sender.name[0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isOwnMessage
                    ? Theme.of(context).colorScheme.primary
                    : _getMessageBubbleColor(context),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isFirstInGroup ? 18 : 4),
                  topRight: Radius.circular(isFirstInGroup ? 18 : 4),
                  bottomLeft: Radius.circular(
                    isLastInGroup ? (isOwnMessage ? 18 : 4) : 4,
                  ),
                  bottomRight: Radius.circular(
                    isLastInGroup ? (isOwnMessage ? 4 : 18) : 4,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message content
                  if (message.content.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Text(
                        message.content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isOwnMessage
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ),

                  // Timestamp and read status
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(message.sentAt),
                          style: TextStyle(
                            color: isOwnMessage
                                ? Theme.of(
                                    context,
                                  ).colorScheme.onPrimary.withValues(alpha: 0.7)
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isOwnMessage) ...[
                          const SizedBox(width: 6),
                          MessageStatusWidget(
                            status:
                                messageStatus ??
                                (message.isRead
                                    ? MessageStatus.read
                                    : MessageStatus.sent),
                            isOwnMessage: isOwnMessage,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Avatar for own messages (right side)
          if (isOwnMessage && showAvatar) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundImage: message.sender.avatarUrl != null
                  ? NetworkImage(message.sender.avatarUrl!)
                  : null,
              child: message.sender.avatarUrl == null
                  ? Text(
                      message.sender.name.isNotEmpty
                          ? message.sender.name[0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      // Today - show time only
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Yesterday
      return 'Yesterday ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      // Other days - show date and time
      return '${time.day}/${time.month} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  Color _getMessageBubbleColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      // Use a lighter color for better contrast in dark mode
      return const Color(0xFF2A2A2A).withValues(alpha: 0.9);
    } else {
      // Use the default theme color for light mode
      return Theme.of(context).colorScheme.surfaceContainerHigh;
    }
  }
}

// Legacy widget for backward compatibility with Post entity
class ChatMessageWithPostWidget extends StatelessWidget {
  final String messageId;
  final String userId;
  final String content;
  final DateTime timestamp;
  final bool isOwnMessage;
  final VoidCallback? onTap;

  const ChatMessageWithPostWidget({
    super.key,
    required this.messageId,
    required this.userId,
    required this.content,
    required this.timestamp,
    required this.isOwnMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isOwnMessage) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                userId.isNotEmpty ? userId[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isOwnMessage
                    ? Theme.of(context).colorScheme.primary
                    : _getMessageBubbleColor(context),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isOwnMessage ? 18 : 4),
                  bottomRight: Radius.circular(isOwnMessage ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (content.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Text(
                        content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isOwnMessage
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeSince(timestamp),
                          style: TextStyle(
                            color: isOwnMessage
                                ? Theme.of(
                                    context,
                                  ).colorScheme.onPrimary.withValues(alpha: 0.7)
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isOwnMessage) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withValues(alpha: 0.7),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isOwnMessage) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                userId.isNotEmpty ? userId[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getMessageBubbleColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      // Use a lighter color for better contrast in dark mode
      return const Color(0xFF2A2A2A).withValues(alpha: 0.9);
    } else {
      // Use the default theme color for light mode
      return Theme.of(context).colorScheme.surfaceContainerHigh;
    }
  }
}
