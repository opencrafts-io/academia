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
                  return Center(child: Text('Error: ${state.message}'));
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
}
