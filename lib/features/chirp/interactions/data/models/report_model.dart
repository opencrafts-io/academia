import 'package:drift/drift.dart';

@DataClassName('ReportData')
class ReportTable extends Table {
  IntColumn get id => integer()();

  @JsonKey('report_type')
  TextColumn get reportType => text().withLength(min: 1, max: 20)();

  @JsonKey('reported_user')
  TextColumn get reportedUser => text().nullable()();

  @JsonKey('reported_post')
  IntColumn get reportedPost => integer().nullable()();

  @JsonKey('reported_comment')
  IntColumn get reportedComment => integer().nullable()();

  @JsonKey('reported_community')
  IntColumn get reportedCommunity => integer().nullable()();

  TextColumn get reason => text()();

  TextColumn get status => text().withDefault(const Constant('pending'))();

  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @JsonKey('cached_at')
  DateTimeColumn get cachedAt => dateTime().nullable().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
