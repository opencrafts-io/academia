import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

abstract class MessagingLocalDataSource {
  Future<Either<Failure, void>> cacheConversations(
    List<ConversationData> conversations,
  );
  Future<Either<Failure, List<ConversationData>>> getCachedConversations();
  Future<Either<Failure, void>> cacheMessages(
    String conversationId,
    List<MessageData> messages,
  );
  Future<Either<Failure, List<MessageData>>> getCachedMessages(
    String conversationId,
  );
  Future<Either<Failure, MessageData?>> getMessageById(String messageId);
}

class MessagingLocalDataSourceImpl implements MessagingLocalDataSource {
  final AppDataBase localDB;

  MessagingLocalDataSourceImpl({required this.localDB});

  @override
  Future<Either<Failure, void>> cacheConversations(
    List<ConversationData> conversations,
  ) async {
    try {
      await localDB.batch((batch) {
        batch.deleteWhere(
          localDB.conversationTable,
          (_) => const Constant<bool>(true),
        );
        batch.insertAll(localDB.conversationTable, conversations);
      });
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't save conversations to your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ConversationData>>>
  getCachedConversations() async {
    try {
      final conversations = await localDB
          .select(localDB.conversationTable)
          .get();
      return Right(conversations);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't load conversations from your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cacheMessages(
    String conversationId,
    List<MessageData> messages,
  ) async {
    try {
      await localDB.batch((batch) {
        batch.deleteWhere(
          localDB.messageTable,
          (_) => const Constant<bool>(true),
        );

        if (messages.isNotEmpty) {
          batch.insertAll(localDB.messageTable, messages);
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't save messages to your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MessageData>>> getCachedMessages(
    String conversationId,
  ) async {
    try {
      final messages = await localDB.select(localDB.messageTable).get();
      return Right(messages);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't load messages from your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MessageData?>> getMessageById(String messageId) async {
    try {
      final message = await (localDB.select(
        localDB.messageTable,
      )..where((tbl) => tbl.id.equals(messageId))).getSingleOrNull();
      return Right(message);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't find the message on your device. Please try again.",
        ),
      );
    }
  }
}
