import 'package:drift/drift.dart';

@DataClassName('EventData')
class EventTable extends Table {
  TextColumn get id => text()();

  @JsonKey('event_name')
  TextColumn get eventName => text()();

  @JsonKey('event_description')
  TextColumn get eventDescription => text()();

  @JsonKey('event_location')
  TextColumn get eventLocation => text()();

  @JsonKey('event_date')
  TextColumn get eventDate => text()();

  // Organizer
  @JsonKey('organizer_id')
  TextColumn get organizerId => text()();

  // Media
  @JsonKey('event_card_image')
  TextColumn get eventCardImage => text().nullable()();

  @JsonKey('event_poster_image')
  TextColumn get eventPosterImage => text().nullable()();

  @JsonKey('event_banner_image')
  TextColumn get eventBannerImage => text().nullable()();

  @JsonKey('event_url')
  TextColumn get eventUrl => text().nullable()();

  @JsonKey('event_genre')
  TextColumn get eventGenre => text().nullable()();

  @JsonKey('delete_tag')
  BoolColumn get deleteTag => boolean().withDefault(const Constant(false))();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @JsonKey('updatedAt')
  TextColumn get updatedAt => text()();
}
