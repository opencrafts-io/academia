import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final int id;
  final String name;
  final String? description;
  final bool nsfw;
  final bool private;
  final bool verified;
  final String visibility;
  final int memberCount;
  final int moderatorCount;
  final int bannedUsersCount;
  final int monthlyVisitorCount;
  final int weeklyVisitorCount;
  final String? banner;
  final int bannerHeight;
  final int bannerWidth;
  final String? bannerUrl;
  final String? profilePicture;
  final int profilePictureHeight;
  final int profilePictureWidth;
  final String? profilePictureUrl;
  final String creatorId;
  final List<String> guidelines;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Community({
    required this.id,
    required this.name,
    this.description,
    this.nsfw = false,
    this.private = false,
    this.verified = false,
    required this.visibility,
    required this.guidelines,
    this.memberCount = 0,
    this.moderatorCount = 0,
    this.bannedUsersCount = 0,
    this.monthlyVisitorCount = 0,
    this.weeklyVisitorCount = 0,
    this.banner,
    this.bannerHeight = 0,
    this.bannerWidth = 0,
    this.bannerUrl,
    this.profilePicture,
    this.profilePictureHeight = 0,
    this.profilePictureWidth = 0,
    this.profilePictureUrl,
    required this.creatorId,
    required this.createdAt,
    required this.updatedAt,
  });

  Community copyWith({
    int? id,
    String? name,
    String? description,
    bool? nsfw,
    bool? private,
    bool? verified,
    String? visibility,
    int? memberCount,
    int? moderatorCount,
    int? bannedUsersCount,
    int? monthlyVisitorCount,
    int? weeklyVisitorCount,
    String? banner,
    int? bannerHeight,
    int? bannerWidth,
    String? bannerUrl,
    String? profilePicture,
    int? profilePictureHeight,
    int? profilePictureWidth,
    String? profilePictureUrl,
    String? creatorId,
    List<String>? guidelines,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      nsfw: nsfw ?? this.nsfw,
      private: private ?? this.private,
      verified: verified ?? this.verified,
      visibility: visibility ?? this.visibility,
      memberCount: memberCount ?? this.memberCount,
      moderatorCount: moderatorCount ?? this.moderatorCount,
      bannedUsersCount: bannedUsersCount ?? this.bannedUsersCount,
      monthlyVisitorCount: monthlyVisitorCount ?? this.monthlyVisitorCount,
      weeklyVisitorCount: weeklyVisitorCount ?? this.weeklyVisitorCount,
      banner: banner ?? this.banner,
      bannerHeight: bannerHeight ?? this.bannerHeight,
      bannerWidth: bannerWidth ?? this.bannerWidth,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      profilePicture: profilePicture ?? this.profilePicture,
      profilePictureHeight: profilePictureHeight ?? this.profilePictureHeight,
      profilePictureWidth: profilePictureWidth ?? this.profilePictureWidth,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      guidelines: guidelines ?? this.guidelines,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    nsfw,
    private,
    verified,
    visibility,
    memberCount,
    moderatorCount,
    bannedUsersCount,
    monthlyVisitorCount,
    weeklyVisitorCount,
    banner,
    bannerHeight,
    bannerWidth,
    bannerUrl,
    profilePicture,
    profilePictureHeight,
    profilePictureWidth,
    profilePictureUrl,
    creatorId,
    guidelines,
    createdAt,
    updatedAt,
  ];
}

