import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chirp_user.dart';
import 'package:academia/config/router/routes.dart';
import '../bloc/conversations/messaging_bloc.dart';
import '../bloc/conversations/messaging_event.dart';
import '../bloc/conversations/messaging_state.dart';

class UserSearchWidget extends StatefulWidget {
  const UserSearchWidget({super.key});

  @override
  State<UserSearchWidget> createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<MessagingBloc>().add(SearchUsersEvent(query));
    } else {
      // reload
      context.read<MessagingBloc>().add(LoadConversationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              hintText: 'Search for friends...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _searchFocusNode.unfocus();
                        context.read<MessagingBloc>().add(
                          LoadConversationsEvent(),
                        );
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onTap: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ),

        // Search Results
        if (_isSearching && _searchController.text.isNotEmpty)
          Expanded(
            child: BlocBuilder<MessagingBloc, MessagingState>(
              builder: (context, state) {
                if (state is UsersSearchLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UsersSearchErrorState) {
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
                          'Search failed',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                if (state is UsersSearchLoadedState) {
                  if (state.users.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No users found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try searching with a different name',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return _buildUserTile(user);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildUserTile(ChirpUser user) {
    final currentState = context.read<MessagingBloc>().state;
    bool hasExistingConversation = false;

    if (currentState is ConversationsLoaded) {
      try {
        currentState.conversations.firstWhere(
          (conv) => conv.user.id == user.id,
        );
        hasExistingConversation = true;
      } catch (e) {
        hasExistingConversation = false;
      }
    } else if (currentState is MessagesLoaded) {
      try {
        currentState.conversations.firstWhere(
          (conv) => conv.user.id == user.id,
        );
        hasExistingConversation = true;
      } catch (e) {
        hasExistingConversation = false;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.avatarUrl != null
              ? NetworkImage(user.avatarUrl!)
              : null,
          child: user.avatarUrl == null
              ? Text(
                  user.name.split(' ').map((n) => n[0]).join(''),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            if (hasExistingConversation)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Existing',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              '${user.vibepoints} vibepoints',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            hasExistingConversation ? Icons.chat : Icons.chat_bubble_outline,
            color: hasExistingConversation
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          onPressed: () => _handleUserTap(user),
        ),
        onTap: () => _handleUserTap(user),
      ),
    );
  }

  void _handleUserTap(ChirpUser user) {
    // Check if conversation already exists
    final currentState = context.read<MessagingBloc>().state;
    String? existingConversationId;

    if (currentState is ConversationsLoaded) {
      try {
        final existingConversation = currentState.conversations.firstWhere(
          (conv) => conv.user.id == user.id,
        );
        existingConversationId = existingConversation.id;
      } catch (e) {
        existingConversationId = null;
      }
    } else if (currentState is MessagesLoaded) {
      try {
        final existingConversation = currentState.conversations.firstWhere(
          (conv) => conv.user.id == user.id,
        );
        existingConversationId = existingConversation.id;
      } catch (e) {
        existingConversationId = null;
      }
    }

    if (existingConversationId != null) {
      // Navigate to existing conversation
      ChatRoute(conversationId: existingConversationId).push(context);
    } else {
      // Create new conversation
      context.read<MessagingBloc>().add(StartNewConversationEvent(user));
      ChatRoute(conversationId: 'conv_${user.id}').push(context);
    }

    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
    _searchFocusNode.unfocus();
  }
}
