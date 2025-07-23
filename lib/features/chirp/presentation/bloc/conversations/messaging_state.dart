import 'package:equatable/equatable.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/message.dart';

abstract class MessagingState extends Equatable {
  const MessagingState();
  @override
  List<Object?> get props => [];
}

class MessagingInitialState extends MessagingState {}

class MessagingLoadingState extends MessagingState {}

class MessagingErrorState extends MessagingState {
  final String message;
  const MessagingErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class MessagesLoaded extends MessagingState {
  final List<Message> messages;
  const MessagesLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

class MessageSent extends MessagingState {
  final Message message;
  const MessageSent(this.message);
  @override
  List<Object?> get props => [message];
}

class ConversationsLoaded extends MessagingState {
  final List<Conversation> conversations;
  const ConversationsLoaded(this.conversations);
  @override
  List<Object?> get props => [conversations];
}
