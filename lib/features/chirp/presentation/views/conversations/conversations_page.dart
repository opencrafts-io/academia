import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/config/router/routes.dart';
import '../../bloc/conversations/messaging_bloc.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../bloc/conversations/messaging_event.dart';
import '../../widgets/conversations/user_search_widget.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  bool _showSearch = false;
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessagingBloc>().add(LoadConversationsEvent());
    });
  }

  void _closeSearch() {
    setState(() {
      _showSearch = false;
    });
    context.read<MessagingBloc>().add(LoadConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - keyboardHeight;

    if (_keyboardHeight != keyboardHeight) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _keyboardHeight = keyboardHeight;
        });
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<MessagingBloc>().add(RefreshConversationsEvent());
      },
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: availableHeight),
          child: BlocListener<MessagingBloc, MessagingState>(
            listener: (context, state) {
              if (state is ConversationsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).colorScheme.error,
                    action: SnackBarAction(
                      label: 'Retry',
                      textColor: Theme.of(context).colorScheme.onError,
                      onPressed: () {
                        context.read<MessagingBloc>().add(
                          LoadConversationsEvent(),
                        );
                      },
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Column(
              children: [
                if (!_showSearch)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showSearch = true;
                          });
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Search for friends'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                if (_showSearch)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: _closeSearch,
                              icon: const Icon(Icons.close),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Find Friends',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: isKeyboardVisible
                              ? 120.0
                              : availableHeight * 0.50,
                          child: const UserSearchWidget(),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: BlocBuilder<MessagingBloc, MessagingState>(
                    builder: (context, state) {
                      // Note: Search states are handled in UserSearchWidget
                      // No need to check for search states here

                      if (state is ConversationsLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ConversationsLoaded ||
                          state is MessagesLoaded) {
                        final conversations = state is ConversationsLoaded
                            ? (state).conversations
                            : (state as MessagesLoaded).conversations;

                        if (conversations.isEmpty) {
                          return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    size: 80,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'No messages yet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Search for a friend and unleash your vibes into their existence',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _showSearch = true;
                                      });
                                    },
                                    icon: const Icon(Icons.search),
                                    label: const Text('Find Friends'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: conversations.length,
                          itemBuilder: (context, index) {
                            final conversation = conversations[index];
                            final otherParticipant = conversation.getOtherParticipant(null);
                            final displayName = otherParticipant?.name ?? 'Unknown User';
                            final avatarUrl = otherParticipant?.avatar;
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    avatarUrl != null
                                    ? NetworkImage(avatarUrl)
                                    : null,
                                child: avatarUrl == null
                                    ? Text(
                                        displayName.isNotEmpty
                                            ? displayName
                                                  .split(' ')
                                                  .where((n) => n.isNotEmpty)
                                                  .map((n) => n[0])
                                                  .join('')
                                            : 'U',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                      )
                                    : null,
                              ),
                              title: Text(
                                displayName,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (conversation.lastMessage != null)
                                    Text(
                                      conversation.lastMessage!.content,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        '${otherParticipant?.name ?? 'Unknown'} • Online',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                      if (conversation.lastMessageAt !=
                                          null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          '• ${_formatTime(conversation.lastMessageAt!)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              trailing: conversation.unreadCount > 0
                                  ? Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        conversation.unreadCount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                debugPrint('🎯 ConversationsPage: Navigating to chat ${conversation.id} with conversation object');
                                debugPrint('🎯 ConversationsPage: Conversation participants: ${conversation.participants.map((p) => '${p.name} (${p.userId})').join(', ')}');
                                
                                // Navigate with conversation object as extra parameter
                                context.push(
                                  '/chat/${conversation.id}',
                                  extra: conversation,
                                );
                              },
                            );
                          },
                        );
                      }

                      return const Center(child: Text('Something went wrong'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
