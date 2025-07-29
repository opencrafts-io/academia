import 'package:equatable/equatable.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();
  @override
  List<Object?> get props => [];
}

class LoadConversationsEvent extends MessagingEvent {}

class LoadMessagesEvent extends MessagingEvent {
  final String conversationId;

  const LoadMessagesEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class SendMessageEvent extends MessagingEvent {
  final String receiverId;
  final String content;
  final String? imagePath;

  const SendMessageEvent(this.receiverId, this.content, {this.imagePath});

  @override
  List<Object?> get props => [receiverId, content, imagePath];
}

class MarkConversationAsReadEvent extends MessagingEvent {
  final String conversationId;

  const MarkConversationAsReadEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class SearchUsersEvent extends MessagingEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class StartNewConversationEvent extends MessagingEvent {
  final UserProfile user;

  const StartNewConversationEvent(this.user);

  @override
  List<Object?> get props => [user];
}
