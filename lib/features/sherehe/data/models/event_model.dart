import 'package:drift/drift.dart';
import 'package:academia/core/core.dart';

@DataClassName('EventData')
class EventTable extends Table with TableMixin {
  @JsonKey('name')
  TextColumn get name => text()();
  @JsonKey('description')
  TextColumn get description => text()();
  @JsonKey('url')
  TextColumn get url => text()();
  @JsonKey('location')
  TextColumn get location => text()();
  @JsonKey('time')
  TextColumn get time => text()(); 
  @JsonKey('date')
  TextColumn get date => text()();
  @JsonKey('organizer')
  TextColumn get organizer => text()(); 
  @JsonKey('event_card_image')
  TextColumn get imageUrl => text()();
  @JsonKey('number_of_attendees')
  IntColumn get numberOfAttendees => integer()();
  @JsonKey('organizer_id')
  IntColumn get organizerId => integer()();
  @JsonKey('genre')
  TextColumn get genre => text()();
  @JsonKey('poster')
  TextColumn get poster => text().nullable()();
  @JsonKey('banner')
  TextColumn get banner => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}