import '../../domain/domain.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.name,
    required super.description,
    required super.url,
    required super.location,
    required super.time,
    required super.date,
    required super.organizer,
    required super.imageUrl,
    required super.numberOfAttendees,
    required super.organizerId,
    required super.genre,
    required super.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      location: json['location'],
      time: json['time'], 
      date: json['date'], 
      organizer: json['organizer'],
      imageUrl: json['image_url'],
      numberOfAttendees: json['number_of_attendees'],
      organizerId: json['organizer_id'],
      genre: List<String>.from(json['genre'] ?? []),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'location': location,
      'time': time,
      'date': date,
      'organizer': organizer,
      'image_url': imageUrl,
      'number_of_attendees': numberOfAttendees,
      'organizer_id': organizerId,
      'genre': genre,
      'created_at': createdAt,
    };
  }
}
