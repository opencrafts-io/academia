import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/conversation.dart';
import '../../repository/conversations/conversation_repository.dart';

class GetConversations implements UseCase<List<Conversation>, NoParams> {
  final ConversationRepository repository;

  GetConversations(this.repository);

  @override
  Future<Either<Failure, List<Conversation>>> call(NoParams params) async {
    return await repository.getConversations();
  }
}
