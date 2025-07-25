import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/repository/conversations/conversation_repository.dart';
import '../../datasources/conversations/messaging_remote_datasource.dart';
import '../../datasources/conversations/messaging_local_datasource.dart';
import '../../models/conversations/conversation_model_helper.dart';
import '../../models/conversations/message_model_helper.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final MessagingRemoteDatasource remoteDataSource;
  final MessagingLocalDataSource localDataSource;

  ConversationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final conversations = await remoteDataSource.getConversations();
      await localDataSource.cacheConversations(conversations);

      // fetch actual last messages
      final conversationEntities = await Future.wait(
        conversations.map((data) async {
          final entity = data.toEntity();
          if (data.lastMessageId != null) {
            final messageData = await localDataSource.getMessageById(
              data.lastMessageId!,
            );
            if (messageData != null) {
              final actualMessage = messageData.toEntity();
              return entity.copyWith(lastMessage: actualMessage);
            }
          }
          return entity;
        }),
      );

      return Right(conversationEntities);
    } catch (e) {
      try {
        final cachedConversations = await localDataSource
            .getCachedConversations();

        // fetch actual last messages from cache
        final conversationEntities = await Future.wait(
          cachedConversations.map((data) async {
            final entity = data.toEntity();
            if (data.lastMessageId != null) {
              final messageData = await localDataSource.getMessageById(
                data.lastMessageId!,
              );
              if (messageData != null) {
                final actualMessage = messageData.toEntity();
                return entity.copyWith(lastMessage: actualMessage);
              }
            }
            return entity;
          }),
        );

        return Right(conversationEntities);
      } catch (cacheError) {
        return Left(
          ServerFailure(
            message: 'Failed to fetch conversations from cache',
            error: cacheError,
          ),
        );
      }
    }
  }
}
