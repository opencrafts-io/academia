part of 'conversation_list_bloc.dart';

abstract class ConversationListState extends Equatable {
  const ConversationListState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ConversationListInitial extends ConversationListState {
  const ConversationListInitial();
}

/// Loading state
class ConversationListLoading extends ConversationListState {
  const ConversationListLoading();
}

/// Loaded state with conversations
class ConversationListLoaded extends ConversationListState {
  final List<Conversation> conversations;
  final WebSocketConnectionState connectionState;
  final String searchQuery;
  final bool isRefreshing;
  final bool isCreatingConversation;
  final String? error;
  final Conversation? createdConversation;

  const ConversationListLoaded({
    required this.conversations,
    required this.connectionState,
    this.searchQuery = '',
    this.isRefreshing = false,
    this.isCreatingConversation = false,
    this.error,
    this.createdConversation,
  });

  ConversationListLoaded copyWith({
    List<Conversation>? conversations,
    WebSocketConnectionState? connectionState,
    String? searchQuery,
    bool? isRefreshing,
    bool? isCreatingConversation,
    String? error,
    Conversation? createdConversation,
  }) {
    return ConversationListLoaded(
      conversations: conversations ?? this.conversations,
      connectionState: connectionState ?? this.connectionState,
      searchQuery: searchQuery ?? this.searchQuery,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isCreatingConversation: isCreatingConversation ?? this.isCreatingConversation,
      error: error,
      createdConversation: createdConversation,
    );
  }

  @override
  List<Object?> get props => [
        conversations,
        connectionState,
        searchQuery,
        isRefreshing,
        isCreatingConversation,
        error,
        createdConversation,
      ];
}

/// Error state
class ConversationListError extends ConversationListState {
  final String message;

  const ConversationListError(this.message);

  @override
  List<Object?> get props => [message];
}