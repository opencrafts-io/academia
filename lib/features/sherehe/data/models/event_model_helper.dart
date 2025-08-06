import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

extension EventModelHelper on EventData {
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
    // Convert comma-separated string to list
    genre: genre.split(',').map((e) => e.trim()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
    url: url,
  );
}

extension EventEntityHelper on Event {
  EventData toModel() => EventData(
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
    // Convert list to comma-separated string
    genre: genre.join(', '),
    createdAt: createdAt,
    updatedAt: updatedAt,
    url: url,
  );
}
