import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../../../core/core.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/conversations/message.dart';
import '../models/conversations/message_api_model.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../profile/data/datasources/profile_local_datasource.dart';
import 'messaging_notification_service.dart';

enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

class WebSocketService {
  final Logger _logger = Logger();
  final AuthLocalDatasource _authLocalDatasource;
  final ProfileLocalDatasource _profileLocalDatasource;
  final MessagingNotificationService _notificationService;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  WebSocketConnectionState _connectionState = WebSocketConnectionState.disconnected;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _heartbeatInterval = Duration(seconds: 30);

  final Queue<DateTime> _messageTimes = Queue<DateTime>();
  static const int _maxMessagesPerMinute = 100;
  static const Duration _rateLimitWindow = Duration(minutes: 1);

  final StreamController<WebSocketConnectionState> _connectionStateController =
      StreamController<WebSocketConnectionState>.broadcast();
  final StreamController<Message> _messageController = 
      StreamController<Message>.broadcast();
  final StreamController<String> _typingController = 
      StreamController<String>.broadcast();
  final StreamController<Map<String, dynamic>> _errorController = 
      StreamController<Map<String, dynamic>>.broadcast();

  String? _currentConversationId;

  WebSocketService({
    required AuthLocalDatasource authLocalDatasource,
    required ProfileLocalDatasource profileLocalDatasource,
    required MessagingNotificationService notificationService,
  }) : _authLocalDatasource = authLocalDatasource,
       _profileLocalDatasource = profileLocalDatasource,
       _notificationService = notificationService;

  Stream<WebSocketConnectionState> get connectionState =>
      _connectionStateController.stream;

  Stream<Message> get messages => _messageController.stream;

  Stream<String> get typingIndicators => _typingController.stream;

  Stream<Map<String, dynamic>> get errors => _errorController.stream;

  WebSocketConnectionState get currentConnectionState => _connectionState;

  Future<Either<Failure, void>> connect() async {
    try {
      if (_connectionState == WebSocketConnectionState.connected ||
          _connectionState == WebSocketConnectionState.connecting) {
        return const Right(null);
      }

      _updateConnectionState(WebSocketConnectionState.connecting);

      // Get JWT token
      final tokenResult = await _authLocalDatasource.getTokenByProvider('verisafe');
      
      return await tokenResult.fold(
        (failure) async {
          _logger.e('Failed to get JWT token for WebSocket: ${failure.message}');
          _updateConnectionState(WebSocketConnectionState.error);
          return Left(failure);
        },
        (tokenData) async {
          try {
            final wsUrl = _buildWebSocketUrl(tokenData.accessToken);
            _logger.i('Connecting to WebSocket: $wsUrl');

            // Create WebSocket connection
            _channel = WebSocketChannel.connect(
              Uri.parse(wsUrl),
              protocols: ['echo-protocol'],
            );

            // Set up message listener
            _subscription = _channel!.stream.listen(
              _handleIncomingMessage,
              onError: _handleWebSocketError,
              onDone: _handleWebSocketClosed,
              cancelOnError: false,
            );

            // Start heartbeat
            _startHeartbeat();

            _updateConnectionState(WebSocketConnectionState.connected);
            _reconnectAttempts = 0;

            _logger.i('WebSocket connected successfully');
            return const Right(null);

          } catch (e) {
            _logger.e('WebSocket connection error: $e');
            _updateConnectionState(WebSocketConnectionState.error);
            return Left(
              NetworkFailure(
                error: e,
                message: 'Failed to connect to messaging server. Please check your internet connection.',
              ),
            );
          }
        },
      );
    } catch (e) {
      _logger.e('WebSocket service error: $e');
      _updateConnectionState(WebSocketConnectionState.error);
      return Left(
        NetworkFailure(
          error: e,
          message: 'Messaging service is temporarily unavailable.',
        ),
      );
    }
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    _logger.i('Disconnecting WebSocket');
    
    _stopHeartbeat();
    _stopReconnectTimer();
    
    await _subscription?.cancel();
    await _channel?.sink.close(status.normalClosure);
    
    _channel = null;
    _subscription = null;
    _currentConversationId = null;
    
    _updateConnectionState(WebSocketConnectionState.disconnected);
  }

  /// Join a conversation
  Future<Either<Failure, void>> joinConversation(String conversationId) async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return Left(
        NetworkFailure(
          message: 'Cannot join conversation. Not connected to messaging server.',
          error: 'WebSocket not connected',
        ),
      );
    }

    if (!_checkRateLimit()) {
      return Left(
        ServerFailure(
          message: 'Too many messages sent. Please wait a moment.',
          error: 'Rate limit exceeded',
        ),
      );
    }

    try {
      final message = {
        'type': 'join_conversation',
        'conversation_id': conversationId,
      };

      _channel!.sink.add(jsonEncode(message));
      _currentConversationId = conversationId;

      _logger.d('Joined conversation: $conversationId');
      return const Right(null);

    } catch (e) {
      _logger.e('Failed to join conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to join conversation.',
        ),
      );
    }
  }

  /// Leave current conversation
  Future<Either<Failure, void>> leaveConversation() async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return Left(
        NetworkFailure(
          message: 'Not connected to messaging server.',
          error: 'WebSocket not connected',
        ),
      );
    }

    if (!_checkRateLimit()) {
      return Left(
        ServerFailure(
          message: 'Too many messages sent. Please wait a moment.',
          error: 'Rate limit exceeded',
        ),
      );
    }

    try {
      final message = {'type': 'leave_conversation'};
      _channel!.sink.add(jsonEncode(message));
      _currentConversationId = null;

      _logger.d('Left conversation');
      return const Right(null);

    } catch (e) {
      _logger.e('Failed to leave conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to leave conversation.',
        ),
      );
    }
  }

  /// Send a chat message
  Future<Either<Failure, void>> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return Left(
        NetworkFailure(
          message: 'Cannot send message. Not connected to messaging server.',
          error: 'WebSocket not connected',
        ),
      );
    }

    if (!_checkRateLimit()) {
      return Left(
        ServerFailure(
          message: 'Too many messages sent. Please wait a moment.',
          error: 'Rate limit exceeded',
        ),
      );
    }

    try {
      final message = {
        'type': 'chat_message',
        'content': content,
        'conversation_id': conversationId,
      };

      _channel!.sink.add(jsonEncode(message));
      
      _logger.d('Sent message to conversation: $conversationId');
      return const Right(null);

    } catch (e) {
      _logger.e('Failed to send message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to send message.',
        ),
      );
    }
  }

  /// Edit a message
  Future<Either<Failure, void>> editMessage({
    required int messageId,
    required String content,
  }) async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return Left(
        NetworkFailure(
          message: 'Cannot edit message. Not connected to messaging server.',
          error: 'WebSocket not connected',
        ),
      );
    }

    if (!_checkRateLimit()) {
      return Left(
        ServerFailure(
          message: 'Too many actions performed. Please wait a moment.',
          error: 'Rate limit exceeded',
        ),
      );
    }

    try {
      final message = {
        'type': 'edit_message',
        'message_id': messageId,
        'content': content,
      };

      _channel!.sink.add(jsonEncode(message));
      
      _logger.d('Edited message: $messageId');
      return const Right(null);

    } catch (e) {
      _logger.e('Failed to edit message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to edit message.',
        ),
      );
    }
  }

  /// Delete a message
  Future<Either<Failure, void>> deleteMessage(int messageId) async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return Left(
        NetworkFailure(
          message: 'Cannot delete message. Not connected to messaging server.',
          error: 'WebSocket not connected',
        ),
      );
    }

    if (!_checkRateLimit()) {
      return Left(
        ServerFailure(
          message: 'Too many actions performed. Please wait a moment.',
          error: 'Rate limit exceeded',
        ),
      );
    }

    try {
      final message = {
        'type': 'delete_message',
        'message_id': messageId,
      };

      _channel!.sink.add(jsonEncode(message));
      
      _logger.d('Deleted message: $messageId');
      return const Right(null);

    } catch (e) {
      _logger.e('Failed to delete message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to delete message.',
        ),
      );
    }
  }

  Future<Either<Failure, void>> startTyping() async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return const Right(null); // Silently ignore if not connected
    }

    try {
      final message = {'type': 'typing_start'};
      _channel!.sink.add(jsonEncode(message));
      return const Right(null);

    } catch (e) {
      _logger.w('Failed to send typing indicator: $e');
      return const Right(null); // Non-critical failure
    }
  }

  /// Stop typing indicator
  Future<Either<Failure, void>> stopTyping() async {
    if (_connectionState != WebSocketConnectionState.connected) {
      return const Right(null); // Silently ignore if not connected
    }

    try {
      final message = {'type': 'typing_stop'};
      _channel!.sink.add(jsonEncode(message));
      return const Right(null);

    } catch (e) {
      _logger.w('Failed to send typing stop indicator: $e');
      return const Right(null); // Non-critical failure
    }
  }

  String _buildWebSocketUrl(String jwtToken) {
    const baseUrl = 'wss://qachirp.opencrafts.io/ws/chat/';
    return '$baseUrl?token=$jwtToken';
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final messageData = jsonDecode(data.toString()) as Map<String, dynamic>;
      final messageType = messageData['type'] as String?;

      _logger.d('Received WebSocket message: $messageType');

      switch (messageType) {
        case 'connection_established':
          _handleConnectionEstablished(messageData);
          break;
        case 'conversation_joined':
          _handleConversationJoined(messageData);
          break;
        case 'chat_message':
          _handleChatMessage(messageData);
          break;
        case 'message_edited':
          _handleMessageEdited(messageData);
          break;
        case 'message_deleted':
          _handleMessageDeleted(messageData);
          break;
        case 'typing_start':
          _handleTypingStart(messageData);
          break;
        case 'typing_stop':
          _handleTypingStop(messageData);
          break;
        case 'heartbeat':
          _handleHeartbeat(messageData);
          break;
        case 'heartbeat_response':
          _handleHeartbeat(messageData);
          break;
        case 'error':
          _handleServerError(messageData);
          break;
        default:
          _logger.w('Unknown message type: $messageType');
      }
    } catch (e) {
      _logger.e('Error processing WebSocket message: $e');
      _errorController.add({
        'type': 'parse_error',
        'message': 'Failed to process server message',
        'error': e.toString(),
      });
    }
  }

  void _handleConnectionEstablished(Map<String, dynamic> data) {
    _logger.i('WebSocket connection established');
  }

  void _handleConversationJoined(Map<String, dynamic> data) {
    final conversationId = data['conversation_id'] as String?;
    _logger.d('Successfully joined conversation: $conversationId');
  }

  Future<void> _handleChatMessage(Map<String, dynamic> data) async {
    try {
      final messageData = data['message'] as Map<String, dynamic>?;
      if (messageData != null) {
        _logger.d('Processing WebSocket message: ${messageData.toString()}');
        
        if (messageData['attachments'] == null) {
          messageData['attachments'] = <Map<String, dynamic>>[];
        }
        
        if (messageData['conversation_id'] == null && data['conversation_id'] != null) {
          messageData['conversation_id'] = data['conversation_id'];
        }
        
        final messageModel = MessageApiModel.fromJson(messageData);
        final message = messageModel.toEntity();
        
        _logger.d('Emitting message via WebSocket stream: ${message.id} for conversation: ${message.conversationId}');
        _logger.d('Stream has listeners: ${_messageController.hasListener}');
        _messageController.add(message);
        _logger.d('Message added to stream controller');
        
        await _showNotificationForMessage(message);
        
      }
    } catch (e) {
      _logger.e('Error processing chat message: $e');
      _logger.e('Message data: $data');
    }
  }

  void _handleMessageEdited(Map<String, dynamic> data) {
    try {
      final messageData = data['message'] as Map<String, dynamic>?;
      if (messageData != null) {
        final messageModel = MessageApiModel.fromJson(messageData);
        final message = messageModel.toEntity();
        _messageController.add(message); // UI will handle edit detection
      }
    } catch (e) {
      _logger.e('Error processing message edit: $e');
    }
  }

  void _handleMessageDeleted(Map<String, dynamic> data) {
    try {
      final messageId = data['message_id'] as int?;
      if (messageId != null) {
        _logger.d('Message deleted: $messageId');
      }
    } catch (e) {
      _logger.e('Error processing message deletion: $e');
    }
  }

  void _handleTypingStart(Map<String, dynamic> data) {
    final userId = data['user_id'] as String?;
    if (userId != null) {
      _typingController.add(userId);
    }
  }

  void _handleTypingStop(Map<String, dynamic> data) {
    final userId = data['user_id'] as String?;
    if (userId != null) {
      _typingController.add(''); // Empty string indicates stop
    }
  }

  void _handleHeartbeat(Map<String, dynamic> data) {
    _logger.v('Heartbeat received');
    _reconnectAttempts = 0;
  }

  void _handleServerError(Map<String, dynamic> data) {
    final errorMessage = data['message'] as String? ?? 'Unknown server error';
    _logger.e('Server error: $errorMessage');
    _errorController.add({
      'type': 'server_error',
      'message': errorMessage,
    });
  }
  
  Future<void> _showNotificationForMessage(Message message) async {
    try {
      // Get current user ID to avoid showing notifications for own messages
      final currentUserId = await _getCurrentUserId();
      
      // Don't show notification if this is the current user's own message
      if (currentUserId != null && message.sender.userId == currentUserId) {
        _logger.d('Skipping notification for own message: ${message.id}');
        return;
      }
      
      // TODO: Add additional logic to check if:
      // 1. App is in foreground vs background
      // 2. User is currently viewing this conversation
      // 3. User has notifications enabled
      
      _logger.d('Showing notification for message: ${message.id} from ${message.sender.name}');
      
      await _notificationService.showMessageNotification(message);
    } catch (e) {
      _logger.e('Error showing notification for message: $e');
      // Don't throw - notifications are not critical for messaging functionality
    }
  }
  
  /// Get the current user ID for notification filtering
  Future<String?> _getCurrentUserId() async {
    try {
      final result = await _profileLocalDatasource.getCachedUserProfile();
      return result.fold(
        (failure) {
          _logger.w('Failed to get current user ID: ${failure.message}');
          return null;
        },
        (profile) => profile.id,
      );
    } catch (e) {
      _logger.e('Error getting current user ID: $e');
      return null;
    }
  }

  void _handleWebSocketError(dynamic error) {
    _logger.e('WebSocket error: $error');
    _updateConnectionState(WebSocketConnectionState.error);
    _attemptReconnect();
  }

  void _handleWebSocketClosed() {
    _logger.w('WebSocket connection closed');
    _updateConnectionState(WebSocketConnectionState.disconnected);
    _attemptReconnect();
  }

  void _startHeartbeat() {
    _stopHeartbeat(); // Ensure no duplicate timers
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      _sendHeartbeat();
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void _sendHeartbeat() {
    if (_connectionState == WebSocketConnectionState.connected) {
      try {
        final message = {'type': 'heartbeat'};
        _channel?.sink.add(jsonEncode(message));
      } catch (e) {
        _logger.e('Failed to send heartbeat: $e');
      }
    }
  }

  void _attemptReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logger.e('Max reconnect attempts reached');
      _updateConnectionState(WebSocketConnectionState.error);
      return;
    }

    if (_connectionState == WebSocketConnectionState.reconnecting) {
      return; // Already attempting reconnection
    }

    _updateConnectionState(WebSocketConnectionState.reconnecting);

    final delay = Duration(
      seconds: min(pow(2, _reconnectAttempts).toInt(), 30),
    );

    _logger.i('Attempting reconnection in ${delay.inSeconds}s (attempt ${_reconnectAttempts + 1})');

    _stopReconnectTimer();
    _reconnectTimer = Timer(delay, () async {
      _reconnectAttempts++;
      final result = await connect();
      result.fold(
        (failure) {
          _logger.e('Reconnection attempt failed: ${failure.message}');
          _attemptReconnect(); // Try again
        },
        (_) {
          _logger.i('Reconnection successful');
          // Rejoin current conversation if we were in one
          if (_currentConversationId != null) {
            joinConversation(_currentConversationId!);
          }
        },
      );
    });
  }

  /// Stop reconnect timer
  void _stopReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  /// Update connection state and notify listeners
  void _updateConnectionState(WebSocketConnectionState newState) {
    if (_connectionState != newState) {
      _connectionState = newState;
      _connectionStateController.add(newState);
      _logger.d('Connection state changed to: $newState');
    }
  }

  /// Check rate limiting (100 messages per minute)
  bool _checkRateLimit() {
    final now = DateTime.now();
    
    // Remove old messages outside the window
    _messageTimes.removeWhere(
      (time) => now.difference(time) > _rateLimitWindow,
    );

    if (_messageTimes.length >= _maxMessagesPerMinute) {
      _logger.w('Rate limit exceeded');
      return false;
    }

    _messageTimes.add(now);
    return true;
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _connectionStateController.close();
    _messageController.close();
    _typingController.close();
    _errorController.close();
  }
}

/// Rate limit failure
class RateLimitFailure extends Failure {
  RateLimitFailure({
    required String message,
  }) : super(
          error: Exception('Rate limit exceeded'),
          message: message,
        );
}