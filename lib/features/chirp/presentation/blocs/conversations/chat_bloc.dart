import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../entities/conversations/message.dart' hide SendMessageParams;
import '../../usecases/conversations/enhanced_messaging_usecases.dart';
import '../../../data/services/websocket_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final EditMessageUseCase _editMessageUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase;
  final MarkMessagesAsReadUseCase _markMessagesAsReadUseCase;
  final StartTypingUseCase _startTypingUseCase;
  final StopTypingUseCase _stopTypingUseCase;
  final JoinConversationUseCase _joinConversationUseCase;
  final LeaveConversationUseCase _leaveConversationUseCase;
  final ConnectToRealTimeUseCase _connectToRealTimeUseCase;
  final GetDraftUseCase _getDraftUseCase;
  final SaveDraftUseCase _saveDraftUseCase;
  final DeleteDraftUseCase _deleteDraftUseCase;
  final GetTypingIndicatorsStreamUseCase _getTypingIndicatorsStreamUseCase;
  final GetConnectionStateStreamUseCase _getConnectionStateStreamUseCase;
  final GetNewMessagesStreamUseCase _getNewMessagesStreamUseCase;

  StreamSubscription<List<Message>>? _messagesSubscription;
  StreamSubscription<String>? _typingSubscription;
  StreamSubscription<WebSocketConnectionState>? _connectionStateSubscription;
  StreamSubscription<Message>? _newMessagesSubscription;

  Timer? _typingTimer;
  bool _isTyping = false;
  String? _conversationId;
  int _currentPage = 1;
  static const int _pageSize = 50;
  bool _hasMoreMessages = true;
  List<Message> _allMessages = [];

  ChatBloc({
    required GetMessagesUseCase getMessagesUseCase,
    required GetMessagesStreamUseCase getMessagesStreamUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required EditMessageUseCase editMessageUseCase,
    required DeleteMessageUseCase deleteMessageUseCase,
    required MarkMessagesAsReadUseCase markMessagesAsReadUseCase,
    required StartTypingUseCase startTypingUseCase,
    required StopTypingUseCase stopTypingUseCase,
    required JoinConversationUseCase joinConversationUseCase,
    required LeaveConversationUseCase leaveConversationUseCase,
    required ConnectToRealTimeUseCase connectToRealTimeUseCase,
    required GetDraftUseCase getDraftUseCase,
    required SaveDraftUseCase saveDraftUseCase,
    required DeleteDraftUseCase deleteDraftUseCase,
    required GetTypingIndicatorsStreamUseCase getTypingIndicatorsStreamUseCase,
    required GetConnectionStateStreamUseCase getConnectionStateStreamUseCase,
    required GetNewMessagesStreamUseCase getNewMessagesStreamUseCase,
  })  : _getMessagesUseCase = getMessagesUseCase,
        _getMessagesStreamUseCase = getMessagesStreamUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _editMessageUseCase = editMessageUseCase,
        _deleteMessageUseCase = deleteMessageUseCase,
        _markMessagesAsReadUseCase = markMessagesAsReadUseCase,
        _startTypingUseCase = startTypingUseCase,
        _stopTypingUseCase = stopTypingUseCase,
        _joinConversationUseCase = joinConversationUseCase,
        _leaveConversationUseCase = leaveConversationUseCase,
        _connectToRealTimeUseCase = connectToRealTimeUseCase,
        _getDraftUseCase = getDraftUseCase,
        _saveDraftUseCase = saveDraftUseCase,
        _deleteDraftUseCase = deleteDraftUseCase,
        _getTypingIndicatorsStreamUseCase = getTypingIndicatorsStreamUseCase,
        _getConnectionStateStreamUseCase = getConnectionStateStreamUseCase,
        _getNewMessagesStreamUseCase = getNewMessagesStreamUseCase,
        super(const ChatInitial()) {
    on<ChatInitialized>(_onInitialized);
    on<ChatMessagesLoaded>(_onMessagesLoaded);
    on<ChatLoadMoreMessages>(_onLoadMoreMessages);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatMessageEdited>(_onMessageEdited);
    on<ChatMessageDeleted>(_onMessageDeleted);
    on<ChatMessagesMarkedAsRead>(_onMessagesMarkedAsRead);
    on<ChatTypingStarted>(_onTypingStarted);
    on<ChatTypingStopped>(_onTypingStopped);
    on<ChatDraftChanged>(_onDraftChanged);
    on<ChatDraftLoaded>(_onDraftLoaded);
    on<ChatDraftSaved>(_onDraftSaved);
    on<ChatDraftDeleted>(_onDraftDeleted);
    on<ChatMessagesUpdated>(_onMessagesUpdated);
    on<ChatTypingIndicatorReceived>(_onTypingIndicatorReceived);
    on<ChatConnectionStateChanged>(_onConnectionStateChanged);
    on<ChatNewMessageReceived>(_onNewMessageReceived);
  }

  Future<void> _onInitialized(
    ChatInitialized event,
    Emitter<ChatState> emit,
  ) async {
    _conversationId = event.conversationId;
    emit(const ChatLoading());

    try {
      // First, ensure WebSocket connection is established
      final connectResult = await _connectToRealTimeUseCase(NoParams());
      if (connectResult.isLeft()) {
        final failure = connectResult.fold((l) => l, (r) => null);
        emit(ChatError(failure?.message ?? 'Failed to connect to messaging server'));
        return;
      }

      // Wait a moment for connection to stabilize
      await Future.delayed(const Duration(milliseconds: 500));

      // Join the conversation
      final joinResult = await _joinConversationUseCase(
        JoinConversationParams(conversationId: event.conversationId),
      );

      if (joinResult.isLeft()) {
        final failure = joinResult.fold((l) => l, (r) => null);
        emit(ChatError(failure?.message ?? 'Failed to join conversation'));
        return;
      }

      // Load initial messages
      final messagesResult = await _getMessagesUseCase(
        GetMessagesParams(
          conversationId: event.conversationId,
          page: 1,
          pageSize: _pageSize,
        ),
      );

      messagesResult.fold(
        (failure) => emit(ChatError(failure.message)),
        (messages) {
          _allMessages = messages;
          _currentPage = 1;
          _hasMoreMessages = messages.length >= _pageSize;

          emit(ChatLoaded(
            messages: messages,
            conversationId: event.conversationId,
            connectionState: WebSocketConnectionState.connected,
            hasMoreMessages: _hasMoreMessages,
          ));
        },
      );

      // Load draft
      add(ChatDraftLoaded(event.conversationId));

      // Set up streams
      _setupStreams(event.conversationId);
    } catch (e) {
      emit(ChatError('Failed to initialize chat: $e'));
    }
  }

  Future<void> _onMessagesLoaded(
    ChatMessagesLoaded event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded && _conversationId != null) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      final result = await _getMessagesUseCase(
        GetMessagesParams(
          conversationId: _conversationId!,
          page: 1,
          pageSize: _pageSize,
          forceRefresh: true,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(
          isRefreshing: false,
          error: failure.message,
        )),
        (messages) {
          _allMessages = messages;
          _currentPage = 1;
          _hasMoreMessages = messages.length >= _pageSize;

          emit(currentState.copyWith(
            messages: messages,
            isRefreshing: false,
            hasMoreMessages: _hasMoreMessages,
            error: null,
          ));
        },
      );
    }
  }

  Future<void> _onLoadMoreMessages(
    ChatLoadMoreMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded && _conversationId != null && _hasMoreMessages) {
      final currentState = state as ChatLoaded;
      if (currentState.isLoadingMore) return;

      emit(currentState.copyWith(isLoadingMore: true));

      final result = await _getMessagesUseCase(
        GetMessagesParams(
          conversationId: _conversationId!,
          page: _currentPage + 1,
          pageSize: _pageSize,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(
          isLoadingMore: false,
          error: failure.message,
        )),
        (newMessages) {
          _currentPage++;
          _allMessages.addAll(newMessages);
          _hasMoreMessages = newMessages.length >= _pageSize;

          emit(currentState.copyWith(
            messages: _allMessages,
            isLoadingMore: false,
            hasMoreMessages: _hasMoreMessages,
            error: null,
          ));
        },
      );
    }
  }

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded && _conversationId != null) {
      final currentState = state as ChatLoaded;

      final result = await _sendMessageUseCase(
        SendMessageParams(
          conversationId: _conversationId!,
          content: event.content,
          file: event.file,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(error: failure.message)),
        (_) {
          // Clear draft after successful send
          add(ChatDraftDeleted(_conversationId!));
          // Message will be updated via real-time stream
        },
      );
    }
  }

  Future<void> _onMessageEdited(
    ChatMessageEdited event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;

      final result = await _editMessageUseCase(
        EditMessageParams(
          messageId: event.messageId,
          content: event.newContent,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(error: failure.message)),
        (_) {
          // Message will be updated via real-time stream
        },
      );
    }
  }

  Future<void> _onMessageDeleted(
    ChatMessageDeleted event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;

      final result = await _deleteMessageUseCase(
        DeleteMessageParams(messageId: event.messageId),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(error: failure.message)),
        (_) {
          // Message will be updated via real-time stream
        },
      );
    }
  }

  Future<void> _onMessagesMarkedAsRead(
    ChatMessagesMarkedAsRead event,
    Emitter<ChatState> emit,
  ) async {
    if (_conversationId != null) {
      final result = await _markMessagesAsReadUseCase(
        MarkMessagesAsReadParams(
          conversationId: _conversationId!,
          messageIds: event.messageIds,
        ),
      );

      result.fold(
        (failure) {
          if (state is ChatLoaded) {
            final currentState = state as ChatLoaded;
            emit(currentState.copyWith(error: failure.message));
          }
        },
        (_) {
          // Messages will be updated via real-time stream
        },
      );
    }
  }

  Future<void> _onTypingStarted(
    ChatTypingStarted event,
    Emitter<ChatState> emit,
  ) async {
    // Typing indicators disabled to avoid backend errors
    // This method is now a no-op
  }

  Future<void> _onTypingStopped(
    ChatTypingStopped event,
    Emitter<ChatState> emit,
  ) async {
    // Typing indicators disabled to avoid backend errors
    // This method is now a no-op
    _typingTimer?.cancel();
    _isTyping = false;
  }

  Future<void> _onDraftChanged(
    ChatDraftChanged event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded && _conversationId != null) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(draftText: event.content));

      if (event.content.isNotEmpty) {
        // Save draft (removed typing indicator)
        add(ChatDraftSaved(_conversationId!, event.content));
      } else {
        // Delete draft (removed typing indicator)
        add(ChatDraftDeleted(_conversationId!));
      }
    }
  }

  Future<void> _onDraftLoaded(
    ChatDraftLoaded event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _getDraftUseCase(
      GetDraftParams(conversationId: event.conversationId),
    );

    result.fold(
      (failure) {
        // Draft loading failed, but not critical
        debugPrint('Error loading draft: ${failure.message}');
      },
      (draft) {
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          emit(currentState.copyWith(draftText: draft ?? ''));
        }
      },
    );
  }

  Future<void> _onDraftSaved(
    ChatDraftSaved event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _saveDraftUseCase(
      SaveDraftParams(
        conversationId: event.conversationId,
        content: event.content,
      ),
    );

    result.fold(
      (failure) {
        // Draft saving failed, but not critical
        debugPrint('Error saving draft: ${failure.message}');
      },
      (_) {
        // Draft saved successfully
      },
    );
  }

  Future<void> _onDraftDeleted(
    ChatDraftDeleted event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _deleteDraftUseCase(
      DeleteDraftParams(conversationId: event.conversationId),
    );

    result.fold(
      (failure) {
        // Draft deletion failed, but not critical
        debugPrint('Error deleting draft: ${failure.message}');
      },
      (_) {
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          emit(currentState.copyWith(draftText: ''));
        }
      },
    );
  }

  Future<void> _onMessagesUpdated(
    ChatMessagesUpdated event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      _allMessages = event.messages;
      emit(currentState.copyWith(messages: event.messages));
    }
  }

  Future<void> _onTypingIndicatorReceived(
    ChatTypingIndicatorReceived event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(typingUsers: [event.userId]));

      // Clear typing indicator after 5 seconds
      Timer(const Duration(seconds: 5), () {
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          final updatedTypingUsers = List<String>.from(currentState.typingUsers)
            ..remove(event.userId);
          emit(currentState.copyWith(typingUsers: updatedTypingUsers));
        }
      });
    }
  }

  Future<void> _onConnectionStateChanged(
    ChatConnectionStateChanged event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(connectionState: event.state));
    }
  }

  Future<void> _onNewMessageReceived(
    ChatNewMessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded && event.message.conversationId == _conversationId) {
      // Add the new message to current messages for immediate UI update
      final currentState = state as ChatLoaded;
      final updatedMessages = [..._allMessages, event.message];
      _allMessages = updatedMessages;
      
      emit(currentState.copyWith(messages: updatedMessages));
      
      // Mark message as read automatically
      add(ChatMessagesMarkedAsRead([event.message.id]));
    }
  }

  void _setupStreams(String conversationId) {
    // Messages stream
    _messagesSubscription?.cancel();
    _messagesSubscription = _getMessagesStreamUseCase(
      GetMessagesStreamParams(conversationId: conversationId),
    ).listen(
      (messages) => add(ChatMessagesUpdated(messages)),
      onError: (error) => debugPrint('Messages stream error: $error'),
    );

    // Typing indicators stream
    _typingSubscription?.cancel();
    _typingSubscription = _getTypingIndicatorsStreamUseCase(
      NoParams(),
    ).listen(
      (userId) => add(ChatTypingIndicatorReceived(userId)),
      onError: (error) => debugPrint('Typing stream error: $error'),
    );

    // Connection state stream
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = _getConnectionStateStreamUseCase(
      NoParams(),
    ).listen(
      (state) => add(ChatConnectionStateChanged(state)),
      onError: (error) => debugPrint('Connection state stream error: $error'),
    );

    // New messages stream
    _newMessagesSubscription?.cancel();
    _newMessagesSubscription = _getNewMessagesStreamUseCase(
      NoParams(),
    ).listen(
      (message) => add(ChatNewMessageReceived(message)),
      onError: (error) => debugPrint('New messages stream error: $error'),
    );
  }

  @override
  Future<void> close() async {
    // Leave conversation when closing
    if (_conversationId != null) {
      await _leaveConversationUseCase(NoParams());
    }

    _typingTimer?.cancel();
    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _newMessagesSubscription?.cancel();

    return super.close();
  }
}