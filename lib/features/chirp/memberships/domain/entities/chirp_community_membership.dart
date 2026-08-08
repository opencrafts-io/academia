import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_community_membership.freezed.dart';

@freezed
abstract class ChirpCommunityMembership with _$ChirpCommunityMembership {
  const factory ChirpCommunityMembership({
    required int id,
    required int communityID,
    required String userID,
    required String role,
    @Default(false) bool banned,
    String? bannedByID,
    String? bannedReason,
    DateTime? bannedAt,
    required DateTime joinedAt,
  }) = _ChirpCommunityMembership;
}
