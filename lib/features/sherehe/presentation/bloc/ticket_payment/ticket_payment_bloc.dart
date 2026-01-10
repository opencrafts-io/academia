import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_payment_event.dart';
part 'ticket_payment_state.dart';

class TicketPaymentBloc extends Bloc<TicketPaymentEvent, TicketPaymentState> {
  final PurchaseTicketUseCase purchaseTicket;

  TicketPaymentBloc({required this.purchaseTicket})
    : super(TicketPaymentInitial()) {
    on<PurchaseTicket>(_onPurchaseTicket);
  }

  Future<void> _onPurchaseTicket(
    PurchaseTicket event,
    Emitter<TicketPaymentState> emit,
  ) async {
    emit(TicketPaymentLoading());

    final result = await purchaseTicket(
      ticketId: event.ticketId,
      ticketQuantity: event.ticketQuantity,
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) {
        emit(
          TicketPaymentError(
            message: failure.message,
          ),
        );
      },
      (message) {
        emit(TicketPaymentLoaded(message: "Ticket purchased successfully."));
      },
    );
  }
}
