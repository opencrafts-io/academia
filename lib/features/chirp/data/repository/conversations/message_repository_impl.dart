import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model_helper.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/repository/conversations/message_repository.dart';
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
      final messages = await remoteDataSource.getMessages(conversationId);
      await localDataSource.cacheMessages(conversationId, messages);
      return Right(messages.map((data) => data.toEntity()).toList());
    } catch (e) {
      try {
        final cachedMessages = await localDataSource.getCachedMessages(
          conversationId,
        );
        return Right(cachedMessages.map((data) => data.toEntity()).toList());
      } catch (cacheError) {
        return Left(
          ServerFailure(
            message: 'Failed to fetch messages from cache',
            error: cacheError,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
    String receiverId,
    String content,
  ) async {
    try {
      final message = await remoteDataSource.sendMessage(receiverId, content);
      return Right(message.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to send message', error: e));
    }
  }
}
