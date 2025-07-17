import 'package:equatable/equatable.dart';
import 'user.dart';

class Message extends Equatable {
  final String id;
  final User sender;
  final String content;
  final User recipient;
  final DateTime sentAt;
  final bool isRead;

  const Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.recipient,
    required this.sentAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, sender, content, recipient, sentAt, isRead];

  @override
  bool? get stringify => true;
}

class SendMessageParams {
  final String receiverId;
  final String content;

  SendMessageParams({required this.receiverId, required this.content});
}
