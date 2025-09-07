import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../entities/conversations/message.dart';
import 'dart:io';

abstract class MessageRepository {
  Stream<List<Message>> getCachedMessages(String conversationId);

  Future<Either<Failure, List<Message>>> getMessages(String conversationId);
  Future<Either<Failure, Message>> sendMessage(
    String receiverId,
    String content, {
    File? file,
  });
  Future<Either<Failure, void>> markMessageAsRead(String messageId);
  Future<Either<Failure, void>> deleteMessage(String messageId);
  Future<Either<Failure, void>> markConversationAsRead(String conversationId);

  Future<Either<Failure, Stream<List<Message>>>> refreshMessages(
    String conversationId,
  );

  Future<Either<Failure, Message>> createOrUpdateMessage(Message message);
}
