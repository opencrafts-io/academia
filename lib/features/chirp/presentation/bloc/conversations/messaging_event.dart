import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../../domain/entities/chirp_user.dart';

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
  final File? file;

  const SendMessageEvent(this.receiverId, this.content, {this.file});

  @override
  List<Object?> get props => [receiverId, content, file];
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
  final ChirpUser user;

  const StartNewConversationEvent(this.user);

  @override
  List<Object?> get props => [user];
}
