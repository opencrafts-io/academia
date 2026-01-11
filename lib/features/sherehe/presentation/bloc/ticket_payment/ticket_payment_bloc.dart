import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_payment_event.dart';
part 'ticket_payment_state.dart';

class TicketPaymentBloc extends Bloc<TicketPaymentEvent, TicketPaymentState> {
  final PurchaseTicketUseCase purchaseTicket;
  final ConfirmPaymentUseCase confirmPayment;

  TicketPaymentBloc({
    required this.purchaseTicket,
    required this.confirmPayment,
  }) : super(StkPushInitial()) {
    on<PurchaseTicket>(_onPurchaseTicket);
    on<ConfirmPayment>(_onConfirmPayment);
  }

  Future<void> _onPurchaseTicket(
    PurchaseTicket event,
    Emitter<TicketPaymentState> emit,
  ) async {
    emit(StkPushLoading());

    final result = await purchaseTicket(
      ticketId: event.ticketId,
      ticketQuantity: event.ticketQuantity,
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) {
        emit(StkPushError(message: failure.message));
      },
      (transId) {
        emit(StkPushSent(transId: transId));
      },
    );
  }

  Future<void> _onConfirmPayment(
    ConfirmPayment event,
    Emitter<TicketPaymentState> emit,
  ) async {
    emit(ConfirmPaymentLoading(transId: event.transId));

    final result = await confirmPayment(transId: event.transId);

    result.fold(
      (failure) {
        emit(
          ConfirmPaymentError(transId: event.transId, message: failure.message),
        );
      },
      (status) {
        emit(ConfirmPaymentLoaded(transId: event.transId, status: status));
      },
    );
  }
}
