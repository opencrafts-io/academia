import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/conversation_model_helper.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../domain/repositories/conversations/conversation_repository.dart';
import '../../datasources/conversations/messaging_remote_datasource.dart';
import '../../datasources/conversations/messaging_local_datasource.dart';

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
          // TODO: Uncomment
          // // try cache
          // try {
          //   final cachedConversations = await localDataSource
          //       .getCachedConversations();
          //   final conversationEntities = await Future.wait(
          //     cachedConversations.map((data) async {
          //       final entity = data.toEntity();
          //       if (data.lastMessageId != null) {
          //         final messageData = await localDataSource.getMessageById(
          //           data.lastMessageId!,
          //         );
          //         if (messageData != null) {
          //           final actualMessage = messageData.toEntity();
          //           return entity.copyWith(lastMessage: actualMessage);
          //         }
          //       }
          //       return entity;
          //     }),
          //   );
          //   return Right(conversationEntities);
          // } catch (cacheError) {
          //   return Left(failure);
          // }
          return Left(failure);
        },
        (conversations) async {
          // TODO: Uncomment
          // // cache the data
          // try {
          //   await localDataSource.cacheConversations(conversations);
          // } catch (cacheError) {
          //   // Log cache error but continue
          //   print('Cache error: $cacheError');
          // }

          final conversationEntities = await Future.wait(
            conversations.map((data) async {
              final entity = data.toEntity();
              final chirpUser = _getDummyChirpUser(data.userId);

              // TODO: Uncomment
              // if (data.lastMessageId != null) {
              //   try {
              //     final messageData = await localDataSource.getMessageById(
              //       data.lastMessageId!,
              //     );
              //     if (messageData != null) {
              //       final actualMessage = messageData.toEntity();
              //       return entity.copyWith(
              //         user: chirpUser,
              //         lastMessage: actualMessage,
              //       );
              //     }
              //   } catch (messageError) {
              //     // Log message fetch error but continue
              //     print('Message fetch error: $messageError');
              //   }
              // }
              return entity.copyWith(user: chirpUser);
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

  // TODO: Remove
  ChirpUser _getDummyChirpUser(String userId) {
    switch (userId) {
      case 'user_1':
        return ChirpUser(
          id: 'user_1',
          name: 'Sarah Johnson',
          email: 'sarah.johnson@example.com',
          vibepoints: 150,
          avatarUrl: null,
        );
      case 'user_2':
        return ChirpUser(
          id: 'user_2',
          name: 'Alex Chen',
          email: 'alex.chen@example.com',
          vibepoints: 89,
          avatarUrl: null,
        );
      default:
        return ChirpUser(
          id: 'unknown',
          name: 'Unknown User',
          email: 'unknown@example.com',
          vibepoints: 0,
          avatarUrl: null,
        );
    }
  }
}
