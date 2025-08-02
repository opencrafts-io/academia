import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/config/router/routes.dart';
import '../../bloc/conversations/messaging_bloc.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../bloc/conversations/messaging_event.dart';
import '../../widgets/user_search_widget.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    // Load conversations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessagingBloc>().add(LoadConversationsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Toggle Button
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

        // Search Widget
        if (_showSearch)
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showSearch = false;
                        });
                      },
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const UserSearchWidget(),
              ],
            ),
          ),

        // Conversations List
        Expanded(
          child: BlocBuilder<MessagingBloc, MessagingState>(
            builder: (context, state) {
              if (state is MessagingLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is MessagingErrorState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.connect_without_contact,
                          size: 80,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        Text(
                          "Don't hold back unleash your vibes",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is ConversationsLoaded || state is MessagesLoaded) {
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
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'No messages yet',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Search for a friend and unleash your vibes into their existence'",
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
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: conversation.user.avatarUrl != null
                            ? NetworkImage(conversation.user.avatarUrl!)
                            : null,
                        child: conversation.user.avatarUrl == null
                            ? Text(
                                conversation.user.name.isNotEmpty
                                    ? conversation.user.name
                                          .split(' ')
                                          .map((n) => n[0])
                                          .join('')
                                    : 'U',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              )
                            : null,
                      ),
                      title: Text(
                        conversation.user.name,
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
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          Row(
                            children: [
                              Text(
                                '${conversation.user.vibepoints} vibepoints',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                              if (conversation.lastMessageAt != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '• ${_formatTime(conversation.lastMessageAt!)}',
                                  style: Theme.of(context).textTheme.bodySmall
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
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                conversation.unreadCount.toString(),
                                style: Theme.of(context).textTheme.bodySmall
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
                        context.push(
                          ChatRoute(conversationId: conversation.id).location,
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
