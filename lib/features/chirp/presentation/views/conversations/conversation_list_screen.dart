import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/clippers/clippers.dart';
import '../../blocs/conversations/conversation_list_bloc.dart';
import '../../entities/conversations/conversation.dart';
import '../../../data/services/websocket_service.dart';
import '../../widgets/conversations/conversation_card_widget.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _initializeConversations();
  }

  void _initializeConversations() {
    // Get current user ID from somewhere (e.g., auth bloc, shared preferences, etc.)
    // For now, we'll use a placeholder - this should be replaced with actual user ID
    _currentUserId = 'current_user_id'; // TODO: Get from auth state
    
    context.read<ConversationListBloc>().add(
      ConversationListInitialized(currentUserId: _currentUserId),
    );
    
    // Connect to real-time messaging
    context.read<ConversationListBloc>().add(
      const ConversationListConnectToRealTime(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          BlocBuilder<ConversationListBloc, ConversationListState>(
            builder: (context, state) {
              if (state is ConversationListLoaded) {
                return _ConnectionStatusIndicator(
                  connectionState: state.connectionState,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocListener<ConversationListBloc, ConversationListState>(
        listener: (context, state) {
          if (state is ConversationListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          
          if (state is ConversationListLoaded) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }

            // Navigate to newly created conversation
            if (state.createdConversation != null) {
              final conversationId = state.createdConversation!.id;
              if (conversationId.isNotEmpty) {
                debugPrint('Navigating to conversation: $conversationId');
                context.push(
                  '/chat/$conversationId',
                  extra: state.createdConversation,
                );
              } else {
                debugPrint('ERROR: Empty conversation ID');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to navigate to conversation'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          }
        },
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<ConversationListBloc>().add(
                    ConversationListSearchChanged(value),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            // Conversations list
            Expanded(
              child: BlocBuilder<ConversationListBloc, ConversationListState>(
                builder: (context, state) {
                  if (state is ConversationListLoading) {
                    return const Center(
                      child: SpinningScallopIndicator(),
                    );
                  }

                  if (state is ConversationListError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Failed to load conversations',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<ConversationListBloc>().add(
                                const ConversationListRefreshed(),
                              );
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ConversationListLoaded) {
                    if (state.conversations.isEmpty) {
                      return _EmptyConversationsWidget(
                        searchQuery: state.searchQuery,
                        onStartConversation: _showUserSelectionDialog,
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ConversationListBloc>().add(
                          const ConversationListRefreshed(),
                        );
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.conversations.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          indent: 72,
                          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                        ),
                        itemBuilder: (context, index) {
                          final conversation = state.conversations[index];
                          return ConversationCardWidget(
                            conversation: conversation,
                            currentUserId: _currentUserId,
                            onTap: () {
                              context.push(
                                '/chat/${conversation.id}',
                                extra: conversation,
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const Center(
                    child: Text('Pull to refresh conversations'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showUserSelectionDialog,
        child: const Icon(Icons.message),
      ),
    );
  }

  void _showUserSelectionDialog() {
    context.push('/users/select').then((result) {
      if (result != null && result is Map<String, String>) {
        context.read<ConversationListBloc>().add(
          ConversationListCreateConversation(
            otherUserId: result['userId']!,
            otherUserName: result['userName']!,
          ),
        );
      }
    });
  }
}

class _ConnectionStatusIndicator extends StatelessWidget {
  final WebSocketConnectionState connectionState;

  const _ConnectionStatusIndicator({required this.connectionState});

  @override
  Widget build(BuildContext context) {
    late Color color;
    late IconData icon;
    late String tooltip;

    switch (connectionState) {
      case WebSocketConnectionState.connected:
        color = Colors.green;
        icon = Icons.circle;
        tooltip = 'Connected';
        break;
      case WebSocketConnectionState.connecting:
        color = Colors.orange;
        icon = Icons.circle;
        tooltip = 'Connecting...';
        break;
      case WebSocketConnectionState.reconnecting:
        color = Colors.orange;
        icon = Icons.refresh;
        tooltip = 'Reconnecting...';
        break;
      case WebSocketConnectionState.disconnected:
        color = Colors.red;
        icon = Icons.circle;
        tooltip = 'Disconnected';
        break;
      case WebSocketConnectionState.error:
        color = Colors.red;
        icon = Icons.error;
        tooltip = 'Connection Error';
        break;
    }

    return Tooltip(
      message: tooltip,
      child: Icon(
        icon,
        size: 12,
        color: color,
      ),
    );
  }
}

class _EmptyConversationsWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onStartConversation;

  const _EmptyConversationsWidget({
    required this.searchQuery,
    required this.onStartConversation,
  });

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery.isNotEmpty;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.message_outlined,
              size: 96,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              isSearching ? 'No conversations found' : 'No conversations yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isSearching
                  ? 'Try searching with different keywords'
                  : 'Start a conversation with someone to get started',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (!isSearching) ...[ 
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onStartConversation,
                icon: const Icon(Icons.add),
                label: const Text('Start Conversation'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}