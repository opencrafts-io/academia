import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/conversations/messaging_bloc.dart';
import '../../bloc/conversations/messaging_event.dart';
import '../../bloc/conversations/messaging_state.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MessagingBloc>().add(LoadConversationsEvent());
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
      child: SafeArea(
        minimum: const EdgeInsets.all(12),
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
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getErrorMessage(state.message),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getErrorSubtitle(state.message),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MessagingBloc>().add(
                          LoadConversationsEvent(),
                        );
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is ConversationsLoaded) {
              if (state.conversations.isEmpty) {
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
                          'Search for a friend and get the vibes flowin\'',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Search feature coming soon!',
                                ),
                                behavior: SnackBarBehavior.floating,
                                width: MediaQuery.of(context).size.width * 0.75,
                                showCloseIcon: true,
                              ),
                              snackBarAnimationStyle: AnimationStyle(
                                curve: Curves.bounceIn,
                              ),
                            );
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
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: conversation.user.avatarUrl != null
                            ? NetworkImage(conversation.user.avatarUrl!)
                            : null,
                        child: conversation.user.avatarUrl == null
                            ? Text(
                                conversation.user.name
                                    .split(' ')
                                    .map((n) => n[0])
                                    .join(''),
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                              )
                            : null,
                      ),
                      title: Text(
                        conversation.user.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        conversation.lastMessage?.content ?? 'No messages yet',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: conversation.unreadCount > 0
                          ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                conversation.unreadCount.toString(),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          : null,
                      onTap: () {
                        context.push(
                          '/chat/${conversation.id}',
                          extra: conversation,
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
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
      return 'Not Found';
    } else if (message.contains('unexpected error')) {
      return 'Something Went Wrong';
    } else {
      return 'Error Loading Conversations';
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
      return 'You don\'t have permission to access this feature.';
    } else if (message.contains('Server error')) {
      return 'Our servers are experiencing issues. Please try again later.';
    } else if (message.contains('not found')) {
      return 'The requested resource could not be found.';
    } else if (message.contains('unexpected error')) {
      return 'An unexpected error occurred. Please try again.';
    } else {
      return 'Please check your connection and try again.';
    }
  }
}
