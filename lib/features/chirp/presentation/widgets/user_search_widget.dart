import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/conversations/messaging_bloc.dart';
import '../bloc/conversations/messaging_event.dart';
import '../bloc/conversations/messaging_state.dart';
import '../../domain/entities/chirp_user.dart';

class UserSearchWidget extends StatefulWidget {
  const UserSearchWidget({super.key});

  @override
  State<UserSearchWidget> createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isNotEmpty) {
      context.read<MessagingBloc>().add(SearchUsersEvent(query));
    } else {
      context.read<MessagingBloc>().add(const SearchUsersEvent(''));
    }
  }

  void _startConversation(ChirpUser user) {
    context.read<MessagingBloc>().add(StartNewConversationEvent(user));
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Search for friends...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: _onSearchChanged,
        ),
        const SizedBox(height: 16),
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
                        'Error searching users',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
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
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: user.avatarUrl != null
                            ? NetworkImage(user.avatarUrl!)
                            : null,
                        child: user.avatarUrl == null
                            ? Text(
                                user.name.isNotEmpty
                                    ? user.name[0].toUpperCase()
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
                        user.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${user.vibepoints} vibepoints',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () => _startConversation(user),
                        child: const Text('Message'),
                      ),
                    );
                  },
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 48,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Search for friends',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Type a name to find your friends',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
