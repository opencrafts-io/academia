import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/repositories/conversations/conversation_repository.dart';
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
      final conversationsResult = await remoteDataSource.getConversations();

      return await conversationsResult.fold(
        (failure) async {
          // try cache
          try {
            final cachedConversations = await localDataSource
                .getCachedConversations();
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
            return Left(failure);
          }
        },
        (conversations) async {
          // cache the data
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
        },
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while fetching conversations',
          error: e,
        ),
      );
    }
  }
}
