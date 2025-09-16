class Group {
  final String id;
  final String name;
  final String? description;
  final String? creatorId;
  final String? creatorName;
  final List<String>? admins;
  final List<String>? adminNames;
  final List<String>? moderators;
  final List<String>? moderatorNames;
  final List<String>? members;
  final List<String>? memberNames;
  final List<String>? bannedUsers;
  final List<String>? bannedUserNames;
  final bool? isPrivate;
  final List<String>? rules;
  final String? logo;
  final String? banner;
  final String? logoUrl;
  final String? bannerUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userRole;
  final bool? canPost;
  final bool? canModerate;
  final bool? canAdmin;

  Group({
    required this.id,
    required this.name,
    this.description,
    this.creatorId,
    this.creatorName,
    this.admins,
    this.adminNames,
    this.moderators,
    this.moderatorNames,
    this.members,
    this.memberNames,
    this.bannedUsers,
    this.bannedUserNames,
    this.isPrivate,
    this.rules,
    this.logo,
    this.banner,
    this.logoUrl,
    this.bannerUrl,
    this.createdAt,
    this.updatedAt,
    this.userRole,
    this.canPost,
    this.canModerate,
    this.canAdmin,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      creatorId: json['creator_id'],
      creatorName: json['creator_name'],
      admins: _parseStringList(json['admins']),
      adminNames: _parseStringList(json['admin_names']),
      moderators: _parseStringList(json['moderators']),
      moderatorNames: _parseStringList(json['moderator_names']),
      members: _parseStringList(json['members']),
      memberNames: _parseStringList(json['member_names']),
      bannedUsers: _parseStringList(json['banned_users']),
      bannedUserNames: _parseStringList(json['banned_user_names']),
      isPrivate: json['is_private'],
      rules: _parseStringList(json['rules']),
      logo: json['logo'],
      banner: json['banner'],
      logoUrl: json['logo_url'],
      bannerUrl: json['banner_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      userRole: json['user_role'],
      canPost: json['can_post'],
      canModerate: json['can_moderate'],
      canAdmin: json['can_admin'],
    );
  }

  // Helper method to safely parse arrays from JSON
  static List<String>? _parseStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return null;
  }

  // Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creator_id': creatorId,
      'creator_name': creatorName,
      'admins': admins,
      'admin_names': adminNames,
      'moderators': moderators,
      'moderator_names': moderatorNames,
      'members': members,
      'member_names': memberNames,
      'banned_users': bannedUsers,
      'banned_user_names': bannedUserNames,
      'is_private': isPrivate,
      'rules': rules,
      'logo': logo,
      'banner': banner,
      'logo_url': logoUrl,
      'banner_url': bannerUrl,
      'user_role': userRole,
      'can_post': canPost,
      'can_moderate': canModerate,
      'can_admin': canAdmin,
    };
  }

  // Create a copy with modified fields
  Group copyWith({
    String? id,
    String? name,
    String? description,
    String? creatorId,
    String? creatorName,
    List<String>? admins,
    List<String>? adminNames,
    List<String>? moderators,
    List<String>? moderatorNames,
    List<String>? members,
    List<String>? memberNames,
    List<String>? bannedUsers,
    List<String>? bannedUserNames,
    bool? isPrivate,
    List<String>? rules,
    String? logo,
    String? banner,
    String? logoUrl,
    String? bannerUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userRole,
    bool? canPost,
    bool? canModerate,
    bool? canAdmin,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      admins: admins ?? this.admins,
      adminNames: adminNames ?? this.adminNames,
      moderators: moderators ?? this.moderators,
      moderatorNames: moderatorNames ?? this.moderatorNames,
      members: members ?? this.members,
      memberNames: memberNames ?? this.memberNames,
      bannedUsers: bannedUsers ?? this.bannedUsers,
      bannedUserNames: bannedUserNames ?? this.bannedUserNames,
      isPrivate: isPrivate ?? this.isPrivate,
      rules: rules ?? this.rules,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userRole: userRole ?? this.userRole,
      canPost: canPost ?? this.canPost,
      canModerate: canModerate ?? this.canModerate,
      canAdmin: canAdmin ?? this.canAdmin,
    );
  }
}
