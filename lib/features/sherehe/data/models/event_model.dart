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
  @JsonKey('image_url')
  TextColumn get imageUrl => text()();
  @JsonKey('number_of_attendees')
  IntColumn get numberOfAttendees => integer()();
  @JsonKey('organizer_id')
  TextColumn get organizerId => text()();
  @JsonKey('genre')
  TextColumn get genre => text()();

  @override
  Set<Column> get primaryKey => {id};
}
