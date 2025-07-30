import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> getMessages(String conversationId);
  Future<Either<Failure, Message>> sendMessage(
    String receiverId,
    String content, {
    String? imagePath,
  });
  Future<Either<Failure, void>> markMessageAsRead(String messageId);
  Future<Either<Failure, void>> deleteMessage(String messageId);
}
