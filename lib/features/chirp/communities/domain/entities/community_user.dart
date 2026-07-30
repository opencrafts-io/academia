import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_user.freezed.dart';

@freezed
abstract class CommunityUser with _$CommunityUser {
  const factory CommunityUser({
    required String userId,
    required String userName,
    required String role,
  }) = _CommunityUser;
}
