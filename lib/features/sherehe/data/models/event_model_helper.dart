import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

extension EventModelHelper on EventData {
  Event toEntity() => Event(
    id: id,
    eventName: eventName,
    eventDescription: eventDescription,
    eventLocation: eventLocation,
    eventDate: eventDate,
    organizerId: organizerId,
    eventCardImage: eventCardImage,
    eventPosterImage: eventPosterImage,
    eventBannerImage: eventBannerImage,
    eventGenre: eventGenre,
    deleteTag: deleteTag,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension EventEntityHelper on Event {
  EventData toModel() => EventData(
    id: id,
    eventName: eventName,
    eventDescription: eventDescription,
    eventLocation: eventLocation,
    eventDate: eventDate,
    organizerId: organizerId,
    eventCardImage: eventCardImage,
    eventPosterImage: eventPosterImage,
    eventBannerImage: eventBannerImage,
    eventGenre: eventGenre,
    deleteTag: deleteTag,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
