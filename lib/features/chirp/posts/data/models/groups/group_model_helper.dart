import 'dart:convert';
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/domain/entities/group.dart';

extension GroupEntityHelper on GroupEntity {
  Group toEntity() {
    return Group(
      id: id,
      name: name,
      description: description,
      creatorId: creatorId,
      creatorName: creatorName,
      admins: _parseStringList(admins),
      adminNames: _parseStringList(adminNames),
      moderators: _parseStringList(moderators),
      moderatorNames: _parseStringList(moderatorNames),
      members: _parseStringList(members),
      memberNames: _parseStringList(memberNames),
      bannedUsers: _parseStringList(bannedUsers),
      bannedUserNames: _parseStringList(bannedUserNames),
      isPrivate: isPrivate,
      rules: _parseStringList(rules),
      logo: logo,
      banner: banner,
      logoUrl: logoUrl,
      bannerUrl: bannerUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userRole: userRole,
      canPost: canPost,
      canModerate: canModerate,
      canAdmin: canAdmin,
    );
  }

  // Helper method to parse JSON string arrays from database
  List<String>? _parseStringList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.map((item) => item.toString()).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

extension GroupHelper on Group {
  GroupEntity toData() {
    return GroupEntity(
      id: id,
      name: name,
      description: description ?? '',
      creatorId: creatorId ?? '',
      creatorName: creatorName ?? '',
      admins: _encodeStringList(admins),
      adminNames: _encodeStringList(adminNames),
      moderators: _encodeStringList(moderators),
      moderatorNames: _encodeStringList(moderatorNames),
      members: _encodeStringList(members),
      memberNames: _encodeStringList(memberNames),
      bannedUsers: _encodeStringList(bannedUsers),
      bannedUserNames: _encodeStringList(bannedUserNames),
      isPrivate: isPrivate ?? false,
      rules: _encodeStringList(rules),
      logo: logo,
      banner: banner,
      logoUrl: logoUrl,
      bannerUrl: bannerUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      userRole: userRole,
      canPost: canPost ?? false,
      canModerate: canModerate ?? false,
      canAdmin: canAdmin ?? false,
    );
  }

  // Helper method to encode string lists as JSON for database storage
  String _encodeStringList(List<String>? list) {
    if (list == null) return '[]';
    return jsonEncode(list);
  }
}

// Extension for creating GroupEntity from JSON
extension GroupFromJson on Group {
  static Group fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      creatorId: json['creator_id'],
      creatorName: json['creator_name'],
      admins: _parseJsonStringList(json['admins']),
      adminNames: _parseJsonStringList(json['admin_names']),
      moderators: _parseJsonStringList(json['moderators']),
      moderatorNames: _parseJsonStringList(json['moderator_names']),
      members: _parseJsonStringList(json['members']),
      memberNames: _parseJsonStringList(json['member_names']),
      bannedUsers: _parseJsonStringList(json['banned_users']),
      bannedUserNames: _parseJsonStringList(json['banned_user_names']),
      isPrivate: json['is_private'],
      rules: _parseJsonStringList(json['rules']),
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

  // Helper method to parse arrays from JSON API responses
  static List<String>? _parseJsonStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return null;
  }
}

// Extension for converting Group to JSON
extension GroupToJson on Group {
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
}
