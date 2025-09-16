import 'package:academia/core/data/json_converter.dart';
import 'package:drift/drift.dart';

@DataClassName("CommunityData")
class CommunityTable extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();
  TextColumn get description => text().nullable()();

  @JsonKey("creator_id")
  TextColumn get creatorId => text().nullable()();

  @JsonKey("creator_name")
  TextColumn get creatorName => text().nullable()();

  /// Moderators (IDs)
  @JsonKey("moderators")
  TextColumn get moderators =>
      text().map(const JsonListConverter()).nullable()();

  /// Moderator names
  @JsonKey("moderator_names")
  TextColumn get moderatorNames =>
      text().map(const JsonListConverter()).nullable()();

  /// Members (IDs)
  @JsonKey("members")
  TextColumn get members => text().map(const JsonListConverter()).nullable()();

  /// Member names
  @JsonKey("member_names")
  TextColumn get memberNames =>
      text().map(const JsonListConverter()).nullable()();

  /// Banned users (IDs)
  @JsonKey("banned_users")
  TextColumn get bannedUsers =>
      text().map(const JsonListConverter()).nullable()();

  /// Banned user names
  @JsonKey("banned_user_names")
  TextColumn get bannedUserNames =>
      text().map(const JsonListConverter()).nullable()();

  @JsonKey("is_private")
  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();

  TextColumn get rules => text().map(const JsonListConverter()).nullable()();

  @JsonKey("logo_url")
  TextColumn get logoUrl => text().nullable()();

  @JsonKey("banner_url")
  TextColumn get bannerUrl => text().nullable()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();

  @JsonKey("can_moderate")
  BoolColumn get canModerate => boolean().withDefault(const Constant(false))();

  @JsonKey("can_post")
  BoolColumn get canPost => boolean().withDefault(const Constant(false))();

  @JsonKey("is_banned")
  BoolColumn get isBanned => boolean().withDefault(const Constant(false))();

  @JsonKey("member_count")
  IntColumn get memberCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
