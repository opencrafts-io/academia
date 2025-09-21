import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../entities/conversations/conversation.dart';
import '../../entities/conversations/message.dart';
import '../../repositories/conversations/enhanced_conversation_repository.dart';
import '../../../data/services/websocket_service.dart';

/// Get conversations use case
class GetConversationsUseCase extends UseCase<List<Conversation>, GetConversationsParams> {
  final EnhancedConversationRepository repository;

  GetConversationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Conversation>>> call(GetConversationsParams params) async {
    return await repository.getConversations(
      currentUserId: params.currentUserId,
      forceRefresh: params.forceRefresh,
    );
  }
}

/// Get conversations stream use case
class GetConversationsStreamUseCase extends StreamUseCase<List<Conversation>, GetConversationsStreamParams> {
  final EnhancedConversationRepository repository;

  GetConversationsStreamUseCase(this.repository);

  @override
  Stream<List<Conversation>> call(GetConversationsStreamParams params) {
    return repository.getConversationsStream(currentUserId: params.currentUserId);
  }
}

/// Create conversation use case
class CreateConversationUseCase extends UseCase<Conversation, CreateConversationParams> {
  final EnhancedConversationRepository repository;

  CreateConversationUseCase(this.repository);

  @override
  Future<Either<Failure, Conversation>> call(CreateConversationParams params) async {
    return await repository.createConversation(
      otherUserId: params.otherUserId,
      otherUserName: params.otherUserName,
      currentUserId: params.currentUserId,
    );
  }
}

/// Get messages use case
class GetMessagesUseCase extends UseCase<List<Message>, GetMessagesParams> {
  final EnhancedConversationRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(GetMessagesParams params) async {
    return await repository.getMessages(
      conversationId: params.conversationId,
      page: params.page,
      pageSize: params.pageSize,
      forceRefresh: params.forceRefresh,
    );
  }
}

/// Get messages stream use case
class GetMessagesStreamUseCase extends StreamUseCase<List<Message>, GetMessagesStreamParams> {
  final EnhancedConversationRepository repository;

  GetMessagesStreamUseCase(this.repository);

  @override
  Stream<List<Message>> call(GetMessagesStreamParams params) {
    return repository.getMessagesStream(params.conversationId);
  }
}

/// Send message use case
class SendMessageUseCase extends UseCase<void, SendMessageParams> {
  final EnhancedConversationRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      conversationId: params.conversationId,
      content: params.content,
      file: params.file,
    );
  }
}

/// Mark messages as read use case
class MarkMessagesAsReadUseCase extends UseCase<void, MarkMessagesAsReadParams> {
  final EnhancedConversationRepository repository;

  MarkMessagesAsReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkMessagesAsReadParams params) async {
    return await repository.markMessagesAsRead(
      conversationId: params.conversationId,
      messageIds: params.messageIds,
    );
  }
}

/// Edit message use case
class EditMessageUseCase extends UseCase<void, EditMessageParams> {
  final EnhancedConversationRepository repository;

  EditMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(EditMessageParams params) async {
    return await repository.editMessage(
      messageId: params.messageId,
      content: params.content,
    );
  }
}

/// Delete message use case
class DeleteMessageUseCase extends UseCase<void, DeleteMessageParams> {
  final EnhancedConversationRepository repository;

  DeleteMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteMessageParams params) async {
    return await repository.deleteMessage(params.messageId);
  }
}

/// Start typing use case
class StartTypingUseCase extends UseCase<void, TypingParams> {
  final EnhancedConversationRepository repository;

  StartTypingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TypingParams params) async {
    return await repository.startTyping(params.conversationId);
  }
}

/// Stop typing use case
class StopTypingUseCase extends UseCase<void, TypingParams> {
  final EnhancedConversationRepository repository;

  StopTypingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TypingParams params) async {
    return await repository.stopTyping(params.conversationId);
  }
}

/// Join conversation use case
class JoinConversationUseCase extends UseCase<void, JoinConversationParams> {
  final EnhancedConversationRepository repository;

  JoinConversationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinConversationParams params) async {
    return await repository.joinConversation(params.conversationId);
  }
}

/// Leave conversation use case
class LeaveConversationUseCase extends UseCase<void, NoParams> {
  final EnhancedConversationRepository repository;

  LeaveConversationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.leaveConversation();
  }
}

/// Connect to real-time use case
class ConnectToRealTimeUseCase extends UseCase<void, NoParams> {
  final EnhancedConversationRepository repository;

  ConnectToRealTimeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.connectToRealTime();
  }
}

/// Disconnect from real-time use case
class DisconnectFromRealTimeUseCase extends UseCase<void, NoParams> {
  final EnhancedConversationRepository repository;

  DisconnectFromRealTimeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    await repository.disconnectFromRealTime();
    return const Right(null);
  }
}

/// Sync offline messages use case
class SyncOfflineMessagesUseCase extends UseCase<void, NoParams> {
  final EnhancedConversationRepository repository;

  SyncOfflineMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.syncOfflineMessages();
  }
}

/// Get draft use case
class GetDraftUseCase extends UseCase<String?, GetDraftParams> {
  final EnhancedConversationRepository repository;

  GetDraftUseCase(this.repository);

  @override
  Future<Either<Failure, String?>> call(GetDraftParams params) async {
    return await repository.getDraft(params.conversationId);
  }
}

/// Save draft use case
class SaveDraftUseCase extends UseCase<void, SaveDraftParams> {
  final EnhancedConversationRepository repository;

  SaveDraftUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveDraftParams params) async {
    return await repository.saveDraft(params.conversationId, params.content);
  }
}

/// Delete draft use case
class DeleteDraftUseCase extends UseCase<void, DeleteDraftParams> {
  final EnhancedConversationRepository repository;

  DeleteDraftUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteDraftParams params) async {
    return await repository.deleteDraft(params.conversationId);
  }
}

/// Get new messages stream use case
class GetNewMessagesStreamUseCase extends StreamUseCase<Message, NoParams> {
  final EnhancedConversationRepository repository;

  GetNewMessagesStreamUseCase(this.repository);

  @override
  Stream<Message> call(NoParams params) {
    return repository.newMessages;
  }
}

/// Get typing indicators stream use case
class GetTypingIndicatorsStreamUseCase extends StreamUseCase<String, NoParams> {
  final EnhancedConversationRepository repository;

  GetTypingIndicatorsStreamUseCase(this.repository);

  @override
  Stream<String> call(NoParams params) {
    return repository.typingIndicators;
  }
}

/// Get connection state stream use case
class GetConnectionStateStreamUseCase extends StreamUseCase<WebSocketConnectionState, NoParams> {
  final EnhancedConversationRepository repository;

  GetConnectionStateStreamUseCase(this.repository);

  @override
  Stream<WebSocketConnectionState> call(NoParams params) {
    return repository.connectionState;
  }
}

// Parameter classes
class GetConversationsParams extends Equatable {
  final String? currentUserId;
  final bool forceRefresh;

  const GetConversationsParams({
    this.currentUserId,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [currentUserId, forceRefresh];
}

class GetConversationsStreamParams extends Equatable {
  final String? currentUserId;

  const GetConversationsStreamParams({this.currentUserId});

  @override
  List<Object?> get props => [currentUserId];
}

class CreateConversationParams extends Equatable {
  final String otherUserId;
  final String otherUserName;
  final String? currentUserId;

  const CreateConversationParams({
    required this.otherUserId,
    required this.otherUserName,
    this.currentUserId,
  });

  @override
  List<Object?> get props => [otherUserId, otherUserName, currentUserId];
}

class GetMessagesParams extends Equatable {
  final String conversationId;
  final int page;
  final int pageSize;
  final bool forceRefresh;

  const GetMessagesParams({
    required this.conversationId,
    this.page = 1,
    this.pageSize = 50,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [conversationId, page, pageSize, forceRefresh];
}

class GetMessagesStreamParams extends Equatable {
  final String conversationId;

  const GetMessagesStreamParams({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class SendMessageParams extends Equatable {
  final String conversationId;
  final String content;
  final File? file;

  const SendMessageParams({
    required this.conversationId,
    required this.content,
    this.file,
  });

  @override
  List<Object?> get props => [conversationId, content, file];
}

class MarkMessagesAsReadParams extends Equatable {
  final String conversationId;
  final List<int> messageIds;

  const MarkMessagesAsReadParams({
    required this.conversationId,
    required this.messageIds,
  });

  @override
  List<Object?> get props => [conversationId, messageIds];
}

class EditMessageParams extends Equatable {
  final int messageId;
  final String content;

  const EditMessageParams({
    required this.messageId,
    required this.content,
  });

  @override
  List<Object?> get props => [messageId, content];
}

class DeleteMessageParams extends Equatable {
  final int messageId;

  const DeleteMessageParams({required this.messageId});

  @override
  List<Object?> get props => [messageId];
}

class TypingParams extends Equatable {
  final String conversationId;

  const TypingParams({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class JoinConversationParams extends Equatable {
  final String conversationId;

  const JoinConversationParams({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class GetDraftParams extends Equatable {
  final String conversationId;

  const GetDraftParams({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class SaveDraftParams extends Equatable {
  final String conversationId;
  final String content;

  const SaveDraftParams({
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object?> get props => [conversationId, content];
}

class DeleteDraftParams extends Equatable {
  final String conversationId;

  const DeleteDraftParams({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

/// Abstract base for stream use cases
abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}