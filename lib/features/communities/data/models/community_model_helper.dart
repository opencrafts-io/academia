import 'package:academia/database/database.dart';
import 'package:academia/features/communities/domain/entities/community.dart';

extension CommunityModelHelper on CommunityData {
  Community toEntity() => Community(
    id: id,
    name: name,
    description: description,
    creatorId: creatorId,
    creatorName: creatorName,
    moderators: List<String>.from(moderators ?? []),
    moderatorNames: List<String>.from(moderatorNames ?? []),
    members: List<String>.from(members ?? []),
    memberNames: List<String>.from(memberNames ?? []),
    bannedUsers: List<String>.from(bannedUsers ?? []),
    bannedUserNames: List<String>.from(bannedUserNames ?? []),
    rules: List<String>.from(rules ?? []),
    isPrivate: isPrivate,
    logoUrl: logoUrl,
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    canPost: canPost,
    canModerate: canModerate,
    isBanned: isBanned,
    memberCount: memberCount,
  );
}

extension CommunityEntityHelper on Community {
  CommunityData toData() => CommunityData(
    id: id,
    name: name,
    description: description,
    creatorId: creatorId,
    creatorName: creatorName,
    moderators: moderators,
    moderatorNames: moderatorNames,
    members: members,
    memberNames: memberNames,
    bannedUsers: bannedUsers,
    bannedUserNames: bannedUserNames,
    rules: rules,
    isPrivate: isPrivate,
    logoUrl: logoUrl,
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    canPost: canPost,
    canModerate: canModerate,
    isBanned: isBanned,
    memberCount: memberCount,
  );
}
