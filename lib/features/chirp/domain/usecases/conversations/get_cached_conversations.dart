import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';

class GetCachedConversations
    implements StreamUseCase<List<Conversation>, NoParams> {
  final ConversationRepository repository;

  GetCachedConversations(this.repository);

  @override
  Stream<List<Conversation>> call(NoParams params) {
    return repository.getCachedConversations();
  }
}
