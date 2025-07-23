import 'package:academia/database/database.dart';

abstract class MessagingLocalDataSource {
  Future<void> cacheConversations(List<ConversationData> conversations);
  Future<List<ConversationData>> getCachedConversations();
  Future<void> cacheMessages(String conversationId, List<MessageData> messages);
  Future<List<MessageData>> getCachedMessages(String conversationId);
}

class MessagingLocalDataSourceImpl implements MessagingLocalDataSource {
  @override
  Future<void> cacheConversations(List<ConversationData> conversations) async {
    // Implement caching logic here
  }

  @override
  Future<List<ConversationData>> getCachedConversations() async {
    return [];
  }

  @override
  Future<void> cacheMessages(
    String conversationId,
    List<MessageData> messages,
  ) async {
    // Implement caching logic here
  }

  @override
  Future<List<MessageData>> getCachedMessages(String conversationId) async {
    return [];
  }
}
