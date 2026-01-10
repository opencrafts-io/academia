part of 'ticket_payment_bloc.dart';

abstract class TicketPaymentState extends Equatable {
  const TicketPaymentState();

  @override
  List<Object> get props => [];
}

class TicketPaymentInitial extends TicketPaymentState {}

class TicketPaymentLoading extends TicketPaymentState {}

class TicketPaymentLoaded extends TicketPaymentState {
  final String message;

  const TicketPaymentLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class TicketPaymentError extends TicketPaymentState {
  final String message;

  const TicketPaymentError({required this.message});

  @override
  List<Object> get props => [message];
}
