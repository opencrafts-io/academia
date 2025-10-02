import 'package:academia/database/database.dart';
import 'package:academia/features/communities/domain/entities/community.dart';

extension CommunityModelHelper on CommunityData {
  Community toEntity() => Community(
    id: id,
    name: name,
    description: description,
    creatorId: creatorId,
    visibility: visibility,
    nsfw: nsfw,
    banner: banner,
    private: private,
    verified: verified,
    bannerWidth: bannerWidth,
    bannerHeight: bannerHeight,
    moderatorCount: moderatorCount,
    profilePicture: profilePicture,
    bannedUsersCount: bannedUsersCount,
    profilePictureUrl: profilePicture,
    weeklyVisitorCount: weeklyVisitorCount,
    monthlyVisitorCount: monthlyVisitorCount,
    profilePictureWidth: profilePictureWidth,
    profilePictureHeight: profilePictureHeight,
    guidelines: guidelines as List<String>,
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    memberCount: memberCount,
  );
}

extension CommunityEntityHelper on Community {
  CommunityData toData() => CommunityData(
    id: id,
    name: name,
    description: description,
    creatorId: creatorId,
    visibility: visibility,
    nsfw: nsfw,
    guidelines: guidelines,
    banner: banner,
    private: private,
    verified: verified,
    bannerWidth: bannerWidth,
    bannerHeight: bannerHeight,
    moderatorCount: moderatorCount,
    profilePicture: profilePicture,
    bannedUsersCount: bannedUsersCount,
    profilePictureUrl: profilePicture,
    weeklyVisitorCount: weeklyVisitorCount,
    monthlyVisitorCount: monthlyVisitorCount,
    profilePictureWidth: profilePictureWidth,
    profilePictureHeight: profilePictureHeight,
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    memberCount: memberCount,
  );
}
