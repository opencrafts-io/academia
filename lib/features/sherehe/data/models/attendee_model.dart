import '../../domain/domain.dart';

class AttendeeModel extends Attendee  {
  const AttendeeModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.eventId,
    required super.createdAt,
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      id: json['id'].toString(),
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      eventId: json['event_id'].toString(),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'event_id': eventId,
      'created_at': createdAt,
    };
  }
}
