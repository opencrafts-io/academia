import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../entities/conversations/conversation.dart';
import '../../entities/conversations/message.dart';
import '../../usecases/conversations/enhanced_messaging_usecases.dart';
import '../../../data/services/websocket_service.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  final GetConversationsUseCase _getConversationsUseCase;
  final GetConversationsStreamUseCase _getConversationsStreamUseCase;
  final CreateConversationUseCase _createConversationUseCase;
  final ConnectToRealTimeUseCase _connectToRealTimeUseCase;
  final DisconnectFromRealTimeUseCase _disconnectFromRealTimeUseCase;
  final GetConnectionStateStreamUseCase _getConnectionStateStreamUseCase;
  final GetNewMessagesStreamUseCase _getNewMessagesStreamUseCase;
  final SyncOfflineMessagesUseCase _syncOfflineMessagesUseCase;

  StreamSubscription<List<Conversation>>? _conversationsSubscription;
  StreamSubscription<WebSocketConnectionState>? _connectionStateSubscription;
  StreamSubscription<Message>? _newMessagesSubscription;

  String? _currentUserId;
  String _searchQuery = '';
  List<Conversation> _allConversations = [];

  ConversationListBloc({
    required GetConversationsUseCase getConversationsUseCase,
    required GetConversationsStreamUseCase getConversationsStreamUseCase,
    required CreateConversationUseCase createConversationUseCase,
    required ConnectToRealTimeUseCase connectToRealTimeUseCase,
    required DisconnectFromRealTimeUseCase disconnectFromRealTimeUseCase,
    required GetConnectionStateStreamUseCase getConnectionStateStreamUseCase,
    required GetNewMessagesStreamUseCase getNewMessagesStreamUseCase,
    required SyncOfflineMessagesUseCase syncOfflineMessagesUseCase,
  })  : _getConversationsUseCase = getConversationsUseCase,
        _getConversationsStreamUseCase = getConversationsStreamUseCase,
        _createConversationUseCase = createConversationUseCase,
        _connectToRealTimeUseCase = connectToRealTimeUseCase,
        _disconnectFromRealTimeUseCase = disconnectFromRealTimeUseCase,
        _getConnectionStateStreamUseCase = getConnectionStateStreamUseCase,
        _getNewMessagesStreamUseCase = getNewMessagesStreamUseCase,
        _syncOfflineMessagesUseCase = syncOfflineMessagesUseCase,
        super(const ConversationListInitial()) {
    on<ConversationListInitialized>(_onInitialized);
    on<ConversationListRefreshed>(_onRefreshed);
    on<ConversationListSearchChanged>(_onSearchChanged);
    on<ConversationListCreateConversation>(_onCreateConversation);
    on<ConversationListConnectToRealTime>(_onConnectToRealTime);
    on<ConversationListDisconnectFromRealTime>(_onDisconnectFromRealTime);
    on<ConversationListConversationsUpdated>(_onConversationsUpdated);
    on<ConversationListConnectionStateChanged>(_onConnectionStateChanged);
    on<ConversationListNewMessageReceived>(_onNewMessageReceived);
    on<ConversationListSyncOffline>(_onSyncOffline);
  }

  Future<void> _onInitialized(
    ConversationListInitialized event,
    Emitter<ConversationListState> emit,
  ) async {
    _currentUserId = event.currentUserId;
    emit(const ConversationListLoading());

    try {
      // Load initial conversations
      final result = await _getConversationsUseCase(
        GetConversationsParams(
          currentUserId: _currentUserId,
          forceRefresh: false,
        ),
      );

      result.fold(
        (failure) => emit(ConversationListError(failure.message)),
        (conversations) {
          _allConversations = conversations;
          emit(ConversationListLoaded(
            conversations: _filterConversations(conversations),
            connectionState: WebSocketConnectionState.disconnected,
            searchQuery: _searchQuery,
          ));
        },
      );

      // Start listening to real-time conversations stream
      _conversationsSubscription?.cancel();
      _conversationsSubscription = _getConversationsStreamUseCase(
        GetConversationsStreamParams(currentUserId: _currentUserId),
      ).listen(
        (conversations) => add(ConversationListConversationsUpdated(conversations)),
        onError: (error) => add(ConversationListErrorEvent('Stream error: $error')),
      );

      // Start listening to connection state
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = _getConnectionStateStreamUseCase(
        NoParams(),
      ).listen(
        (state) => add(ConversationListConnectionStateChanged(state)),
      );

      // Start listening to new messages for badge updates
      _newMessagesSubscription?.cancel();
      _newMessagesSubscription = _getNewMessagesStreamUseCase(
        NoParams(),
      ).listen(
        (message) => add(ConversationListNewMessageReceived(message)),
      );
    } catch (e) {
      emit(ConversationListError('Failed to initialize: $e'));
    }
  }

  Future<void> _onRefreshed(
    ConversationListRefreshed event,
    Emitter<ConversationListState> emit,
  ) async {
    if (state is ConversationListLoaded) {
      final currentState = state as ConversationListLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      final result = await _getConversationsUseCase(
        GetConversationsParams(
          currentUserId: _currentUserId,
          forceRefresh: true,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(
          isRefreshing: false,
          error: failure.message,
        )),
        (conversations) {
          _allConversations = conversations;
          emit(currentState.copyWith(
            conversations: _filterConversations(conversations),
            isRefreshing: false,
            error: null,
          ));
        },
      );
    }
  }

  Future<void> _onSearchChanged(
    ConversationListSearchChanged event,
    Emitter<ConversationListState> emit,
  ) async {
    _searchQuery = event.query;
    if (state is ConversationListLoaded) {
      final currentState = state as ConversationListLoaded;
      emit(currentState.copyWith(
        conversations: _filterConversations(_allConversations),
        searchQuery: _searchQuery,
      ));
    }
  }

  Future<void> _onCreateConversation(
    ConversationListCreateConversation event,
    Emitter<ConversationListState> emit,
  ) async {
    if (state is ConversationListLoaded) {
      final currentState = state as ConversationListLoaded;
      emit(currentState.copyWith(isCreatingConversation: true));

      final result = await _createConversationUseCase(
        CreateConversationParams(
          otherUserId: event.otherUserId,
          otherUserName: event.otherUserName,
          currentUserId: _currentUserId,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(
          isCreatingConversation: false,
          error: failure.message,
        )),
        (conversation) {
          emit(currentState.copyWith(
            isCreatingConversation: false,
            error: null,
            createdConversation: conversation,
          ));
        },
      );
    }
  }

  Future<void> _onConnectToRealTime(
    ConversationListConnectToRealTime event,
    Emitter<ConversationListState> emit,
  ) async {
    final result = await _connectToRealTimeUseCase(NoParams());
    result.fold(
      (failure) {
        if (state is ConversationListLoaded) {
          final currentState = state as ConversationListLoaded;
          emit(currentState.copyWith(error: failure.message));
        }
      },
      (_) {
        // Connection state will be updated via stream
      },
    );
  }

  Future<void> _onDisconnectFromRealTime(
    ConversationListDisconnectFromRealTime event,
    Emitter<ConversationListState> emit,
  ) async {
    await _disconnectFromRealTimeUseCase(NoParams());
  }

  Future<void> _onConversationsUpdated(
    ConversationListConversationsUpdated event,
    Emitter<ConversationListState> emit,
  ) async {
    _allConversations = event.conversations;
    if (state is ConversationListLoaded) {
      final currentState = state as ConversationListLoaded;
      emit(currentState.copyWith(
        conversations: _filterConversations(event.conversations),
      ));
    }
  }

  Future<void> _onConnectionStateChanged(
    ConversationListConnectionStateChanged event,
    Emitter<ConversationListState> emit,
  ) async {
    if (state is ConversationListLoaded) {
      final currentState = state as ConversationListLoaded;
      emit(currentState.copyWith(connectionState: event.state));

      // Sync offline messages when reconnected
      if (event.state == WebSocketConnectionState.connected) {
        add(const ConversationListSyncOffline());
      }
    }
  }

  Future<void> _onNewMessageReceived(
    ConversationListNewMessageReceived event,
    Emitter<ConversationListState> emit,
  ) async {
    // This will be handled by the conversations stream automatically
    // Just trigger a refresh to ensure UI is up to date
    debugPrint('New message received: ${event.message.content}');
  }

  Future<void> _onSyncOffline(
    ConversationListSyncOffline event,
    Emitter<ConversationListState> emit,
  ) async {
    final result = await _syncOfflineMessagesUseCase(NoParams());
    result.fold(
      (failure) {
        if (state is ConversationListLoaded) {
          final currentState = state as ConversationListLoaded;
          emit(currentState.copyWith(error: failure.message));
        }
      },
      (_) {
        // Sync completed successfully
      },
    );
  }

  List<Conversation> _filterConversations(List<Conversation> conversations) {
    if (_searchQuery.isEmpty) {
      return conversations;
    }

    return conversations.where((conversation) {
      final otherUser = conversation.participants
          .firstWhere((p) => p.userId != _currentUserId, orElse: () => conversation.participants.first);
      return otherUser.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (conversation.lastMessage?.content.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _newMessagesSubscription?.cancel();
    return super.close();
  }
}