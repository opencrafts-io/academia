import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repository/conversation_repository.dart';
import '../datasources/messaging_remote_datasource.dart';
import '../datasources/messaging_local_datasource.dart';
import '../models/conversation_model_helper.dart';

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
      return Right(conversations.map((data) => data.toEntity()).toList());
    } catch (e) {
      try {
        final cachedConversations = await localDataSource
            .getCachedConversations();
        return Right(
          cachedConversations.map((data) => data.toEntity()).toList(),
        );
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
