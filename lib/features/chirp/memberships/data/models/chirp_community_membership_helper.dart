import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';

extension ChirpCommunityMembershipHelper on ChirpCommunityMembership {
  ChirpCommunityMembershipData toData() => ChirpCommunityMembershipData(
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

extension ChirpCommunityMembershipDataHelper on ChirpCommunityMembershipData {
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
