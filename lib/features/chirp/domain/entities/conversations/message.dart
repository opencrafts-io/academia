import 'package:equatable/equatable.dart';
import '../chirp_user.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final ChirpUser sender;
  final ChirpUser recipient;
  final DateTime sentAt;
  final bool isRead;
  final String? imageUrl;

  const Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.recipient,
    required this.sentAt,
    this.isRead = false,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, content, recipient, sentAt, isRead, imageUrl];

  @override
  bool? get stringify => true;
}

class SendMessageParams {
  final String receiverId;
  final String content;

  SendMessageParams({required this.receiverId, required this.content});
}
