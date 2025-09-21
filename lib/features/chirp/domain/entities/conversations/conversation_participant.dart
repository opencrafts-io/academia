import 'package:equatable/equatable.dart';

class ConversationParticipant extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String email;
  final String? avatar;
  final bool isOnline;
  final DateTime? lastSeen;
  final bool isCurrentUser;

  const ConversationParticipant({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    this.avatar,
    required this.isOnline,
    this.lastSeen,
    required this.isCurrentUser,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    email,
    avatar,
    isOnline,
    lastSeen,
    isCurrentUser,
  ];

  ConversationParticipant copyWith({
    String? id,
    String? userId,
    String? name,
    String? email,
    String? avatar,
    bool? isOnline,
    DateTime? lastSeen,
    bool? isCurrentUser,
  }) {
    return ConversationParticipant(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}
