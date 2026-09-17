import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.freezed.dart';

@freezed
abstract class Community with _$Community {
  const factory Community({
    required int id,
    required String name,
    String? description,
    @Default(false) bool nsfw,
    @Default(false) bool private,
    @Default(false) bool verified,
    required String visibility,
    required List<String> guidelines,
    @Default(0) int memberCount,
    @Default(0) int moderatorCount,
    @Default(0) int bannedUsersCount,
    @Default(0) int monthlyVisitorCount,
    @Default(0) int weeklyVisitorCount,
    String? banner,
    @Default(0) int bannerHeight,
    @Default(0) int bannerWidth,
    String? bannerUrl,
    String? profilePicture,
    @Default(0) int profilePictureHeight,
    @Default(0) int profilePictureWidth,
    String? profilePictureUrl,
    required String creatorId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Community;
}
