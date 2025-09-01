//temporary solution for now
class CommunityModel {
  final int id;
  final String name;
  final String description;
  final String creatorId;
  final String creatorName;
  final List<String> moderators;
  final List<String> moderatorNames;
  final List<String> members;
  final List<String> memberNames;
  final List<String> bannedUsers;
  final List<String> bannedUserNames;
  final bool isPrivate;
  final List<String> rules;
  final String? logo;
  final String? banner;
  final String? logoUrl;
  final String? bannerUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userRole;
  final bool canPost;
  final bool canModerate;

  CommunityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.moderators,
    required this.moderatorNames,
    required this.members,
    required this.memberNames,
    required this.bannedUsers,
    required this.bannedUserNames,
    required this.isPrivate,
    required this.rules,
    this.logo,
    this.banner,
    this.logoUrl,
    this.bannerUrl,
    required this.createdAt,
    required this.updatedAt,
    this.userRole,
    required this.canPost,
    required this.canModerate,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      creatorId: json['creator_id'],
      creatorName: json['creator_name'],
      moderators: List<String>.from(json['moderators']),
      moderatorNames: List<String>.from(json['moderator_names']),
      members: List<String>.from(json['members']),
      memberNames: List<String>.from(json['member_names']),
      bannedUsers: List<String>.from(json['banned_users']),
      bannedUserNames: List<String>.from(json['banned_user_names']),
      isPrivate: json['is_private'],
      rules: List<String>.from(json['rules']),
      logo: json['logo'],
      banner: json['banner'],
      logoUrl: json['logo_url'],
      bannerUrl: json['banner_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userRole: json['user_role'],
      canPost: json['can_post'],
      canModerate: json['can_moderate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "creator_id": creatorId,
      "creator_name": creatorName,
      "moderators": moderators,
      "moderator_names": moderatorNames,
      "members": members,
      "member_names": memberNames,
      "banned_users": bannedUsers,
      "banned_user_names": bannedUserNames,
      "is_private": isPrivate,
      "rules": rules,
      "logo": logo,
      "banner": banner,
      "logo_url": logoUrl,
      "banner_url": bannerUrl,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "user_role": userRole,
      "can_post": canPost,
      "can_moderate": canModerate,
    };
  }
}
