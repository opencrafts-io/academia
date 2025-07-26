import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/conversations/get_conversations.dart';
import '../../../domain/usecases/conversations/get_messages.dart';
import '../../../domain/usecases/conversations/send_message.dart';
import '../../../../../core/usecase/usecase.dart';
import 'messaging_state.dart';
import 'messaging_event.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final GetConversations getConversations;
  final GetMessages getMessages;
  final SendMessage sendMessage;

  MessagingBloc({
    required this.getConversations,
    required this.getMessages,
    required this.sendMessage,
  }) : super(MessagingInitialState()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
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
    emit(MessagingLoadingState());
    final result = await getMessages(event.conversationId);
    result.fold(
      (failure) => emit(MessagingErrorState(failure.message)),
      (messages) => emit(MessagesLoaded(messages)),
    );
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
      (message) => emit(MessageSent(message)),
    );
  }
}
