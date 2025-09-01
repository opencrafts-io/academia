import 'package:academia/features/communities/data/models/community_model.dart';
import 'package:academia/features/communities/domain/entities/community.dart';

extension CommunityModelHelper on CommunityModel {
  Community toEntity() => Community(
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
    isPrivate: isPrivate,
    rules: rules,
    createdAt: createdAt,
    updatedAt: updatedAt,
    canPost: canPost,
    canModerate: canModerate,
  );
}

extension CommunityEntityHelper on Community {
  CommunityModel toData() => CommunityModel(
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
    isPrivate: isPrivate,
    rules: rules,
    createdAt: createdAt,
    updatedAt: updatedAt,
    canPost: canPost,
    canModerate: canModerate,
  );
}
