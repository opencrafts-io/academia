part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize the chat
class ChatInitialized extends ChatEvent {
  final String conversationId;

  const ChatInitialized(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

/// Load messages (refresh)
class ChatMessagesLoaded extends ChatEvent {
  const ChatMessagesLoaded();
}

/// Load more messages (pagination)
class ChatLoadMoreMessages extends ChatEvent {
  const ChatLoadMoreMessages();
}

/// Send a message
class ChatMessageSent extends ChatEvent {
  final String content;
  final File? file;

  const ChatMessageSent({
    required this.content,
    this.file,
  });

  @override
  List<Object?> get props => [content, file];
}

/// Edit a message
class ChatMessageEdited extends ChatEvent {
  final int messageId;
  final String newContent;

  const ChatMessageEdited({
    required this.messageId,
    required this.newContent,
  });

  @override
  List<Object?> get props => [messageId, newContent];
}

/// Delete a message
class ChatMessageDeleted extends ChatEvent {
  final int messageId;

  const ChatMessageDeleted(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

/// Mark messages as read
class ChatMessagesMarkedAsRead extends ChatEvent {
  final List<int> messageIds;

  const ChatMessagesMarkedAsRead(this.messageIds);

  @override
  List<Object?> get props => [messageIds];
}

/// Start typing indicator
class ChatTypingStarted extends ChatEvent {
  const ChatTypingStarted();
}

/// Stop typing indicator
class ChatTypingStopped extends ChatEvent {
  const ChatTypingStopped();
}

/// Draft content changed
class ChatDraftChanged extends ChatEvent {
  final String content;

  const ChatDraftChanged(this.content);

  @override
  List<Object?> get props => [content];
}

/// Load draft for conversation
class ChatDraftLoaded extends ChatEvent {
  final String conversationId;

  const ChatDraftLoaded(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

/// Save draft
class ChatDraftSaved extends ChatEvent {
  final String conversationId;
  final String content;

  const ChatDraftSaved(this.conversationId, this.content);

  @override
  List<Object?> get props => [conversationId, content];
}

/// Delete draft
class ChatDraftDeleted extends ChatEvent {
  final String conversationId;

  const ChatDraftDeleted(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

/// Messages updated from stream
class ChatMessagesUpdated extends ChatEvent {
  final List<Message> messages;

  const ChatMessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

/// Typing indicator received
class ChatTypingIndicatorReceived extends ChatEvent {
  final String userId;

  const ChatTypingIndicatorReceived(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Connection state changed
class ChatConnectionStateChanged extends ChatEvent {
  final WebSocketConnectionState state;

  const ChatConnectionStateChanged(this.state);

  @override
  List<Object?> get props => [state];
}

/// New message received
class ChatNewMessageReceived extends ChatEvent {
  final Message message;

  const ChatNewMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}