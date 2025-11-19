import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('EventData')
class EventTable extends Table {
  @JsonKey('id')
  TextColumn get id => text()();

  @JsonKey('event_name')
  TextColumn get eventName => text()();

  @JsonKey('event_description')
  TextColumn get eventDescription => text()();

  @JsonKey('event_location')
  TextColumn get eventLocation => text()();

  @JsonKey('event_date')
  TextColumn get eventDate => text()();

  @JsonKey('attendee_count')
  IntColumn get attendeeCount => integer()();

  @JsonKey('organizer_id')
  TextColumn get organizerId => text()();

  @JsonKey('event_card_image')
  TextColumn get eventCardImage => text().nullable()();

  @JsonKey('event_poster_image')
  TextColumn get eventPosterImage => text().nullable()();

  @JsonKey('event_banner_image')
  TextColumn get eventBannerImage => text().nullable()();

  @JsonKey('event_url')
  TextColumn get eventUrl => text().nullable()();

  @JsonKey('event_genre')
  TextColumn get eventGenre => text().map(JsonListConverter()).nullable()();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @JsonKey('updated_at')
  TextColumn get updatedAt => text()();

  @JsonKey('deleted_at')
  TextColumn get deletedAt => text().nullable()();
}
