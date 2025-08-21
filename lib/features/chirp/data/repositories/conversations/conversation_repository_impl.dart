import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model_helper.dart';
import 'package:academia/features/chirp/data/models/chirp_user_model.dart';
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
  Stream<List<Conversation>> getCachedConversations() {
    return localDataSource
        .getConversationsStream()
        .map(
          (rawConversations) => rawConversations.map((rawConversation) async {
            // Use fallback user data for now
            final chirpUser = ChirpUser(
              id: rawConversation.userId,
              name: 'Unknown User',
              email: 'unknown@example.com',
              vibepoints: 0,
              avatarUrl: null,
            );

            final entity = Conversation(
              id: rawConversation.id,
              user: chirpUser,
              lastMessage: null,
              lastMessageAt: rawConversation.lastMessageAt,
              unreadCount: rawConversation.unreadCount,
            );

            if (rawConversation.lastMessageId != null) {
              final messageResult = await localDataSource.getMessageById(
                rawConversation.lastMessageId!,
              );
              return messageResult.fold(
                (messageFailure) => entity,
                (messageData) => messageData != null
                    ? entity.copyWith(lastMessage: messageData.toEntity())
                    : entity,
              );
            }
            return entity;
          }).toList(),
        )
        .asyncMap((futures) => Future.wait(futures));
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    // First try to get from cache
    final cachedResult = await localDataSource.getCachedConversations();

    if (cachedResult.isRight()) {
      final cachedConversations = (cachedResult as Right).value;
      if (cachedConversations.isNotEmpty) {
        // Return cached data immediately
        final conversationEntities = <Conversation>[];
        for (final data in cachedConversations) {
          _logger.d(
            'Processing conversation: ${data.id} with userId: ${data.userId}',
          );

          // Try to get cached user data first
          final userResult = await localDataSource.getCachedUser(data.userId);
          ChirpUser chirpUser;

          if (userResult.isRight()) {
            final userData = userResult.getOrElse(() => null);
            if (userData != null) {
              _logger.d('Found cached user: ${userData.name} (${userData.id})');
              chirpUser = userData.toEntity();
            } else {
              _logger.d('No cached user found, trying search cache...');
              // Try to get user data from cached search results first
              final cachedUserResult = await localDataSource
                  .getCachedUserFromSearch(data.userId);
              if (cachedUserResult.isRight()) {
                final cachedUser = cachedUserResult.getOrElse(() => null);
                if (cachedUser != null) {
                  _logger.d(
                    'Found user from search cache: ${cachedUser.name} (${cachedUser.id})',
                  );
                  chirpUser = cachedUser.toEntity();
                } else {
                  _logger.w(
                    'No user found in search cache, using unknown user',
                  );
                  // Fallback to unknown user
                  chirpUser = ChirpUser(
                    id: data.userId,
                    name: 'Unknown User',
                    email: 'unknown@example.com',
                    vibepoints: 0,
                    avatarUrl: null,
                  );
                }
              } else {
                _logger.w(
                  'Search cache failed: ${cachedUserResult.fold((l) => l.message, (r) => 'success')}',
                );
                // Fallback to unknown user
                chirpUser = ChirpUser(
                  id: data.userId,
                  name: 'Unknown User',
                  email: 'unknown@example.com',
                  vibepoints: 0,
                  avatarUrl: null,
                );
              }
            }
          } else {
            _logger.w(
              'Cached user lookup failed: ${userResult.fold((l) => l.message, (r) => 'success')}',
            );
            chirpUser = ChirpUser(
              id: data.userId,
              name: 'Unknown User',
              email: 'unknown@example.com',
              vibepoints: 0,
              avatarUrl: null,
            );
          }

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
            final finalEntity = messageResult.fold(
              (messageFailure) => entity,
              (messageData) => messageData != null
                  ? entity.copyWith(lastMessage: messageData.toEntity())
                  : entity,
            );
            conversationEntities.add(finalEntity);
          } else {
            conversationEntities.add(entity);
          }
        }
        return Right(conversationEntities.cast<Conversation>());
      }
    }

    // If no cache or cache is empty, try remote
    final conversationsResult = await remoteDataSource.getConversations();

    return await conversationsResult.fold(
      (failure) async {
        // Remote failed, try cache again
        final cachedResult = await localDataSource.getCachedConversations();
        return cachedResult.fold(
          (cacheFailure) =>
              Left(failure), // Return original failure if cache also fails
          (cachedConversations) async {
            final conversationEntities = <Conversation>[];
            for (final data in cachedConversations) {
              // Try to get cached user data first
              final userResult = await localDataSource.getCachedUser(
                data.userId,
              );
              ChirpUser chirpUser;

              if (userResult.isRight()) {
                final userData = userResult.getOrElse(() => null);
                if (userData != null) {
                  chirpUser = userData.toEntity();
                } else {
                  // Try to get user data from cached search results first
                  final cachedUserResult = await localDataSource
                      .getCachedUserFromSearch(data.userId);
                  if (cachedUserResult.isRight()) {
                    final cachedUser = cachedUserResult.getOrElse(() => null);
                    if (cachedUser != null) {
                      chirpUser = cachedUser.toEntity();
                    } else {
                      // Fallback to unknown user
                      chirpUser = ChirpUser(
                        id: data.userId,
                        name: 'Unknown User',
                        email: 'unknown@example.com',
                        vibepoints: 0,
                        avatarUrl: null,
                      );
                    }
                  } else {
                    // Fallback to unknown user
                    chirpUser = ChirpUser(
                      id: data.userId,
                      name: 'Unknown User',
                      email: 'unknown@example.com',
                      vibepoints: 0,
                      avatarUrl: null,
                    );
                  }
                }
              } else {
                // Try to get user data from cached search results first
                final cachedUserResult = await localDataSource
                    .getCachedUserFromSearch(data.userId);
                if (cachedUserResult.isRight()) {
                  final cachedUser = cachedUserResult.getOrElse(() => null);
                  if (cachedUser != null) {
                    chirpUser = cachedUser.toEntity();
                  } else {
                    // Fallback to unknown user
                    chirpUser = ChirpUser(
                      id: data.userId,
                      name: 'Unknown User',
                      email: 'unknown@example.com',
                      vibepoints: 0,
                      avatarUrl: null,
                    );
                  }
                } else {
                  // Fallback to unknown user
                  chirpUser = ChirpUser(
                    id: data.userId,
                    name: 'Unknown User',
                    email: 'unknown@example.com',
                    vibepoints: 0,
                    avatarUrl: null,
                  );
                }
              }

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
                final finalEntity = messageResult.fold(
                  (messageFailure) => entity,
                  (messageData) => messageData != null
                      ? entity.copyWith(lastMessage: messageData.toEntity())
                      : entity,
                );
                conversationEntities.add(finalEntity);
              } else {
                conversationEntities.add(entity);
              }
            }
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
            // Try to get user data from cached search results first
            final cachedUserResult = await localDataSource
                .getCachedUserFromSearch(data.userId);
            final chirpUser = cachedUserResult.fold(
              (failure) => ChirpUser(
                id: data.userId,
                name: 'Unknown User',
                email: 'unknown@example.com',
                vibepoints: 0,
                avatarUrl: null,
              ),
              (userData) => userData != null
                  ? userData.toEntity()
                  : ChirpUser(
                      id: data.userId,
                      name: 'Unknown User',
                      email: 'unknown@example.com',
                      vibepoints: 0,
                      avatarUrl: null,
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

  @override
  Future<Either<Failure, Stream<List<Conversation>>>>
  refreshConversations() async {
    final conversationsResult = await remoteDataSource.getConversations();

    return await conversationsResult.fold((failure) => Left(failure), (
      conversations,
    ) async {
      // Cache the fresh data
      final cacheResult = await localDataSource.cacheConversations(
        conversations,
      );

      if (cacheResult.isLeft()) {
        return Left((cacheResult as Left).value);
      }

      // Return the stream from cache
      return Right(
        localDataSource
            .getConversationsStream()
            .map(
              (rawConversations) => rawConversations.map((
                rawConversation,
              ) async {
                // Use fallback user data for now
                final chirpUser = ChirpUser(
                  id: rawConversation.userId,
                  name: 'Unknown User',
                  email: 'unknown@example.com',
                  vibepoints: 0,
                  avatarUrl: null,
                );

                final entity = Conversation(
                  id: rawConversation.id,
                  user: chirpUser,
                  lastMessage: null,
                  lastMessageAt: rawConversation.lastMessageAt,
                  unreadCount: rawConversation.unreadCount,
                );

                if (rawConversation.lastMessageId != null) {
                  final messageResult = await localDataSource.getMessageById(
                    rawConversation.lastMessageId!,
                  );
                  return messageResult.fold(
                    (messageFailure) => entity,
                    (messageData) => messageData != null
                        ? entity.copyWith(lastMessage: messageData.toEntity())
                        : entity,
                  );
                }
                return entity;
              }).toList(),
            )
            .asyncMap((futures) => Future.wait(futures)),
      );
    });
  }

  @override
  Future<Either<Failure, Conversation>> createConversation(
    List<String> participants,
  ) async {
    try {
      final result = await remoteDataSource.createConversation(participants);

      return await result.fold((failure) => Left(failure), (
        conversationData,
      ) async {
        // Cache the new conversation
        final cacheResult = await localDataSource.createOrUpdateConversation(
          conversationData,
        );

        cacheResult.fold(
          (cacheFailure) {
            _logger.w('Cache error: ${cacheFailure.message}');
          },
          (_) {
            // Cache successful
          },
        );

        // Get user data for the other participant
        final currentUserId = 'default_user_123'; // This should come from auth
        final otherParticipantId = participants.firstWhere(
          (participant) => participant != currentUserId,
          orElse: () => participants.first,
        );

        // Try to get user data from cache first
        final cachedUserResult = await localDataSource.getCachedUser(
          otherParticipantId,
        );
        ChirpUser chirpUser;

        if (cachedUserResult.isRight()) {
          final userData = cachedUserResult.getOrElse(() => null);
          if (userData != null) {
            _logger.d('Found cached user: ${userData.name}');
            chirpUser = userData.toEntity();
          } else {
            // Try search cache
            final searchCacheResult = await localDataSource
                .getCachedUserFromSearch(otherParticipantId);
            if (searchCacheResult.isRight()) {
              final searchUserData = searchCacheResult.getOrElse(() => null);
              if (searchUserData != null) {
                _logger.d(
                  'Found user from search cache: ${searchUserData.name}',
                );
                chirpUser = searchUserData.toEntity();
              } else {
                _logger.w('No user found in cache, using unknown user');
                chirpUser = ChirpUser(
                  id: otherParticipantId,
                  name: 'Unknown User',
                  email: 'unknown@example.com',
                  vibepoints: 0,
                  avatarUrl: null,
                );
              }
            } else {
              _logger.w('Search cache failed, using unknown user');
              chirpUser = ChirpUser(
                id: otherParticipantId,
                name: 'Unknown User',
                email: 'unknown@example.com',
                vibepoints: 0,
                avatarUrl: null,
              );
            }
          }
        } else {
          _logger.w('Cache lookup failed, using unknown user');
          chirpUser = ChirpUser(
            id: otherParticipantId,
            name: 'Unknown User',
            email: 'unknown@example.com',
            vibepoints: 0,
            avatarUrl: null,
          );
        }

        // Store the mapping between conversation ID and user ID
        await localDataSource.cacheConversationUserMapping(
          conversationData.id,
          otherParticipantId,
        );

        final conversation = Conversation(
          id: conversationData.id,
          user: chirpUser,
          lastMessage: null,
          lastMessageAt: conversationData.lastMessageAt,
          unreadCount: conversationData.unreadCount,
        );

        // Cache the user data for future use
        if (chirpUser.name != 'Unknown User') {
          final userData = chirpUser.toData();
          await localDataSource.cacheUser(userData);
        }

        return Right(conversation);
      });
    } catch (e) {
      return Left(
        ServerFailure(
          message:
              'An unexpected error occurred while creating the conversation',
          error: e,
        ),
      );
    }
  }
}
