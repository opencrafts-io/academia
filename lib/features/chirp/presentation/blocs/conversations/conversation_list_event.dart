part of 'conversation_list_bloc.dart';

abstract class ConversationListEvent extends Equatable {
  const ConversationListEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize the conversation list
class ConversationListInitialized extends ConversationListEvent {
  final String? currentUserId;

  const ConversationListInitialized({this.currentUserId});

  @override
  List<Object?> get props => [currentUserId];
}

/// Refresh conversations
class ConversationListRefreshed extends ConversationListEvent {
  const ConversationListRefreshed();
}

/// Search query changed
class ConversationListSearchChanged extends ConversationListEvent {
  final String query;

  const ConversationListSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Create a new conversation
class ConversationListCreateConversation extends ConversationListEvent {
  final String otherUserId;
  final String otherUserName;

  const ConversationListCreateConversation({
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  List<Object?> get props => [otherUserId, otherUserName];
}

/// Connect to real-time messaging
class ConversationListConnectToRealTime extends ConversationListEvent {
  const ConversationListConnectToRealTime();
}

/// Disconnect from real-time messaging
class ConversationListDisconnectFromRealTime extends ConversationListEvent {
  const ConversationListDisconnectFromRealTime();
}

/// Conversations updated from stream
class ConversationListConversationsUpdated extends ConversationListEvent {
  final List<Conversation> conversations;

  const ConversationListConversationsUpdated(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

/// Connection state changed
class ConversationListConnectionStateChanged extends ConversationListEvent {
  final WebSocketConnectionState state;

  const ConversationListConnectionStateChanged(this.state);

  @override
  List<Object?> get props => [state];
}

/// New message received
class ConversationListNewMessageReceived extends ConversationListEvent {
  final Message message;

  const ConversationListNewMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

/// Sync offline messages
class ConversationListSyncOffline extends ConversationListEvent {
  const ConversationListSyncOffline();
}

/// Error occurred
class ConversationListErrorEvent extends ConversationListEvent {
  final String message;

  const ConversationListErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
