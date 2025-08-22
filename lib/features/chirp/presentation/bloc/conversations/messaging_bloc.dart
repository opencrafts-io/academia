import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/conversations/get_conversations.dart';
import '../../../domain/usecases/conversations/get_messages.dart';
import '../../../domain/usecases/conversations/send_message.dart';
import '../../../domain/usecases/conversations/get_cached_conversations.dart';
import '../../../domain/usecases/conversations/get_cached_messages.dart';
import '../../../domain/usecases/conversations/refresh_conversations.dart';
import '../../../domain/usecases/conversations/refresh_messages.dart';
import '../../../domain/usecases/conversations/create_conversation.dart';
import '../../../domain/usecases/search_users_usecase.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../../../core/usecase/usecase.dart';
import 'messaging_state.dart';
import 'messaging_event.dart';
import 'dart:async';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final GetConversations getConversations;
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final SearchUsersUseCase searchUsers;
  final GetCachedConversations getCachedConversations;
  final GetCachedMessages getCachedMessages;
  final RefreshConversations refreshConversations;
  final RefreshMessages refreshMessages;
  final CreateConversation createConversation;

  StreamSubscription<List<Conversation>>? _conversationsSubscription;
  StreamSubscription<List<Message>>? _messagesSubscription;

  // Map to store conversation IDs by user ID
  final Map<String, String> _conversationIdMap = {};
  // Map to store user data by conversation ID
  final Map<String, ChirpUser> _conversationUserMap = {};

  MessagingBloc({
    required this.getConversations,
    required this.getMessages,
    required this.sendMessage,
    required this.searchUsers,
    required this.getCachedConversations,
    required this.getCachedMessages,
    required this.refreshConversations,
    required this.refreshMessages,
    required this.createConversation,
  }) : super(MessagingInitialState()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkConversationAsReadEvent>(_onMarkConversationAsRead);
    on<SearchUsersEvent>(_onSearchUsers);
    on<StartNewConversationEvent>(_onStartNewConversation);
    on<RefreshConversationsEvent>(_onRefreshConversations);
    on<RefreshMessagesEvent>(_onRefreshMessages);
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    _messagesSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadConversations(
    LoadConversationsEvent event,
    Emitter<MessagingState> emit,
  ) async {
    emit(ConversationsLoadingState());

    // First, listen to cached conversations
    _conversationsSubscription?.cancel();
    _conversationsSubscription = getCachedConversations(NoParams()).listen((
      conversations,
    ) {
      if (conversations.isNotEmpty && !emit.isDone) {
        // Preserve any user data we have stored locally
        final conversationsWithCorrectUsers = conversations.map((conversation) {
          final storedUser = _conversationUserMap[conversation.id];
          if (storedUser != null) {
            return conversation.copyWith(user: storedUser);
          }
          return conversation;
        }).toList();

        emit(ConversationsLoaded(conversationsWithCorrectUsers));
      }
    });

    // Then try to get fresh data in background
    final result = await getConversations(NoParams());
    result.fold(
      (failure) {
        // If we have cached data, don't show error
        if (state is ConversationsLoaded) {
          // Background refresh failed, but we have cached data
          return;
        }
        emit(
          ConversationsErrorState(
            failure.message,
            retryAction: "Tap to retry loading conversations",
          ),
        );
      },
      (conversations) {
        // Fresh data loaded, cache will be updated automatically
        // But we need to preserve any user data we have stored locally
        final conversationsWithCorrectUsers = conversations.map((conversation) {
          final storedUser = _conversationUserMap[conversation.id];
          if (storedUser != null) {
            return conversation.copyWith(user: storedUser);
          }
          return conversation;
        }).toList();

        if (state is! ConversationsLoaded) {
          emit(ConversationsLoaded(conversationsWithCorrectUsers));
        } else {
          // Update the existing state with preserved user data
          emit(ConversationsLoaded(conversationsWithCorrectUsers));
        }
      },
    );
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<MessagingState> emit,
  ) async {
    List<Conversation> currentConversations = [];
    if (state is ConversationsLoaded) {
      currentConversations = (state as ConversationsLoaded).conversations;
    } else if (state is MessagesLoaded) {
      currentConversations = (state as MessagesLoaded).conversations;
    }

    emit(MessagesLoadingState());

    // Find the existing conversation with correct user data
    final existingConversation = currentConversations
        .where((conv) => conv.id == event.conversationId)
        .firstOrNull;

    // Store the user data for future use
    if (existingConversation != null) {
      _conversationUserMap[event.conversationId] = existingConversation.user;
    }

    // First, listen to cached messages
    _messagesSubscription?.cancel();
    _messagesSubscription = getCachedMessages(event.conversationId).listen((
      messages,
    ) {
      if (messages.isNotEmpty && !emit.isDone) {
        final sortedMessages = List<Message>.from(messages)
          ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

        // Always try to get the correct user data, even if we have an existing conversation
        ChirpUser userForConversation;

        // First, try to get user from stored map
        final storedUser = _conversationUserMap[event.conversationId];
        if (storedUser != null) {
          userForConversation = storedUser;
        } else if (existingConversation != null &&
            existingConversation.user.name != 'Unknown User') {
          // Use existing conversation user if it's not "Unknown User"
          userForConversation = existingConversation.user;
        } else {
          // Fallback to getting user from conversation ID
          userForConversation = _getUserForConversation(event.conversationId);
        }

        final conversation =
            existingConversation?.copyWith(
              lastMessage: sortedMessages.isNotEmpty
                  ? sortedMessages.last
                  : null,
              lastMessageAt: sortedMessages.isNotEmpty
                  ? sortedMessages.last.sentAt
                  : null,
              unreadCount: 0,
            ) ??
            Conversation(
              id: event.conversationId,
              user: userForConversation,
              lastMessage: sortedMessages.isNotEmpty
                  ? sortedMessages.last
                  : null,
              lastMessageAt: sortedMessages.isNotEmpty
                  ? sortedMessages.last.sentAt
                  : null,
              unreadCount: 0,
            );
        emit(
          MessagesLoaded(sortedMessages, conversation, currentConversations),
        );
      }
    });

    // Then try to get fresh data in background
    final result = await getMessages(event.conversationId);
    result.fold(
      (failure) {
        // If we have cached data, don't show error
        if (state is MessagesLoaded) {
          // Background refresh failed, but we have cached data
          return;
        }
        emit(
          MessagesErrorState(
            failure.message,
            retryAction: "Tap to retry loading messages",
          ),
        );
      },
      (messages) {
        // Fresh data loaded, cache will be updated automatically
        if (state is! MessagesLoaded) {
          final sortedMessages = List<Message>.from(messages)
            ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

          // Always try to get the correct user data, even if we have an existing conversation
          ChirpUser userForConversation;

          // First, try to get user from stored map
          final storedUser = _conversationUserMap[event.conversationId];
          if (storedUser != null) {
            userForConversation = storedUser;
          } else if (existingConversation != null &&
              existingConversation.user.name != 'Unknown User') {
            // Use existing conversation user if it's not "Unknown User"
            userForConversation = existingConversation.user;
          } else {
            // Fallback to getting user from conversation ID
            userForConversation = _getUserForConversation(event.conversationId);
          }

          final conversation =
              existingConversation?.copyWith(
                lastMessage: sortedMessages.isNotEmpty
                    ? sortedMessages.last
                    : null,
                lastMessageAt: sortedMessages.isNotEmpty
                    ? sortedMessages.last.sentAt
                    : null,
                unreadCount: 0,
              ) ??
              Conversation(
                id: event.conversationId,
                user: userForConversation,
                lastMessage: sortedMessages.isNotEmpty
                    ? sortedMessages.last
                    : null,
                lastMessageAt: sortedMessages.isNotEmpty
                    ? sortedMessages.last.sentAt
                    : null,
                unreadCount: 0,
              );
          emit(
            MessagesLoaded(sortedMessages, conversation, currentConversations),
          );
        }
      },
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<MessagingState> emit,
  ) async {
    final currentState = state;
    List<Message> currentMessages = [];
    Conversation? currentConversation;
    List<Conversation> currentConversations = [];

    if (currentState is MessagesLoaded) {
      currentMessages = currentState.messages;
      currentConversation = currentState.conversation;
      currentConversations = currentState.conversations;
    }

    emit(MessageSendingState());

    // Create message parameters
    final messageParams = <String, dynamic>{
      'receiverId': event.receiverId,
      'content': event.content,
    };

    if (event.file != null) {
      messageParams['file'] = event.file!;
    }

    final result = await sendMessage(messageParams);
    result.fold(
      (failure) {
        if (currentState is MessagesLoaded) {
          emit(
            MessageSendErrorState(
              failure.message,
              retryAction: "Tap to retry sending message",
            ),
          );
        } else {
          emit(
            MessageSendErrorState(
              failure.message,
              retryAction: "Tap to retry sending message",
            ),
          );
        }
      },
      (message) {
        final updatedMessages = [...currentMessages, message];

        final updatedConversation =
            currentConversation?.copyWith(
              lastMessage: message,
              lastMessageAt: message.sentAt,
            ) ??
            Conversation(
              id: event.receiverId,
              user: _getUserForConversation(event.receiverId),
              lastMessage: message,
              lastMessageAt: message.sentAt,
              unreadCount: 0,
            );
        emit(
          MessagesLoaded(
            updatedMessages,
            updatedConversation,
            currentConversations,
          ),
        );
      },
    );
  }

  Future<void> _onMarkConversationAsRead(
    MarkConversationAsReadEvent event,
    Emitter<MessagingState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationsLoaded) {
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(unreadCount: 0);
        }
        return conv;
      }).toList();
      emit(ConversationsLoaded(updatedConversations));
    } else if (currentState is MessagesLoaded) {
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(unreadCount: 0);
        }
        return conv;
      }).toList();
      emit(ConversationsLoaded(updatedConversations));
    }
  }

  Future<void> _onSearchUsers(
    SearchUsersEvent event,
    Emitter<MessagingState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const UsersSearchLoadedState([]));
      return;
    }

    emit(UsersSearchLoadingState());
    final params = SearchUsersParams(query: event.query);
    final result = await searchUsers(params);
    result.fold(
      (failure) {
        emit(
          UsersSearchErrorState(
            failure.message,
            retryAction: "Tap to retry search",
          ),
        );
      },
      (users) {
        emit(UsersSearchLoadedState(users));
      },
    );
  }

  Future<void> _onStartNewConversation(
    StartNewConversationEvent event,
    Emitter<MessagingState> emit,
  ) async {
    List<Conversation> currentConversations = [];
    if (state is ConversationsLoaded) {
      currentConversations = (state as ConversationsLoaded).conversations;
    } else if (state is MessagesLoaded) {
      currentConversations = (state as MessagesLoaded).conversations;
    }

    // Check if conversation already exists
    if (currentConversations.any((conv) => conv.user.id == event.user.id)) {
      // Conversation already exists, just emit the current state
      return;
    }

    // Create conversation on the backend
    final currentUserId = 'default_user_123'; // This should come from auth
    final participants = [currentUserId, event.user.id];

    final params = CreateConversationParams(participants: participants);
    final result = await createConversation(params);

    result.fold(
      (failure) {
        // Even if creation fails, we can still show a local conversation
        final conversation = Conversation(
          id: 'conv_${event.user.id}',
          user: event.user,
          lastMessage: null,
          lastMessageAt: null,
          unreadCount: 0,
        );

        if (!currentConversations.any(
          (conv) => conv.user.id == event.user.id,
        )) {
          currentConversations = [...currentConversations, conversation];
        }

        emit(ConversationsLoaded(currentConversations));
      },
      (conversation) {
        // Store the real conversation ID for this user
        _conversationIdMap[event.user.id] = conversation.id;
        _conversationUserMap[conversation.id] = event.user;
        _conversationUserMap[event.user.id] =
            event.user; // Also store with user ID for lookup

        // Add the new conversation to the list
        if (!currentConversations.any(
          (conv) => conv.user.id == event.user.id,
        )) {
          currentConversations = [...currentConversations, conversation];
        }

        // Emit a special state to indicate conversation was created
        emit(ConversationCreatedState(conversation, currentConversations));
      },
    );
  }

  Future<void> _onRefreshConversations(
    RefreshConversationsEvent event,
    Emitter<MessagingState> emit,
  ) async {
    final result = await refreshConversations(NoParams());
    result.fold(
      (failure) => emit(
        ConversationsErrorState(
          failure.message,
          retryAction: "Tap to retry refreshing conversations",
        ),
      ),
      (conversationsStream) {
        // The stream will automatically update the UI through the existing subscription
      },
    );
  }

  Future<void> _onRefreshMessages(
    RefreshMessagesEvent event,
    Emitter<MessagingState> emit,
  ) async {
    final result = await refreshMessages(event.conversationId);
    result.fold(
      (failure) => emit(
        MessagesErrorState(
          failure.message,
          retryAction: "Tap to retry refreshing messages",
        ),
      ),
      (messagesStream) {
        // The stream will automatically update the UI through the existing subscription
      },
    );
  }

  ChirpUser _getUserForConversation(String conversationId) {
    // First, check if we have stored user data for this conversation
    final storedUser = _conversationUserMap[conversationId];
    if (storedUser != null) {
      return storedUser;
    }

    // Try to get the user from the conversation ID map first
    final mappedUserId = _conversationIdMap.entries
        .where((entry) => entry.value == conversationId)
        .map((entry) => entry.key)
        .firstOrNull;

    if (mappedUserId != null) {
      // We have a mapping, try to get the user from the stored map
      final userForMappedId = _conversationUserMap.entries
          .where((entry) => entry.key == mappedUserId)
          .map((entry) => entry.value)
          .firstOrNull;

      if (userForMappedId != null) {
        return userForMappedId;
      }
    }

    // Extract the actual user ID from conversation ID as fallback
    final userId = conversationId.replaceAll('conv_', '');

    final actualUserId = mappedUserId ?? userId;

    // For now, create a minimal user but with better naming
    // TODO: This should be replaced with actual cached user data lookup
    return ChirpUser(
      id: actualUserId,
      name: actualUserId.length > 8
          ? actualUserId.substring(0, 8)
          : actualUserId,
      email: 'user@example.com',
      vibepoints: 0,
      avatarUrl: null,
    );
  }

  // Get the real conversation ID for a user
  String? getConversationIdForUser(String userId) {
    return _conversationIdMap[userId];
  }
}
