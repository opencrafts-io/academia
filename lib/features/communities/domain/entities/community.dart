import 'package:equatable/equatable.dart';

class Community extends Equatable {
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

  const Community({
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

  Community copyWith({
    int? id,
    String? name,
    String? description,
    String? creatorId,
    String? creatorName,
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
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
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
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    creatorId,
    creatorName,
    moderators,
    moderatorNames,
    members,
    memberNames,
    bannedUsers,
    bannedUserNames,
    isPrivate,
    rules,
    logo,
    banner,
    logoUrl,
    bannerUrl,
    createdAt,
    updatedAt,
    userRole,
    canPost,
    canModerate,
  ];

  @override
  bool? get stringify => true;
}
