import 'package:drift/drift.dart';

class LeaderboardRank extends Table {
  TextColumn get id => text()();
  TextColumn get avatarUrl => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  @JsonKey("vibe_points")
  IntColumn get vibePoints =>
      integer().named("vibe_points").withDefault(Constant(0))();
  @JsonKey("vibe_rank")
  IntColumn get vibeRank => integer().named("vibe_rank")();
  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();
  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();
  @JsonKey("cached_at")
  DateTimeColumn get cachedAt =>
      dateTime().withDefault(Constant(DateTime.now())).nullable()();
}
