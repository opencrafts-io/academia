class Attendee {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String eventId;
  final String createdAt;

  const Attendee({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.eventId,
    required this.createdAt,
  });
}