import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String name;
  final String description;
  final String url;
  final String location;
  final String time;
  final String date;
  final String organizer;
  final String imageUrl;
  final String organizerId;
  final int numberOfAttendees;
  final List<String> genre;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.time,
    required this.organizer,
    required this.imageUrl,
    required this.organizerId,
    required this.numberOfAttendees,
    required this.genre,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  Event copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? location,
    String? time,
    String? date,
    String? organizer,
    String? imageUrl,
    String? organizerId,
    int? numberOfAttendees,
    List<String>? genre,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      location: location ?? this.location,
      time: time ?? this.time,
      date: date ?? this.date,
      organizer: organizer ?? this.organizer,
      imageUrl: imageUrl ?? this.imageUrl,
      organizerId: organizerId ?? this.organizerId,
      numberOfAttendees: numberOfAttendees ?? this.numberOfAttendees,
      genre: genre ?? this.genre,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    url,
    location,
    time,
    date,
    organizer,
    imageUrl,
    organizerId,
    numberOfAttendees,
    genre,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}
