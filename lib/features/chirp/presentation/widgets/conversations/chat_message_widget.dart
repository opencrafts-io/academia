import 'package:flutter/material.dart';
import 'package:academia/features/chirp/domain/entities/conversations/message.dart' as domain;
import 'package:time_since/time_since.dart';
import 'message_status_widget.dart' as status_widget;
import 'message_status_widget.dart' show MessageStatus;

class ChatMessageWidget extends StatelessWidget {
  final domain.Message message;
  final bool isOwnMessage;
  final VoidCallback? onTap;
  final bool showAvatar;
  final bool isFirstInGroup;
  final bool isLastInGroup;
  final domain.MessageStatus? messageStatus;

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.only(
        left: isOwnMessage ? 64 : 16,
        right: isOwnMessage ? 16 : 64,
        top: isFirstInGroup ? 8 : 2,
        bottom: isLastInGroup ? 8 : 2,
      ),
      child: Row(
        mainAxisAlignment: isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for other person's messages (left side)
          if (!isOwnMessage && showAvatar) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage: message.sender.avatar != null
                    ? NetworkImage(message.sender.avatar!)
                    : null,
                child: message.sender.avatar == null
                    ? Text(
                        message.sender.name.isNotEmpty
                            ? message.sender.name[0].toUpperCase()
                            : 'U',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Empty space for alignment when no avatar
          if (!isOwnMessage && !showAvatar)
            const SizedBox(width: 44),

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                minWidth: 60,
              ),
              decoration: BoxDecoration(
                color: isOwnMessage
                    ? _getOwnMessageColor(context)
                    : _getReceivedMessageColor(context),
                borderRadius: _getBorderRadius(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sender name for group chats (received messages only)
                  if (!isOwnMessage && isFirstInGroup && showAvatar)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(
                        message.sender.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _getSenderNameColor(message.sender.name, context),
                        ),
                      ),
                    ),
                  
                  // Message content
                  if (message.content.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        16, 
                        (!isOwnMessage && isFirstInGroup && showAvatar) ? 0 : 12, 
                        16, 
                        4
                      ),
                      child: Text(
                        message.content,
                        style: TextStyle(
                          color: isOwnMessage
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                      ),
                    ),

                  // Timestamp and read status
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _formatTime(message.sentAt),
                          style: TextStyle(
                            color: isOwnMessage
                                ? Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (isOwnMessage) ...[
                          const SizedBox(width: 4),
                          status_widget.MessageStatusWidget(
                            status: _mapMessageStatus(messageStatus ?? message.status),
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

          // Avatar for own messages (right side) - typically not shown in WhatsApp
          // Keeping this minimal for now
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

  Color _getOwnMessageColor(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }
  
  Color _getReceivedMessageColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHigh;
  }
  
  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(isOwnMessage && isFirstInGroup ? 20 : (isFirstInGroup ? 20 : 8)),
      topRight: Radius.circular(!isOwnMessage && isFirstInGroup ? 20 : (isFirstInGroup ? 20 : 8)),
      bottomLeft: Radius.circular(
        isLastInGroup ? (isOwnMessage ? 20 : 8) : 8,
      ),
      bottomRight: Radius.circular(
        isLastInGroup ? (isOwnMessage ? 8 : 20) : 8,
      ),
    );
  }
  
  Color _getSenderNameColor(String name, BuildContext context) {
    // Generate consistent color for sender names using Material 3 colors
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.error,
      theme.colorScheme.primaryContainer,
      theme.colorScheme.secondaryContainer,
      theme.colorScheme.tertiaryContainer,
    ];
    
    final hash = name.hashCode;
    final colorIndex = hash.abs() % colors.length;
    return colors[colorIndex];
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

  /// Maps domain MessageStatus to widget MessageStatus
  MessageStatus _mapMessageStatus(domain.MessageStatus domainStatus) {
    switch (domainStatus) {
      case domain.MessageStatus.pending:
        return MessageStatus.sending;
      case domain.MessageStatus.sent:
        return MessageStatus.sent;
      case domain.MessageStatus.delivered:
        return MessageStatus.delivered;
      case domain.MessageStatus.read:
        return MessageStatus.read;
      case domain.MessageStatus.failed:
        return MessageStatus.failed;
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
