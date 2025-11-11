import 'package:equatable/equatable.dart';

class Attendee extends Equatable {
  final String id;
  final String userId;
  final String eventId;
  final bool deleteTag;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Attendee({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.deleteTag,
    required this.createdAt,
    required this.updatedAt,
  });

  Attendee copyWith({
    String? id,
    String? userId,
    String? eventId,
    bool? deleteTag,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attendee(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      deleteTag: deleteTag ?? this.deleteTag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    eventId,
    deleteTag,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}
