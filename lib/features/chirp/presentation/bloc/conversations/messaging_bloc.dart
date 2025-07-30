import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/conversations/get_conversations.dart';
import '../../../domain/usecases/conversations/get_messages.dart';
import '../../../domain/usecases/conversations/send_message.dart';
import '../../../domain/usecases/search_users_usecase.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../../../core/usecase/usecase.dart';
import 'package:academia/features/chirp/data/models/conversations/conversation_model_helper.dart';
import 'messaging_state.dart';
import 'messaging_event.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final GetConversations getConversations;
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final SearchUsersUseCase searchUsers;

  MessagingBloc({
    required this.getConversations,
    required this.getMessages,
    required this.sendMessage,
    required this.searchUsers,
  }) : super(MessagingInitialState()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkConversationAsReadEvent>(_onMarkConversationAsRead);
    on<SearchUsersEvent>(_onSearchUsers);
    on<StartNewConversationEvent>(_onStartNewConversation);
  }

  Future<void> _onLoadConversations(
    LoadConversationsEvent event,
    Emitter<MessagingState> emit,
  ) async {
    emit(MessagingLoadingState());
    final result = await getConversations(NoParams());
    result.fold(
      (failure) => emit(MessagingErrorState(failure.message)),
      (conversations) => emit(ConversationsLoaded(conversations)),
    );
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<MessagingState> emit,
  ) async {
    // Preserve current conversations
    List<Conversation> currentConversations = [];
    if (state is ConversationsLoaded) {
      currentConversations = (state as ConversationsLoaded).conversations;
    } else if (state is MessagesLoaded) {
      currentConversations = (state as MessagesLoaded).conversations;
    }

    emit(MessagingLoadingState());

    final result = await getMessages(event.conversationId);
    result.fold((failure) => emit(MessagingErrorState(failure.message)), (
      messages,
    ) {
      // Sort messages by sentAt time (oldest first)
      final sortedMessages = List<Message>.from(messages)
        ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

      final conversation = Conversation(
        id: event.conversationId,
        user: _getUserForConversation(event.conversationId),
        lastMessage: sortedMessages.isNotEmpty ? sortedMessages.last : null,
        lastMessageAt: sortedMessages.isNotEmpty
            ? sortedMessages.last.sentAt
            : null,
        unreadCount: 0,
      );
      emit(MessagesLoaded(sortedMessages, conversation, currentConversations));
    });
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

    emit(MessagingLoadingState());

    // Create message parameters
    final messageParams = <String, String>{
      'receiverId': event.receiverId,
      'content': event.content,
    };

    if (event.imagePath != null) {
      messageParams['imagePath'] = event.imagePath!;
    }

    final result = await sendMessage(messageParams);
    result.fold((failure) => emit(MessagingErrorState(failure.message)), (
      message,
    ) {
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
    });
  }

  Future<void> _onMarkConversationAsRead(
    MarkConversationAsReadEvent event,
    Emitter<MessagingState> emit,
  ) async {
    // For now, just emit the current state to trigger a rebuild :}
    // this will update the conversation's unread count
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
    final result = await searchUsers(event.query);
    result.fold(
      (failure) => emit(UsersSearchErrorState(failure.message)),
      (users) => emit(UsersSearchLoadedState(users)),
    );
  }

  Future<void> _onStartNewConversation(
    StartNewConversationEvent event,
    Emitter<MessagingState> emit,
  ) async {
    // Preserve current conversations
    List<Conversation> currentConversations = [];
    if (state is ConversationsLoaded) {
      currentConversations = (state as ConversationsLoaded).conversations;
    } else if (state is MessagesLoaded) {
      currentConversations = (state as MessagesLoaded).conversations;
    }

    final conversation = Conversation(
      id: 'conv_${event.user.id}',
      user: event.user,
      lastMessage: null,
      lastMessageAt: null,
      unreadCount: 0,
    );

    // Add the new conversation
    if (!currentConversations.any((conv) => conv.user.id == event.user.id)) {
      currentConversations = [...currentConversations, conversation];
    }

    emit(ConversationsLoaded(currentConversations));
  }

  ChirpUser _getUserForConversation(String conversationId) {
    final userId = conversationId.replaceAll('conv_', 'user_');
    return userId.toMinimalChirpUser();
  }
}
