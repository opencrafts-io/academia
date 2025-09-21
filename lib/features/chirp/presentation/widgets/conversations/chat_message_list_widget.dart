import 'package:flutter/material.dart';
import 'package:academia/features/chirp/domain/entities/conversations/message.dart';
import 'chat_message_widget.dart';

class ChatMessageListWidget extends StatelessWidget {
  final List<Message> messages;
  final ScrollController? scrollController;
  final String currentUserId;

  const ChatMessageListWidget({
    super.key,
    required this.messages,
    this.scrollController,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start the conversation!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message.sender.id == currentUserId;

        final showAvatar = _shouldShowAvatar(index, messages, currentUserId);
        final isFirstInGroup = _isFirstInGroup(index, messages, currentUserId);
        final isLastInGroup = _isLastInGroup(index, messages, currentUserId);

        return ChatMessageWidget(
          message: message,
          isOwnMessage: isMe,
          showAvatar: showAvatar,
          isFirstInGroup: isFirstInGroup,
          isLastInGroup: isLastInGroup,
          onTap: () {
            // Handle message tap if needed
          },
        );
      },
    );
  }

  bool _shouldShowAvatar(
    int index,
    List<Message> messages,
    String currentUserId,
  ) {
    final currentMessage = messages[index];
    final isCurrentMessageFromMe = currentMessage.sender.id == currentUserId;

    if (index == 0) return true;

    final previousMessage = messages[index - 1];
    final isPreviousMessageFromMe = previousMessage.sender.id == currentUserId;

    if (isCurrentMessageFromMe != isPreviousMessageFromMe) return true;

    final timeDifference = currentMessage.sentAt.difference(
      previousMessage.sentAt,
    );
    if (timeDifference.inMinutes > 5) return true;

    return false;
  }

  bool _isFirstInGroup(
    int index,
    List<Message> messages,
    String currentUserId,
  ) {
    if (index == 0) return true;

    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];

    final isCurrentMessageFromMe = currentMessage.sender.id == currentUserId;
    final isPreviousMessageFromMe = previousMessage.sender.id == currentUserId;

    // First in group if sender changed
    if (isCurrentMessageFromMe != isPreviousMessageFromMe) return true;

    // First in group if there's a time gap of more than 5 minutes
    final timeDifference = currentMessage.sentAt.difference(
      previousMessage.sentAt,
    );
    if (timeDifference.inMinutes > 5) return true;

    return false;
  }

  bool _isLastInGroup(int index, List<Message> messages, String currentUserId) {
    if (index == messages.length - 1) return true;

    final currentMessage = messages[index];
    final nextMessage = messages[index + 1];

    final isCurrentMessageFromMe = currentMessage.sender.id == currentUserId;
    final isNextMessageFromMe = nextMessage.sender.id == currentUserId;

    // Last in group if sender changed
    if (isCurrentMessageFromMe != isNextMessageFromMe) return true;

    // Last in group if there's a time gap of more than 5 minutes
    final timeDifference = nextMessage.sentAt.difference(currentMessage.sentAt);
    if (timeDifference.inMinutes > 5) return true;

    return false;
  }
}
