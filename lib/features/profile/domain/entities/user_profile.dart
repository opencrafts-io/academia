import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String? username;
  final String email;
  final bool termsAccepted;
  final bool onboarded;
  final String nationalID;
  final String? avatarUrl;
  final String? bio;
  final int vibePoints;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.termsAccepted,
    required this.onboarded,
    required this.createdAt,
    required this.updatedAt,
    required this.bio,
    required this.phone,
    required this.username,
    required this.nationalID,
    required this.vibePoints,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    nationalID,
    name,
    email,
    termsAccepted,
    onboarded,
    avatarUrl,
    bio,
    vibePoints,
    phone,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}
