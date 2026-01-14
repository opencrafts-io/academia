part of 'ticket_payment_bloc.dart';

abstract class TicketPaymentState extends Equatable {
  final String? transId;

  const TicketPaymentState({this.transId});

  @override
  List<Object?> get props => [transId];
}

class PurchaseInitial extends TicketPaymentState {
  const PurchaseInitial();
}

class PurchaseLoading extends TicketPaymentState {
  const PurchaseLoading();
}

class StkPushSent extends TicketPaymentState {
  const StkPushSent({required String transId}) : super(transId: transId);
}

class PurchaseError extends TicketPaymentState {
  final String message;

  const PurchaseError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FreeTicketBooked extends TicketPaymentState {
  final String attendeeId;
  final String message;

  const FreeTicketBooked({required this.attendeeId, required this.message});

  @override
  List<Object?> get props => [attendeeId, message];
}

class ConfirmPaymentLoading extends TicketPaymentState {
  const ConfirmPaymentLoading({required String transId})
    : super(transId: transId);
}

class ConfirmPaymentLoaded extends TicketPaymentState {
  final String status;

  const ConfirmPaymentLoaded({required String transId, required this.status})
    : super(transId: transId);

  @override
  List<Object?> get props => [transId, status];
}

class ConfirmPaymentError extends TicketPaymentState {
  final String message;

  const ConfirmPaymentError({required String transId, required this.message})
    : super(transId: transId);

  @override
  List<Object?> get props => [transId, message];
}
