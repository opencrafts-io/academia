import 'package:equatable/equatable.dart';

class TicketStats extends Equatable {
  final String ticketId;
  final String ticketName;
  final int ticketPrice;
  final int ticketsSold;
  final int ticketsRemaining;

  const TicketStats({
    required this.ticketId,
    required this.ticketName,
    required this.ticketPrice,
    required this.ticketsSold,
    required this.ticketsRemaining,
  });

  TicketStats copyWith({
    String? ticketId,
    String? ticketName,
    int? ticketPrice,
    int? ticketsSold,
    int? ticketsRemaining,
  }) {
    return TicketStats(
      ticketId: ticketId ?? this.ticketId,
      ticketName: ticketName ?? this.ticketName,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
    );
  }

  @override
  List<Object?> get props => [
    ticketId,
    ticketName,
    ticketPrice,
    ticketsSold,
    ticketsRemaining,
  ];

  @override
  bool? get stringify => true;
}
