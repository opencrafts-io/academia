import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';

class GetCachedMessages implements StreamUseCase<List<Message>, String> {
  final MessageRepository repository;

  GetCachedMessages(this.repository);

  @override
  Stream<List<Message>> call(String conversationId) {
    return repository.getCachedMessages(conversationId);
  }
}
