import 'package:drift/drift.dart';

// StreakActivity
// The StreakActivity model represents an activity which a user can take
// part in to earn vibepoints that are tracked as a streak

class StreakActivity extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text()();
  @JsonKey("points_awarded")
  IntColumn get pointsAwarded => integer().withDefault(Constant(0))();
  @JsonKey("max_daily_completions")
  IntColumn get maxDailyCompletions => integer().withDefault(Constant(0))();
  @JsonKey("streak_eligible")
  BoolColumn get streakEligible => boolean().withDefault(Constant(true))();
  @JsonKey("is_active")
  BoolColumn get isActive => boolean().withDefault(Constant(true))();

  // For storing creation time timestamp
  @JsonKey('created_at')
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  // For storing time of update timestamp
  @JsonKey('updated_at')
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  // The time at which this activity was cached
  @JsonKey('cached_at')
  DateTimeColumn get cachedAt =>
      dateTime().withDefault(Constant(DateTime.now())).nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
