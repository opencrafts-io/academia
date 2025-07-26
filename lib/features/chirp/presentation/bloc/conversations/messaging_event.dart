import 'package:equatable/equatable.dart';

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

  const SendMessageEvent(this.receiverId, this.content);

  @override
  List<Object?> get props => [receiverId, content];
}

class MarkConversationAsReadEvent extends MessagingEvent {
  final String conversationId;

  const MarkConversationAsReadEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}
