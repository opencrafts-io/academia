import '../../domain/entities/event.dart';
import 'event_model.dart';

extension EventModelHelper on EventModel {
  Event toEntity() => Event(
    id: id,
    name: name,
    description: description,
    date: date,
    location: location,
    time: time,
    organizer: organizer,
    imageUrl: imageUrl,
    organizerId: organizerId,
    numberOfAttendees: numberOfAttendees,
    genre: genre,
    createdAt: createdAt,
    url: url,
  );
}

extension EventEntityHelper on Event {
  EventModel toModel() => EventModel(
    id: id,
    name: name,
    description: description,
    date: date,
    location: location,
    time: time,
    organizer: organizer,
    imageUrl: imageUrl,
    organizerId: organizerId,
    numberOfAttendees: numberOfAttendees,
    genre: genre,
    createdAt: createdAt,
    url: url,
  );
}
