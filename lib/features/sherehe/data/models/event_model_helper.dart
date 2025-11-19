import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

extension EventModelHelper on EventData {
  Event toEntity() => Event(
    id: id,
    eventName: eventName,
    eventDescription: eventDescription,
    eventLocation: eventLocation,
    eventDate: eventDate,
    attendeeCount: attendeeCount,
    organizerId: organizerId,
    eventCardImage: eventCardImage,
    eventPosterImage: eventPosterImage,
    eventBannerImage: eventBannerImage,
    eventGenre: List<String>.from(eventGenre ?? []),
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}

extension EventEntityHelper on Event {
  EventData toModel() => EventData(
    id: id,
    eventName: eventName,
    eventDescription: eventDescription,
    eventLocation: eventLocation,
    eventDate: eventDate,
    attendeeCount: attendeeCount,
    organizerId: organizerId,
    eventCardImage: eventCardImage,
    eventPosterImage: eventPosterImage,
    eventBannerImage: eventBannerImage,
    eventGenre: eventGenre,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}
