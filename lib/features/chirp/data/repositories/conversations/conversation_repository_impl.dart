import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../domain/repositories/conversations/conversation_repository.dart';
import '../../datasources/conversations/messaging_remote_datasource.dart';
import '../../datasources/conversations/messaging_local_datasource.dart';
import '../../datasources/chirp_user_remote_datasource.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final MessagingRemoteDatasource remoteDataSource;
  final MessagingLocalDataSource localDataSource;
  final ChirpUserRemoteDatasource chirpUserRemoteDataSource;
  final Logger _logger = Logger();

  ConversationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.chirpUserRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final conversationsResult = await remoteDataSource.getConversations();

      return await conversationsResult.fold(
        (failure) async {
          try {
            final cachedConversations = await localDataSource
                .getCachedConversations();
            final conversationEntities = await Future.wait(
              cachedConversations.map((data) async {
                // For cached conversations, use fallback user data
                final chirpUser = ChirpUser(
                  id: data.userId,
                  name: 'Unknown User',
                  email: 'unknown@example.com',
                  vibepoints: 0,
                  avatarUrl: null,
                );

                final entity = Conversation(
                  id: data.id,
                  user: chirpUser,
                  lastMessage: null,
                  lastMessageAt: data.lastMessageAt,
                  unreadCount: data.unreadCount,
                );

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
          try {
            await localDataSource.cacheConversations(conversations);
          } catch (cacheError) {
            // Log cache error but continue
            _logger.w('Cache error: $cacheError');
          }

          final conversationEntities = await Future.wait(
            conversations.map((data) async {
              // Get real user data from backend, with fallback
              final chirpUserResult = await chirpUserRemoteDataSource
                  .getChirpUserById(data.userId);
              final chirpUser = chirpUserResult.fold(
                (failure) => ChirpUser(
                  id: data.userId,
                  name: 'Unknown User',
                  email: 'unknown@example.com',
                  vibepoints: 0,
                  avatarUrl: null,
                ),
                (userData) => ChirpUser(
                  id: userData.id,
                  name: userData.name,
                  email: userData.email,
                  vibepoints: userData.vibepoints,
                  avatarUrl: userData.avatarUrl,
                ),
              );

              // Create conversation entity with real user data
              final entity = Conversation(
                id: data.id,
                user: chirpUser,
                lastMessage: null,
                lastMessageAt: data.lastMessageAt,
                unreadCount: data.unreadCount,
              );

              if (data.lastMessageId != null) {
                try {
                  final messageData = await localDataSource.getMessageById(
                    data.lastMessageId!,
                  );
                  if (messageData != null) {
                    final actualMessage = messageData.toEntity();
                    return entity.copyWith(lastMessage: actualMessage);
                  }
                } catch (messageError) {
                  // Log message fetch error but continue
                  _logger.w('Message fetch error: $messageError');
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
