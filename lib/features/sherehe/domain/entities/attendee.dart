import 'package:equatable/equatable.dart';

class Attendee extends Equatable {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String eventId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;

  const Attendee({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
    required this.email
  });

  Attendee copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? eventId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? email,
  }) {
    return Attendee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      eventId: eventId ?? this.eventId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    middleName,
    lastName,
    eventId,
    createdAt,
    updatedAt,
    email,
  ];

  @override
  bool? get stringify => true;
}
