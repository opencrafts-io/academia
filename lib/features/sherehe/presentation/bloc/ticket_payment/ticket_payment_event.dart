part of 'ticket_payment_bloc.dart';

abstract class TicketPaymentEvent extends Equatable {
  const TicketPaymentEvent();

  @override
  List<Object> get props => [];
}

class PurchaseTicket extends TicketPaymentEvent {
  final String ticketId;
  final int ticketQuantity;
  final String phoneNumber;

  const PurchaseTicket({
    required this.ticketId,
    required this.ticketQuantity,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [ticketId, ticketQuantity, phoneNumber];
}

class ConfirmPayment extends TicketPaymentEvent {
  final String transId;

  const ConfirmPayment({required this.transId});

  @override
  List<Object> get props => [transId];
}

class ResetTicketPaymentState extends TicketPaymentEvent {
  const ResetTicketPaymentState();

  @override
  List<Object> get props => [];
}
