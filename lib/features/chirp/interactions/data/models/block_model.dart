import 'package:drift/drift.dart';

@DataClassName('BlockData')
class BlockTable extends Table {
  IntColumn get id => integer()();

  @JsonKey('block_type')
  TextColumn get blockType => text().withLength(min: 1, max: 20)();

  @JsonKey('blocked_user')
  TextColumn get blockedUser => text().nullable()();

  @JsonKey('blocked_community')
  IntColumn get blockedCommunity => integer().nullable()();

  // Additional fields for display
  @JsonKey('blocked_name')
  TextColumn get blockedName => text().nullable()();

  @JsonKey('blocked_image')
  TextColumn get blockedImage => text().nullable()();

  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey('cached_at')
  DateTimeColumn get cachedAt => dateTime().nullable().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
