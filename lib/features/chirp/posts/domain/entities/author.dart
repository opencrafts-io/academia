import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String username;
  final String? avatarUrl;
  final int vibePoints;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Author({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
    this.avatarUrl,
    required this.vibePoints,
    required this.createdAt,
    required this.updatedAt,
  });

  Author copyWith({
     String? userId,
   String? name,
   String? email,
   String? phone,
   String? username,
   String? avatarUrl,
   int? vibePoints,
   DateTime? createdAt,
   DateTime? updatedAt,
  }) {
    return Author(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      vibePoints: vibePoints ?? this.vibePoints,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    name,
    email,
    phone,
    username,
    avatarUrl,
    vibePoints,
    createdAt,
    updatedAt,
  ];
}
