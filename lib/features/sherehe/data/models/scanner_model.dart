import 'package:drift/drift.dart';

@DataClassName('ScannerData')
class ScannerTable extends Table {
  TextColumn get id => text()();

  @JsonKey('event_id')
  TextColumn get eventId => text()();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  TextColumn get role => text()();

  @JsonKey('granted_by')
  TextColumn get grantedBy => text()();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @JsonKey('updated_at')
  TextColumn get updatedAt => text()();

  @JsonKey('deleted_at')
  TextColumn get deletedAt => text().nullable()();
}
