import '../domain.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final String url;
  final String location;
  final String time;
  final String date;
  final String organizer;
  final String imageUrl;
  final int numberOfAttendees;
  final List<String> genre;
  final String createdAt;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.time,
    required this.organizer,
    required this.imageUrl,
    required this.numberOfAttendees,
    required this.genre,
    required this.createdAt,
    required this.url,
  });
}


