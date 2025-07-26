import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/conversation.dart';

abstract class ConversationRepository {
  Future<Either<Failure, List<Conversation>>> getConversations();
}
