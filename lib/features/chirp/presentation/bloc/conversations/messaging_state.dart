import 'package:equatable/equatable.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/entities/chirp_user.dart';

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
  final Conversation conversation;
  final List<Conversation> conversations;
  const MessagesLoaded(this.messages, this.conversation, this.conversations);
  @override
  List<Object?> get props => [messages, conversation, conversations];
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

// User Search States
class UsersSearchLoadingState extends MessagingState {}

class UsersSearchLoadedState extends MessagingState {
  final List<ChirpUser> users;
  const UsersSearchLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UsersSearchErrorState extends MessagingState {
  final String message;
  const UsersSearchErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
