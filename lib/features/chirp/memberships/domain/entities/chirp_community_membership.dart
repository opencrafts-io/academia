class ChirpCommunityMembership {
  final int id;
  final String communityID;
  final String userID;
  final String role;
  final bool banned;
  final String? bannedByID;
  final String? bannedReason;
  final DateTime? bannedAt;
  final DateTime joinedAt;

  ChirpCommunityMembership({
    required this.id,
    required this.communityID,
    required this.userID,
    required this.role,
    this.banned = false,
    this.bannedByID,
    this.bannedReason,
    this.bannedAt,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  ChirpCommunityMembership copyWith({
    int? id,
    String? communityID,
    String? userID,
    String? role,
    bool? banned,
    String? bannedByID,
    String? bannedReason,
    DateTime? bannedAt,
    DateTime? joinedAt,
  }) {
    return ChirpCommunityMembership(
      id: id ?? this.id,
      communityID: communityID ?? this.communityID,
      userID: userID ?? this.userID,
      role: role ?? this.role,
      banned: banned ?? this.banned,
      bannedByID: bannedByID ?? this.bannedByID,
      bannedReason: bannedReason ?? this.bannedReason,
      bannedAt: bannedAt ?? this.bannedAt,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
