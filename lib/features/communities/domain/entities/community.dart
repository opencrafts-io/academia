import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? creatorId;
  final String? creatorName;
  final List<String> moderators;
  final List<String> moderatorNames;
  final List<String> members;
  final List<String> memberNames;
  final List<String> bannedUsers;
  final List<String> bannedUserNames;
  final List<String> rules;
  final bool isPrivate;
  final String? logoUrl;
  final String? bannerUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool canPost;
  final bool canModerate;
  final bool isBanned; 
  final int memberCount;

  const Community({
    required this.id,
    required this.name,
    this.description,
    this.creatorId,
    this.creatorName,
    this.moderators = const [],
    this.moderatorNames = const [],
    this.members = const [],
    this.memberNames = const [],
    this.bannedUsers = const [],
    this.bannedUserNames = const [],
    this.rules = const [],
    this.isPrivate = false,
    this.logoUrl,
    this.bannerUrl,
    required this.createdAt,
    required this.updatedAt,
    this.canPost = false,
    this.canModerate = false,
    this.isBanned = false,
    this.memberCount = 0,
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
    List<String>? rules,
    bool? isPrivate,
    String? logoUrl,
    String? bannerUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? canPost,
    bool? canModerate,
    bool? isBanned, 
    int? memberCount,
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
      rules: rules ?? this.rules,
      isPrivate: isPrivate ?? this.isPrivate,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      canPost: canPost ?? this.canPost,
      canModerate: canModerate ?? this.canModerate,
      isBanned: isBanned ?? this.isBanned,
      memberCount: memberCount ?? this.memberCount,
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
    rules,
    isPrivate,
    logoUrl,
    bannerUrl,
    createdAt,
    updatedAt,
    canPost,
    canModerate,
    isBanned,
    memberCount,
  ];

  @override
  bool get stringify => true;
}
