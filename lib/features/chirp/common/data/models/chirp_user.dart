import 'package:drift/drift.dart';

class ChirpUser extends Table {
  @JsonKey("user_id")
  TextColumn get userID => text()();

  @JsonKey("email")
  TextColumn get email => text().nullable()();

  @JsonKey("phone")
  TextColumn get phone => text().nullable()();

  @JsonKey("username")
  TextColumn get username => text().nullable()();

  @JsonKey("vibe_points")
  IntColumn get vibePoints => integer().withDefault(Constant(0))();

  @JsonKey("avatar_url")
  TextColumn get avatarUrl => text().nullable()();
  @JsonKey('created_at')
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  /// For storing the caching time that will be used in TTL
  @JsonKey("cached_at")
  DateTimeColumn get cachedAt =>
      dateTime().withDefault(Constant(DateTime.now())).nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {userID};
}
