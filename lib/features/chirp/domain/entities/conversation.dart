import 'package:equatable/equatable.dart';
import 'message.dart';
import 'user.dart';

class Conversation extends Equatable {
  final String id;
  final User user;
  final Message? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.user,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    lastMessage,
    lastMessageAt,
    unreadCount,
  ];

  @override
  bool? get stringify => true;
}
