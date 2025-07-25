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
            return Center(child: Text('Error: ${state.message}'));
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
}
