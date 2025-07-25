import 'package:academia/database/database.dart';
import 'package:drift/drift.dart';

abstract class MessagingLocalDataSource {
  Future<void> cacheConversations(List<ConversationData> conversations);
  Future<List<ConversationData>> getCachedConversations();
  Future<void> cacheMessages(String conversationId, List<MessageData> messages);
  Future<List<MessageData>> getCachedMessages(String conversationId);
}

class MessagingLocalDataSourceImpl implements MessagingLocalDataSource {
  final AppDataBase localDB;

  MessagingLocalDataSourceImpl({required this.localDB});

  @override
  Future<void> cacheConversations(List<ConversationData> conversations) async {
    await localDB.batch((batch) {
      batch.deleteWhere(
        localDB.conversationTable,
        (_) => const Constant<bool>(true),
      );
      batch.insertAll(localDB.conversationTable, conversations);
    });
  }

  @override
  Future<List<ConversationData>> getCachedConversations() async {
    return await localDB.select(localDB.conversationTable).get();
  }

  @override
  Future<void> cacheMessages(
    String conversationId,
    List<MessageData> messages,
  ) async {
    await localDB.batch((batch) {
      batch.deleteWhere(
        localDB.messageTable,
        (tbl) => Expression.or([
          tbl.senderId.equals(conversationId),
          tbl.recipientId.equals(conversationId),
        ]),
      );
      batch.insertAll(localDB.messageTable, messages);
    });
  }

  @override
  Future<List<MessageData>> getCachedMessages(String conversationId) async {
    return await (localDB.select(localDB.messageTable)..where(
          (tbl) => Expression.or([
            tbl.senderId.equals(conversationId),
            tbl.recipientId.equals(conversationId),
          ]),
        ))
        .get();
  }
}
