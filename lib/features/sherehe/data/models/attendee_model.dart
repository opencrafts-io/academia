import 'package:drift/drift.dart';

@DataClassName('AttendeeData')
class AttendeeTable extends Table {
  TextColumn get id => text()();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @JsonKey('event_id')
  TextColumn get eventId => text()();

  @JsonKey('delete_tag')
  BoolColumn get deleteTag => boolean()();

  @JsonKey('createdAt')
  TextColumn get createdAt => text()();

  @JsonKey('updatedAt')
  TextColumn get updatedAt => text()();
}
