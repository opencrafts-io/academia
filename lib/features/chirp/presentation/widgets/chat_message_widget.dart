import 'package:flutter/material.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/presentation/widgets/attachment_widget.dart';
import 'package:time_since/time_since.dart';

class ChatMessageWidget extends StatelessWidget {
  final Post message;
  final bool isOwnMessage;
  final VoidCallback? onTap;

  const ChatMessageWidget({
    super.key,
    required this.message,
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
              backgroundColor: Colors.grey[300],
              child: Text(
                message.userId.isNotEmpty
                    ? message.userId[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isOwnMessage
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isOwnMessage ? 16 : 4),
                  bottomRight: Radius.circular(isOwnMessage ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
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
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                      child: Text(
                        message.content,
                        style: TextStyle(
                          color: isOwnMessage ? Colors.white : null,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  // Attachments
                  if (message.attachments.isNotEmpty)
                    ...message.attachments
                        .map(
                          (attachment) => Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                            child: GestureDetector(
                              onTap: onTap,
                              child: AttachmentWidget(attachment: attachment),
                            ),
                          ),
                        )
                        .toList(),

                  // Timestamp
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeSince(message.createdAt),
                          style: TextStyle(
                            color: isOwnMessage
                                ? Colors.white.withValues(alpha: 0.7)
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (isOwnMessage) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isOwnMessage) const SizedBox(width: 24),
        ],
      ),
    );
  }
}

class ChatMessageWithAttachmentsWidget extends StatelessWidget {
  final String messageId;
  final String userId;
  final String content;
  final List<Attachment> attachments;
  final DateTime timestamp;
  final bool isOwnMessage;
  final VoidCallback? onTap;

  const ChatMessageWithAttachmentsWidget({
    super.key,
    required this.messageId,
    required this.userId,
    required this.content,
    required this.attachments,
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
              backgroundColor: Colors.grey[300],
              child: Text(
                userId.isNotEmpty ? userId[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isOwnMessage
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isOwnMessage ? 16 : 4),
                  bottomRight: Radius.circular(isOwnMessage ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message content
                  if (content.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                      child: Text(
                        content,
                        style: TextStyle(
                          color: isOwnMessage ? Colors.white : null,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  // Attachments
                  if (attachments.isNotEmpty)
                    ...attachments
                        .map(
                          (attachment) => Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                            child: GestureDetector(
                              onTap: onTap,
                              child: AttachmentWidget(attachment: attachment),
                            ),
                          ),
                        )
                        .toList(),

                  // Timestamp
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeSince(timestamp),
                          style: TextStyle(
                            color: isOwnMessage
                                ? Colors.white.withValues(alpha: 0.7)
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (isOwnMessage) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isOwnMessage) const SizedBox(width: 24),
        ],
      ),
    );
  }
}
