import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class RefreshMessages implements UseCase<Stream<List<Message>>, String> {
  final MessageRepository repository;

  RefreshMessages(this.repository);

  @override
  Future<Either<Failure, Stream<List<Message>>>> call(String conversationId) {
    return repository.refreshMessages(conversationId);
  }
}
