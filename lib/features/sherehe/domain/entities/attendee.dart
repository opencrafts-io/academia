import 'package:academia/features/sherehe/domain/entities/sherehe_user.dart';
import 'package:equatable/equatable.dart';

class Attendee extends Equatable {
  final String id;
  final String userId;
  final String eventId;
  final String ticketId;
  final int ticketQuantity;
  final ShereheUser user;

  const Attendee({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketId,
    required this.ticketQuantity,
    required this.user,
  });

  Attendee copyWith({
    String? id,
    String? userId,
    String? eventId,
    String? ticketId,
    int? ticketQuantity,
    ShereheUser? user,
  }) {
    return Attendee(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      ticketId: ticketId ?? this.ticketId,
      ticketQuantity: ticketQuantity ?? this.ticketQuantity,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    eventId,
    ticketId,
    ticketQuantity,
    user,
  ];

  @override
  bool? get stringify => true;
}
