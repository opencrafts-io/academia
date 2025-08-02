import 'package:academia/core/core.dart';
import '../../repositories/conversations/message_repository.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/message.dart';
import 'dart:io';

class SendMessage implements UseCase<Message, Map<String, dynamic>> {
  final MessageRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(Map<String, dynamic> params) async {
    final receiverId = params['receiverId'] as String?;
    final content = params['content'] as String?;
    final file = params['file'] as File?;

    if (receiverId == null || content == null) {
      return Left(
        ServerFailure(
          error: Exception('receiverId and content must not be null'),
          message: 'receiverId and content must not be null',
        ),
      );
    }

    return await repository.sendMessage(receiverId, content, file: file);
  }
}
