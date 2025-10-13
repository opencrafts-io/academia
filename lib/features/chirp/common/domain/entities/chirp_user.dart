// ChirpUser
// Represents a chirp user information
class ChirpUser {
  final String userID;
  final String? email;
  final String? phone;
  final String? username;
  final int vibePoints;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChirpUser({
    required this.userID,
    this.email,
    this.phone,
    this.username,
    this.vibePoints = 0,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // CopyWith method
  ChirpUser copyWith({
    String? userID,
    String? email,
    String? phone,
    String? username,
    int? vibePoints,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChirpUser(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      vibePoints: vibePoints ?? this.vibePoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // For easy JSON serialization/deserialization
  factory ChirpUser.fromJson(Map<String, dynamic> json) {
    return ChirpUser(
      userID: json['user_id'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      vibePoints: json['vibe_points'] ?? 0,
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userID,
      'email': email,
      'phone': phone,
      'username': username,
      'vibe_points': vibePoints,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
