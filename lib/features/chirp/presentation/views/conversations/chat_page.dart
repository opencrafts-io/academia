import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../bloc/conversations/messaging_event.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final Conversation? conversation;

  const ChatPage({super.key, required this.conversationId, this.conversation});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MessagingBloc>().add(LoadMessagesEvent(widget.conversationId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessagingBloc, MessagingState>(
      listener: (context, state) {
        if (state is MessagingErrorState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Oops! ${state.message}"),
              behavior: SnackBarBehavior.floating,
              width: MediaQuery.of(context).size.width * 0.75,
              showCloseIcon: true,
            ),
            snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceIn),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.conversation?.user.avatarUrl != null
                    ? NetworkImage(widget.conversation!.user.avatarUrl!)
                    : null,
                child: widget.conversation?.user.avatarUrl == null
                    ? Text(
                        widget.conversation?.user.name
                                .split(' ')
                                .map((n) => n[0])
                                .join('') ??
                            'U',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.conversation?.user.name ?? 'Unknown User',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.conversation?.user.bio != null)
                      Text(
                        widget.conversation!.user.bio!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<MessagingBloc, MessagingState>(
                  builder: (context, state) {
                    if (state is MessagingLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is MessagingErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _getErrorMessage(state.message),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getErrorSubtitle(state.message),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MessagingBloc>().add(
                                  LoadMessagesEvent(widget.conversationId),
                                );
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is MessagesLoaded) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No messages yet',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start a conversation by sending a message',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          final isMe = message.sender.id == 'current-user-id';

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isMe) ...[
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage:
                                        message.sender.avatarUrl != null
                                        ? NetworkImage(
                                            message.sender.avatarUrl!,
                                          )
                                        : null,
                                    child: message.sender.avatarUrl == null
                                        ? Text(
                                            message.sender.name
                                                .split(' ')
                                                .map((n) => n[0])
                                                .join(''),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                                ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(context)
                                                .colorScheme
                                                .surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: isMe
                                                    ? Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary
                                                    : Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatTime(message.sentAt),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: isMe
                                                    ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                          .withValues(
                                                            alpha: 0.7,
                                                          )
                                                    : Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isMe) ...[
                                  const SizedBox(width: 8),
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage:
                                        message.sender.avatarUrl != null
                                        ? NetworkImage(
                                            message.sender.avatarUrl!,
                                          )
                                        : null,
                                    child: message.sender.avatarUrl == null
                                        ? Text(
                                            message.sender.name
                                                .split(' ')
                                                .map((n) => n[0])
                                                .join(''),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                                ),
                                          )
                                        : null,
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return const Center(child: Text('Something went wrong'));
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          context.read<MessagingBloc>().add(
                            SendMessageEvent(
                              widget.conversation?.user.id ?? '',
                              _messageController.text.trim(),
                            ),
                          );
                          _messageController.clear();
                        }
                      },
                      mini: true,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _getErrorMessage(String message) {
    if (message.contains('No internet connection')) {
      return 'No Internet Connection';
    } else if (message.contains('timed out')) {
      return 'Connection Timed Out';
    } else if (message.contains('session has expired')) {
      return 'Session Expired';
    } else if (message.contains('permission')) {
      return 'Access Denied';
    } else if (message.contains('Server error')) {
      return 'Server Error';
    } else if (message.contains('not found')) {
      return 'Conversation Not Found';
    } else if (message.contains('unexpected error')) {
      return 'Something Went Wrong';
    } else if (message.contains('Invalid message content')) {
      return 'Invalid Message';
    } else {
      return 'Error Loading Messages';
    }
  }

  String _getErrorSubtitle(String message) {
    if (message.contains('No internet connection')) {
      return 'Please check your network connection and try again.';
    } else if (message.contains('timed out')) {
      return 'The request took too long. Please check your connection and try again.';
    } else if (message.contains('session has expired')) {
      return 'Please log in again to continue.';
    } else if (message.contains('permission')) {
      return 'You don\'t have permission to access this conversation.';
    } else if (message.contains('Server error')) {
      return 'Our servers are experiencing issues. Please try again later.';
    } else if (message.contains('not found')) {
      return 'The conversation could not be found.';
    } else if (message.contains('unexpected error')) {
      return 'An unexpected error occurred. Please try again.';
    } else if (message.contains('Invalid message content')) {
      return 'Please check your message content and try again.';
    } else {
      return 'Please check your connection and try again.';
    }
  }
}
