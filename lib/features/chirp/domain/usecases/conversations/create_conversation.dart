import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/conversation.dart';
import '../../repositories/conversations/conversation_repository.dart';

class CreateConversationParams {
  final List<String> participants;

  const CreateConversationParams({required this.participants});
}

class CreateConversation
    implements UseCase<Conversation, CreateConversationParams> {
  final ConversationRepository repository;

  CreateConversation(this.repository);

  @override
  Future<Either<Failure, Conversation>> call(
    CreateConversationParams params,
  ) async {
    return await repository.createConversation(params.participants);
  }
}


