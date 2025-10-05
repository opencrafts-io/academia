class CommunityUserModel{
  final String userId;
  final String userName;
  final String role;

  const CommunityUserModel({
    required this.userId,
    required this.userName,
    required this.role,
  });

  factory CommunityUserModel.fromJson(Map<String, dynamic> json) {
    return CommunityUserModel(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      role: json['role'] as String,
    );
  }
}