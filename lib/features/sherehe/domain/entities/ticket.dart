import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String? id;
  final String? eventId;
  final String ticketName;
  final int ticketPrice;
  final int? ticketQuantity;
  final int? ticketFor;
  final List<int>? institutionIds;
  final String? scope;
  final String? startDate;
  final String? endDate;

  const Ticket({
    this.id,
    this.eventId,
    required this.ticketName,
    required this.ticketPrice,
    this.ticketQuantity,
    this.ticketFor,
    this.institutionIds,
    this.scope,
    this.startDate,
    this.endDate,
  });

  Ticket copyWith({
    String? id,
    String? eventId,
    String? ticketName,
    int? ticketPrice,
    int? ticketQuantity,
    int? ticketFor,
    List<int>? institutionIds,
    String? scope,
    String? startDate,
    String? endDate,
  }) {
    return Ticket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      ticketName: ticketName ?? this.ticketName,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketQuantity: ticketQuantity ?? this.ticketQuantity,
      ticketFor: ticketFor ?? this.ticketFor,
      institutionIds: institutionIds ?? this.institutionIds,
      scope: scope ?? this.scope,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventId,
    ticketName,
    ticketPrice,
    ticketQuantity,
    ticketFor,
    institutionIds,
    scope,
    startDate,
    endDate,
  ];

  @override
  bool? get stringify => true;
}
