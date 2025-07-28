import 'package:academia/core/core.dart';
import '../../repositories/conversations/message_repository.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/message.dart';

class SendMessage implements UseCase<Message, Map<String, String>> {
  final MessageRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(Map<String, String> params) async {
    final receiverId = params['receiverId'];
    final content = params['content'];

    if (receiverId == null || content == null) {
      return Left(
        ServerFailure(
          error: Exception('receiverId and content must not be null'),
          message: 'receiverId and content must not be null',
        ),
      );
    }

    return await repository.sendMessage(receiverId, content);
  }
}
