import 'package:equatable/equatable.dart';

class TicketStats extends Equatable {
  final String ticketId;
  final String ticketName;
  final int ticketPrice;
  final int ticketsSold;
  final int ticketsRemaining;
  final String scope;

  const TicketStats({
    required this.ticketId,
    required this.ticketName,
    required this.ticketPrice,
    required this.ticketsSold,
    required this.ticketsRemaining,
    required this.scope,
  });

  TicketStats copyWith({
    String? ticketId,
    String? ticketName,
    int? ticketPrice,
    int? ticketsSold,
    int? ticketsRemaining,
    String? scope,
  }) {
    return TicketStats(
      ticketId: ticketId ?? this.ticketId,
      ticketName: ticketName ?? this.ticketName,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
      scope: scope ?? this.scope,
    );
  }

  @override
  List<Object?> get props => [
    ticketId,
    ticketName,
    ticketPrice,
    ticketsSold,
    ticketsRemaining,
    scope,
  ];

  @override
  bool? get stringify => true;
}
