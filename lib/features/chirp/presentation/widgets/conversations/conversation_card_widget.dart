import 'package:flutter/material.dart';
import 'package:time_since/time_since.dart';

import '../../../domain/entities/conversations/conversation.dart';

class ConversationCardWidget extends StatelessWidget {
  final Conversation conversation;
  final String? currentUserId;
  final VoidCallback? onTap;

  const ConversationCardWidget({
    super.key,
    required this.conversation,
    this.currentUserId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get the other participant (not the current user)
    final otherParticipant = conversation.participants.firstWhere(
      (p) => p.userId != currentUserId,
      orElse: () => conversation.participants.first,
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  backgroundImage: otherParticipant.avatar != null
                      ? NetworkImage(otherParticipant.avatar!)
                      : null,
                  child: otherParticipant.avatar == null
                      ? Text(
                          otherParticipant.name.isNotEmpty
                              ? otherParticipant.name[0].toUpperCase()
                              : 'U',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        )
                      : null,
                ),
                // Online status indicator (if available)
                if (otherParticipant.isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Participant name
                      Expanded(
                        child: Text(
                          otherParticipant.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Timestamp
                      if (conversation.lastMessage != null)
                        Text(
                          _formatTimestamp(conversation.lastMessage!.sentAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      // Last message preview
                      Expanded(
                        child: conversation.lastMessage != null
                            ? Text(
                                _formatMessagePreview(conversation.lastMessage!),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: conversation.unreadCount > 0
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontWeight: conversation.unreadCount > 0
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                'No messages yet',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                      ),

                      const SizedBox(width: 8),

                      // Unread count badge
                      if (conversation.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: const BoxConstraints(minWidth: 20),
                          child: Text(
                            conversation.unreadCount > 99 
                                ? '99+' 
                                : conversation.unreadCount.toString(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  String _formatMessagePreview(message) {
    // Note: Image/attachment handling would need to be implemented
    // For now, just show text content
    if (message.content.isNotEmpty) {
      return message.content;
    } else {
      return 'Message';
    }
  }
}