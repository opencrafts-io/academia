import 'package:academia/core/core.dart';
import '../../repositories/conversations/message_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteMessage implements UseCase<void, String> {
  final MessageRepository repository;

  DeleteMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(String messageId) async {
    if (messageId.isEmpty) {
      return Left(
        ServerFailure(
          error: Exception('messageId must not be empty'),
          message: 'messageId must not be empty',
        ),
      );
    }

    return await repository.deleteMessage(messageId);
  }
}
