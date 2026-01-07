import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/domain/entities/sherehe_user.dart';
import 'package:equatable/equatable.dart';

class Attendee extends Equatable {
  final String id;
  final String userId;
  final String eventId;
  final String ticketId;
  final int ticketQuantity;
  final ShereheUser? user;
  final Ticket? ticket;
  final Event? event;

  const Attendee({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketId,
    required this.ticketQuantity,
    this.user,
    this.ticket,
    this.event,
  });

  Attendee copyWith({
    String? id,
    String? userId,
    String? eventId,
    String? ticketId,
    int? ticketQuantity,
    ShereheUser? user,
    Ticket? ticket,
    Event? event,
  }) {
    return Attendee(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      ticketId: ticketId ?? this.ticketId,
      ticketQuantity: ticketQuantity ?? this.ticketQuantity,
      user: user ?? this.user,
      ticket: ticket ?? this.ticket,
      event: event ?? this.event,
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
    ticket,
    event,
  ];

  @override
  bool? get stringify => true;
}
