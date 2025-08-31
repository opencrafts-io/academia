import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/conversation.dart';

abstract class ConversationRepository {
  Stream<List<Conversation>> getCachedConversations();

  Future<Either<Failure, List<Conversation>>> getConversations();

  Future<Either<Failure, Stream<List<Conversation>>>> refreshConversations();

  Future<Either<Failure, Conversation>> createConversation(
    List<String> participants,
  );
}
