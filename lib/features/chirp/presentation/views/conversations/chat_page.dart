import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/conversations/messaging_bloc.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../bloc/conversations/messaging_event.dart';
import '../../../domain/entities/conversations/conversation.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final Conversation? conversation;

  const ChatPage({super.key, required this.conversationId, this.conversation});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MessagingBloc>().add(LoadMessagesEvent(widget.conversationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conversation?.user.name ?? 'Chat')),
      body: Column(
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
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getErrorMessage(state.message),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getErrorSubtitle(state.message),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
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
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          state.messages[state.messages.length - 1 - index];
                      return ListTile(
                        title: Text(message.content),
                        subtitle: Text(message.sender.name),
                      );
                    },
                  );
                }
                if (state is MessageSent) {
                  context.read<MessagingBloc>().add(
                    LoadMessagesEvent(widget.conversationId),
                  );
                }
                return const Center(child: Text('No messages'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<MessagingBloc>().add(
                        SendMessageEvent(
                          widget.conversation?.user.id ?? '',
                          _controller.text,
                        ),
                      );
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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
