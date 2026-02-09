import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String? id;
  final String? eventId;
  final String ticketName;
  final int ticketPrice;
  final int? ticketQuantity;
  final bool? deleteTag;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Ticket({
    this.id,
    this.eventId,
    required this.ticketName,
    required this.ticketPrice,
    this.ticketQuantity,
    this.deleteTag,
    this.createdAt,
    this.updatedAt,
  });

  Ticket copyWith({
    String? id,
    String? eventId,
    String? ticketName,
    int? ticketPrice,
    int? ticketQuantity,
    bool? deleteTag,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ticket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      ticketName: ticketName ?? this.ticketName,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketQuantity: ticketQuantity ?? this.ticketQuantity,
      deleteTag: deleteTag ?? this.deleteTag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventId,
    ticketName,
    ticketPrice,
    ticketQuantity,
    deleteTag,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}
