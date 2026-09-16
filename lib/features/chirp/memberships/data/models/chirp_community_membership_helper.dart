import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/memberships/memberships.dart';

extension ChirpCommunityMembershipApiDtoMapper on ChirpCommunityMembershipApiDto {
  db.ChirpCommunityMembership toData() => db.ChirpCommunityMembership(
    id: id,
    role: role,
    userID: userID,
    banned: banned,
    joinedAt: joinedAt,
    communityID: communityID,
    bannedAt: bannedAt,
    bannedByID: bannedByID,
    bannedReason: bannedReason,
  );

  ChirpCommunityMembership toEntity() => toData().toEntity();
}

extension ChirpCommunityMembershipHelper on ChirpCommunityMembership {
  db.ChirpCommunityMembership toData() => db.ChirpCommunityMembership(
    id: id,
    role: role,
    userID: userID,
    banned: banned,
    joinedAt: joinedAt,
    communityID: communityID,
    bannedAt: bannedAt,
    bannedByID: bannedByID,
    bannedReason: bannedReason,
  );
}

extension ChirpCommunityMembershipDataHelper on db.ChirpCommunityMembership {
  ChirpCommunityMembership toEntity() => ChirpCommunityMembership(
    id: id,
    role: role,
    userID: userID,
    banned: banned,
    joinedAt: joinedAt,
    communityID: communityID,
    bannedAt: bannedAt,
    bannedByID: bannedByID,
    bannedReason: bannedReason,
  );
}
