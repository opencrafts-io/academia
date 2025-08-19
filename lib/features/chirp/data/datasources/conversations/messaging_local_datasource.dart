import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

abstract class MessagingLocalDataSource {
  // Stream-based methods for real-time updates
  Stream<List<ConversationData>> getConversationsStream();
  Stream<List<MessageData>> getMessagesStream(String conversationId);

  // Cache management methods
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

  // Cache update methods
  Future<Either<Failure, ConversationData>> createOrUpdateConversation(
    ConversationData conversation,
  );
  Future<Either<Failure, MessageData>> createOrUpdateMessage(
    MessageData message,
  );
  Future<Either<Failure, void>> deleteConversation(String conversationId);
  Future<Either<Failure, void>> deleteMessage(String messageId);

  // Cache invalidation
  Future<Either<Failure, void>> clearConversationsCache();
  Future<Either<Failure, void>> clearMessagesCache(String conversationId);
}

class MessagingLocalDataSourceImpl implements MessagingLocalDataSource {
  final AppDataBase localDB;

  MessagingLocalDataSourceImpl({required this.localDB});

  @override
  Stream<List<ConversationData>> getConversationsStream() {
    return (localDB.select(localDB.conversationTable)..orderBy([
          (conversation) => OrderingTerm(
            expression: conversation.updatedAt,
            mode: OrderingMode.desc,
          ),
        ]))
        .watch();
  }

  @override
  Stream<List<MessageData>> getMessagesStream(String conversationId) {
    // Extract user ID from conversation ID (conv_userId -> userId)
    final userId = conversationId.replaceAll('conv_', '');

    return (localDB.select(localDB.messageTable)
          ..where(
            (message) =>
                message.senderId.equals(userId) |
                message.recipientId.equals(userId),
          )
          ..orderBy([
            (message) => OrderingTerm(
              expression: message.sentAt,
              mode: OrderingMode.asc,
            ),
          ]))
        .watch();
  }

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
        if (conversations.isNotEmpty) {
          batch.insertAll(localDB.conversationTable, conversations);
        }
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
      final conversations =
          await (localDB.select(localDB.conversationTable)..orderBy([
                (conversation) => OrderingTerm(
                  expression: conversation.updatedAt,
                  mode: OrderingMode.desc,
                ),
              ]))
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
      // Extract user ID from conversation ID (conv_userId -> userId)
      final userId = conversationId.replaceAll('conv_', '');

      await localDB.batch((batch) {
        // Delete messages for this specific conversation (between current user and target user)
        batch.deleteWhere(
          localDB.messageTable,
          (message) =>
              message.senderId.equals(userId) |
              message.recipientId.equals(userId),
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
      // Extract user ID from conversation ID (conv_userId -> userId)
      final userId = conversationId.replaceAll('conv_', '');

      final messages =
          await (localDB.select(localDB.messageTable)
                ..where(
                  (message) =>
                      message.senderId.equals(userId) |
                      message.recipientId.equals(userId),
                )
                ..orderBy([
                  (message) => OrderingTerm(
                    expression: message.sentAt,
                    mode: OrderingMode.asc,
                  ),
                ]))
              .get();
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

  @override
  Future<Either<Failure, ConversationData>> createOrUpdateConversation(
    ConversationData conversation,
  ) async {
    try {
      final created = await localDB
          .into(localDB.conversationTable)
          .insertReturning(
            conversation,
            onConflict: DoUpdate((t) => conversation),
          );
      return Right(created);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't save the conversation to your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MessageData>> createOrUpdateMessage(
    MessageData message,
  ) async {
    try {
      final created = await localDB
          .into(localDB.messageTable)
          .insertReturning(message, onConflict: DoUpdate((t) => message));
      return Right(created);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't save the message to your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteConversation(
    String conversationId,
  ) async {
    try {
      await (localDB.delete(
        localDB.conversationTable,
      )..where((t) => t.id.equals(conversationId))).go();
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't delete the conversation from your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      await (localDB.delete(
        localDB.messageTable,
      )..where((t) => t.id.equals(messageId))).go();
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "We couldn't delete the message from your device. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearConversationsCache() async {
    try {
      await (localDB.delete(localDB.conversationTable)).go();
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message: "We couldn't clear conversations cache. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearMessagesCache(
    String conversationId,
  ) async {
    try {
      // Extract user ID from conversation ID (conv_userId -> userId)
      final userId = conversationId.replaceAll('conv_', '');

      await (localDB.delete(localDB.messageTable)..where(
            (message) =>
                message.senderId.equals(userId) |
                message.recipientId.equals(userId),
          ))
          .go();
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message: "We couldn't clear messages cache. Please try again.",
        ),
      );
    }
  }
}
