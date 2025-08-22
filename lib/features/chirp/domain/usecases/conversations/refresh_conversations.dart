import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class RefreshConversations
    implements UseCase<Stream<List<Conversation>>, NoParams> {
  final ConversationRepository repository;

  RefreshConversations(this.repository);

  @override
  Future<Either<Failure, Stream<List<Conversation>>>> call(NoParams params) {
    return repository.refreshConversations();
  }
}
