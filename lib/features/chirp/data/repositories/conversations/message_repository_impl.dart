import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model_helper.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/repositories/conversations/message_repository.dart';
import '../../datasources/conversations/messaging_remote_datasource.dart';
import '../../datasources/conversations/messaging_local_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagingRemoteDatasource remoteDataSource;
  final MessagingLocalDataSource localDataSource;

  MessageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Message>>> getMessages(
    String conversationId,
  ) async {
    try {
      final messagesResult = await remoteDataSource.getMessages(conversationId);

      return await messagesResult.fold(
        (failure) async {
          // TODO: Uncomment
          // // Remote failed, try cache
          // try {
          //   final cachedMessages = await localDataSource.getCachedMessages(
          //     conversationId,
          //   );
          //   return Right(
          //     cachedMessages.map((data) => data.toEntity()).toList(),
          //   );
          // } catch (cacheError) {
          //   return Left(failure); // Return original failure if cache also fails
          // }
          return Left(failure);
        },
        (messages) async {
          // TODO: Uncomment
          // // Remote succeeded, cache the data
          // try {
          //   await localDataSource.cacheMessages(conversationId, messages);
          // } catch (cacheError) {
          //   // Log cache error but continue
          //   print('Cache error: $cacheError');
          // }
          return Right(messages.map((data) => data.toEntity()).toList());
        },
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while fetching messages',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
    String receiverId,
    String content,
  ) async {
    try {
      final messageResult = await remoteDataSource.sendMessage(
        receiverId,
        content,
      );

      return messageResult.fold(
        (failure) => Left(failure),
        (message) => Right(message.toEntity()),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while sending message',
          error: e,
        ),
      );
    }
  }
}
