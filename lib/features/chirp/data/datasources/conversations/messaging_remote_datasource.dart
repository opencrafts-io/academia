import 'package:academia/core/network/dio_client.dart';
import 'package:academia/database/database.dart';

abstract class MessagingRemoteDatasource {
  Future<List<ConversationData>> getConversations();
  Future<List<MessageData>> getMessages(String conversationId);
  Future<MessageData> sendMessage(String receiverId, String content);
}

class MessagingRemoteDatasourceImpl implements MessagingRemoteDatasource {
  final DioClient dioClient;

  MessagingRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<List<ConversationData>> getConversations() async {
    final response = await dioClient.dio.get('/conversations/');
    return (response.data as List)
        .map((json) => ConversationData.fromJson(json))
        .toList();
  }

  @override
  Future<List<MessageData>> getMessages(String conversationId) async {
    final response = await dioClient.dio.get(
      '/conversations/$conversationId/messages/',
    );
    return (response.data as List)
        .map((json) => MessageData.fromJson(json))
        .toList();
  }

  @override
  Future<MessageData> sendMessage(String receiverId, String content) async {
    final response = await dioClient.dio.post(
      '/messages/',
      data: {'receiver_id': receiverId, 'content': content},
    );
    return MessageData.fromJson(response.data);
  }
}
