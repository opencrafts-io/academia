import 'package:academia/features/streaks/data/streak_activity.dart';
import 'package:drift/drift.dart';

class StreakMilestone extends Table {
  TextColumn get id => text()();
  @JsonKey("activity_id")
  TextColumn get activityID => text().references(StreakActivity, #id)();
  @JsonKey("days_required")
  IntColumn get daysRequired => integer().withDefault(Constant(0))();
  @JsonKey("bonus_points")
  IntColumn get bonusPoints => integer().withDefault(Constant(0))();
  TextColumn get title => text()();
  TextColumn get description => text()();
  @JsonKey("is_active")
  BoolColumn get isActive => boolean()();
  // The time at which this activity milestone was cached
  @JsonKey('cached_at')
  DateTimeColumn get cachedAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
