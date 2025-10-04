import 'package:drift/drift.dart';

class ChirpCommunityMembership extends Table {
  @JsonKey("id")
  IntColumn get id => integer()();

  @JsonKey("community_id")
  TextColumn get communityID => text()();

  @JsonKey("user_id")
  TextColumn get userID => text()();

  @JsonKey("role")
  TextColumn get role => text()();

  @JsonKey("banned")
  BoolColumn get banned => boolean().withDefault(Constant(false))();

  // The id of the user who banned this user
  @JsonKey("banned_by_id")
  TextColumn get bannedByID => text().nullable()();

  @JsonKey("banning_reason")
  TextColumn get bannedReason => text().nullable()();

  @JsonKey("banned_at")
  DateTimeColumn get bannedAt => dateTime().nullable()();

  @JsonKey('joined_at')
  DateTimeColumn get joinedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
