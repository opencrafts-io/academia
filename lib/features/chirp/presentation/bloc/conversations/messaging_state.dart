import 'package:equatable/equatable.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
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

class ConversationsLoaded extends MessagingState {
  final List<Conversation> conversations;

  const ConversationsLoaded(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class MessagesLoaded extends MessagingState {
  final List<Message> messages;
  final Conversation conversation;
  final List<Conversation> conversations;

  const MessagesLoaded(this.messages, this.conversation, this.conversations);

  @override
  List<Object?> get props => [messages, conversation, conversations];
}

class MessageSentState extends MessagingState {
  final Message message;

  const MessageSentState(this.message);

  @override
  List<Object?> get props => [message];
}

class UsersSearchLoadingState extends MessagingState {}

class UsersSearchLoadedState extends MessagingState {
  final List<UserProfile> users;

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

class NewConversationStartedState extends MessagingState {
  final Conversation conversation;

  const NewConversationStartedState(this.conversation);

  @override
  List<Object?> get props => [conversation];
}
