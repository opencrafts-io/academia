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
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: BlocBuilder<MessagingBloc, MessagingState>(
        builder: (context, state) {
          if (state is MessagingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MessagingErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text(
                    _getErrorMessage(state.message),
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getErrorSubtitle(state.message),
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
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
            return ListView.builder(
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: conversation.user.avatarUrl != null
                        ? NetworkImage(conversation.user.avatarUrl!)
                        : null,
                  ),
                  title: Text(conversation.user.name),
                  subtitle: Text(
                    conversation.lastMessage?.content ?? 'No messages',
                  ),
                  trailing: conversation.unreadCount > 0
                      ? CircleAvatar(
                          radius: 10,
                          child: Text(conversation.unreadCount.toString()),
                        )
                      : null,
                  onTap: () => context.push(
                    '/chat/${conversation.id}',
                    extra: conversation,
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No conversations'));
        },
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
