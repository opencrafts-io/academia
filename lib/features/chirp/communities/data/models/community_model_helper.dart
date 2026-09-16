import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/communities/data/dtos/community_api_dto.dart';
import 'package:academia/features/chirp/communities/domain/entities/community.dart';

extension CommunityApiDtoMapper on CommunityApiDto {
  db.Community toData() => db.Community(
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
    profilePictureUrl: profilePictureUrl,
    weeklyVisitorCount: weeklyVisitorCount,
    monthlyVisitorCount: monthlyVisitorCount,
    profilePictureWidth: profilePictureWidth,
    profilePictureHeight: profilePictureHeight,
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    memberCount: memberCount,
  );

  Community toEntity() => toData().toEntity();
}

extension CommunityModelHelper on db.Community {
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
    guidelines: List<String>.from(guidelines),
    bannerUrl: bannerUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    memberCount: memberCount,
  );
}

extension CommunityEntityHelper on Community {
  db.Community toData() => db.Community(
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
