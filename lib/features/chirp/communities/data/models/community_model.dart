import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName("CommunityData")
class CommunityTable extends Table {
  @JsonKey("id")
  IntColumn get id => integer().autoIncrement()();

  @JsonKey("name")
  TextColumn get name => text()();

  @JsonKey("description")
  TextColumn get description => text().nullable()();

  @JsonKey("nsfw")
  BoolColumn get nsfw => boolean().withDefault(Constant(false))();

  @JsonKey("private")
  BoolColumn get private => boolean().withDefault(Constant(false))();

  @JsonKey("verified")
  BoolColumn get verified => boolean().withDefault(Constant(false))();

  @JsonKey("visibility")
  TextColumn get visibility => text()();

  @JsonKey("member_count")
  IntColumn get memberCount => integer().withDefault(Constant(0))();

  @JsonKey("moderator_count")
  IntColumn get moderatorCount => integer().withDefault(Constant(0))();

  @JsonKey("banned_users_count")
  IntColumn get bannedUsersCount => integer().withDefault(Constant(0))();

  @JsonKey("monthly_visitor_count")
  IntColumn get monthlyVisitorCount => integer().withDefault(Constant(0))();

  @JsonKey("weekly_visitor_count")
  IntColumn get weeklyVisitorCount => integer().withDefault(Constant(0))();

  @JsonKey("banner")
  TextColumn get banner => text().nullable()();

  @JsonKey("banner_height")
  IntColumn get bannerHeight => integer().withDefault(Constant(0))();

  @JsonKey("banner_width")
  IntColumn get bannerWidth => integer().withDefault(Constant(0))();

  @JsonKey("banner_url")
  TextColumn get bannerUrl => text().nullable()();

  @JsonKey("profile_picture")
  TextColumn get profilePicture => text().nullable()();

  @JsonKey("profile_picture_height")
  IntColumn get profilePictureHeight => integer().withDefault(Constant(0))();

  @JsonKey("profile_picture_width")
  IntColumn get profilePictureWidth => integer().withDefault(Constant(0))();

  @JsonKey("profile_picture_url")
  TextColumn get profilePictureUrl => text().nullable()();

  @JsonKey("creator_id")
  TextColumn get creatorId => text()();
  @JsonKey("guidelines")
  TextColumn get guidelines => text().map(JsonListConverter())();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();

  /// For storing the caching time that will be used in TTL
  @JsonKey("cached_at")
  DateTimeColumn get cachedAt =>
      dateTime().withDefault(Constant(DateTime.now())).nullable()();
}
