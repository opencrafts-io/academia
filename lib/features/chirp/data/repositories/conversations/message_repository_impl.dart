import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model_helper.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/repositories/conversations/message_repository.dart';
import '../../datasources/conversations/messaging_remote_datasource.dart';
import '../../datasources/conversations/messaging_local_datasource.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagingRemoteDatasource remoteDataSource;
  final MessagingLocalDataSource localDataSource;

  MessageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<List<Message>> getCachedMessages(String conversationId) {
    return localDataSource
        .getMessagesStream(conversationId)
        .map(
          (rawMessages) =>
              rawMessages.map((rawMessage) => rawMessage.toEntity()).toList(),
        );
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(
    String conversationId,
  ) async {
    final cachedResult = await localDataSource.getCachedMessages(
      conversationId,
    );

    if (cachedResult.isRight()) {
      final cachedMessages = (cachedResult as Right).value;
      if (cachedMessages.isNotEmpty) {
        return Right(cachedMessages.map((data) => data.toEntity()).toList());
      }
    }

    // If no cache or cache is empty, try remote
    final messagesResult = await remoteDataSource.getMessages(conversationId);

    return await messagesResult.fold(
      (failure) async {
        // Remote failed, try cache
        final cachedResult = await localDataSource.getCachedMessages(
          conversationId,
        );
        return cachedResult.fold(
          (cacheFailure) =>
              Left(failure), // Return original failure if cache also fails
          (cachedMessages) =>
              Right(cachedMessages.map((data) => data.toEntity()).toList()),
        );
      },
      (messages) async {
        // Remote succeeded, cache the data
        final cacheResult = await localDataSource.cacheMessages(
          conversationId,
          messages,
        );
        cacheResult.fold(
          (cacheFailure) {
            // Log cache error but continue - don't fail the operation
            debugPrint('Cache error: ${cacheFailure.message}');
          },
          (_) {
            // Cache successful
          },
        );
        return Right(messages.map((data) => data.toEntity()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
    String receiverId,
    String content, {
    File? file,
  }) async {
    final messageResult = await remoteDataSource.sendMessage(
      receiverId,
      content,
      file: file,
    );

    return messageResult.fold((failure) => Left(failure), (message) async {
      final cacheResult = await localDataSource.createOrUpdateMessage(message);
      cacheResult.fold((cacheFailure) {
        debugPrint('Cache error: ${cacheFailure.message}');
      }, (_) {});
      return Right(message.toEntity());
    });
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(String messageId) async {
    return await remoteDataSource.markMessageAsRead(messageId);
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    final result = await remoteDataSource.deleteMessage(messageId);

    return result.fold((failure) => Left(failure), (_) async {
      final cacheResult = await localDataSource.deleteMessage(messageId);
      return cacheResult.fold((cacheFailure) {
        debugPrint('Cache error: ${cacheFailure.message}');
        return const Right(null);
      }, (_) => const Right(null));
    });
  }

  @override
  Future<Either<Failure, Stream<List<Message>>>> refreshMessages(
    String conversationId,
  ) async {
    final messagesResult = await remoteDataSource.getMessages(conversationId);

    return await messagesResult.fold((failure) => Left(failure), (
      messages,
    ) async {
      final cacheResult = await localDataSource.cacheMessages(
        conversationId,
        messages,
      );

      if (cacheResult.isLeft()) {
        return Left((cacheResult as Left).value);
      }

      return Right(
        localDataSource
            .getMessagesStream(conversationId)
            .map(
              (rawMessages) => rawMessages
                  .map((rawMessage) => rawMessage.toEntity())
                  .toList(),
            ),
      );
    });
  }

  @override
  Future<Either<Failure, void>> markConversationAsRead(
    String conversationId,
  ) async {
    return await remoteDataSource.markConversationAsRead(conversationId);
  }

  @override
  Future<Either<Failure, Message>> createOrUpdateMessage(
    Message message,
  ) async {
    final messageData = message.toData();
    final result = await localDataSource.createOrUpdateMessage(messageData);

    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.toEntity()),
    );
  }
}
