import 'package:equatable/equatable.dart';

class ChirpUser extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final int vibepoints;
  final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ChirpUser({
    required this.id,
    required this.name,
    required this.email,
    this.username = "",
    this.vibepoints = 0,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    vibepoints,
    avatarUrl,
    createdAt,
    updatedAt,
    username,
  ];

  @override
  bool? get stringify => true;

  ChirpUser copyWith({
    String? id,
    String? name,
    String? email,
    int? vibepoints,
    String? avatarUrl,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChirpUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      vibepoints: vibepoints ?? this.vibepoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
