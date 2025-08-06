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
    final conversationsResult = await remoteDataSource.getConversations();

    return await conversationsResult.fold(
      (failure) async {
        // Remote failed, try cache
        final cachedResult = await localDataSource.getCachedConversations();
        return cachedResult.fold(
          (cacheFailure) =>
              Left(failure), // Return original failure if cache also fails
          (cachedConversations) async {
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
                  final messageResult = await localDataSource.getMessageById(
                    data.lastMessageId!,
                  );
                  return messageResult.fold(
                    (messageFailure) => entity,
                    (messageData) => messageData != null
                        ? entity.copyWith(lastMessage: messageData.toEntity())
                        : entity,
                  );
                }
                return entity;
              }),
            );
            return Right(conversationEntities);
          },
        );
      },
      (conversations) async {
        // Remote succeeded, cache the data
        final cacheResult = await localDataSource.cacheConversations(
          conversations,
        );
        cacheResult.fold(
          (cacheFailure) {
            // Log cache error but continue - don't fail the operation
            _logger.w('Cache error: ${cacheFailure.message}');
          },
          (_) {
            // Cache successful
          },
        );

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
              final messageResult = await localDataSource.getMessageById(
                data.lastMessageId!,
              );
              return messageResult.fold(
                (messageFailure) {
                  // Log message fetch error but continue
                  _logger.w('Message fetch error: ${messageFailure.message}');
                  return entity;
                },
                (messageData) => messageData != null
                    ? entity.copyWith(lastMessage: messageData.toEntity())
                    : entity,
              );
            }
            return entity;
          }),
        );

        return Right(conversationEntities);
      },
    );
  }
}
