import 'package:academia/core/core.dart';
import '../repository/message_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/message.dart';

class SendMessage implements UseCase<Message, SendMessageParams> {
  final MessageRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    final receiverId = params.receiverId;
    final content = params.content;

    return await repository.sendMessage(receiverId, content);
  }
}
