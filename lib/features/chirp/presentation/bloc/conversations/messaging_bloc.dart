import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/conversations/get_conversations.dart';
import '../../../domain/usecases/conversations/get_messages.dart';
import '../../../domain/usecases/conversations/send_message.dart';
import '../../../domain/usecases/search_users_usecase.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../../../core/usecase/usecase.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
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

    final result = await getMessages(event.conversationId);
    result.fold((failure) => emit(MessagingErrorState(failure.message)), (
      messages,
    ) {
      // TODO: Uncomment
      // // get conversation details from API
      final conversation = Conversation(
        id: event.conversationId,
        user: _getUserForConversation(event.conversationId),
        lastMessage: messages.isNotEmpty ? messages.first : null,
        lastMessageAt: messages.isNotEmpty ? messages.first.sentAt : null,
        unreadCount: 0,
      );
      emit(MessagesLoaded(messages, conversation, currentConversations));
    });
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<MessagingState> emit,
  ) async {
    emit(MessagingLoadingState());
    final result = await sendMessage({
      'receiverId': event.receiverId,
      'content': event.content,
    });
    result.fold(
      (failure) => emit(MessagingErrorState(failure.message)),
      (message) => emit(MessageSentState(message)),
    );
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

  // TODO: Uncomment
  UserProfile _getUserForConversation(String conversationId) {
    final userId = conversationId.replaceAll('conv_', 'user_');
    return userId.toMinimalUserProfile();
  }
}
