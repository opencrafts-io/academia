part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ChatInitial extends ChatState {
  const ChatInitial();
}

/// Loading state
class ChatLoading extends ChatState {
  const ChatLoading();
}

/// Loaded state with messages
class ChatLoaded extends ChatState {
  final List<Message> messages;
  final String conversationId;
  final WebSocketConnectionState connectionState;
  final bool hasMoreMessages;
  final bool isRefreshing;
  final bool isLoadingMore;
  final List<String> typingUsers;
  final String draftText;
  final String? error;

  const ChatLoaded({
    required this.messages,
    required this.conversationId,
    required this.connectionState,
    this.hasMoreMessages = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.typingUsers = const [],
    this.draftText = '',
    this.error,
  });

  ChatLoaded copyWith({
    List<Message>? messages,
    String? conversationId,
    WebSocketConnectionState? connectionState,
    bool? hasMoreMessages,
    bool? isRefreshing,
    bool? isLoadingMore,
    List<String>? typingUsers,
    String? draftText,
    String? error,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      connectionState: connectionState ?? this.connectionState,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      typingUsers: typingUsers ?? this.typingUsers,
      draftText: draftText ?? this.draftText,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        messages,
        conversationId,
        connectionState,
        hasMoreMessages,
        isRefreshing,
        isLoadingMore,
        typingUsers,
        draftText,
        error,
      ];
}

/// Error state
class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}