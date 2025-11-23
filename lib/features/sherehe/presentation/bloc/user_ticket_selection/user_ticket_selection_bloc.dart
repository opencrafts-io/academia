import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_ticket_selection_event.dart';
part 'user_ticket_selection_state.dart';

class UserTicketSelectionBloc
    extends Bloc<UserTicketSelectionEvent, UserTicketSelectionState> {
  final GetTicketsByEventIdUseCase getTicketsByEventId;
  final PurchaseTicketUseCase purchaseTicket;

  UserTicketSelectionBloc({
    required this.getTicketsByEventId,
    required this.purchaseTicket,
  }) : super(UserTicketInitial()) {
    on<FetchTicketsByEventId>(_onFetchTicketsByEventId);
    on<PurchaseTicket>(_onPurchaseTicket);
  }

  Future<void> _onFetchTicketsByEventId(
    FetchTicketsByEventId event,
    Emitter<UserTicketSelectionState> emit,
  ) async {
    emit(UserTicketLoading());

    final result = await getTicketsByEventId(eventID: event.eventId);

    result.fold(
      (failure) => emit(UserTicketError(failure.message)),
      (tickets) => emit(UserTicketLoaded(tickets: tickets)),
    );
  }

  Future<void> _onPurchaseTicket(
    PurchaseTicket event,
    Emitter<UserTicketSelectionState> emit,
  ) async {
    final currentState = state;

    // Did this to emit an error if tickets are not loaded yet or there is an error on loading tickets
    if (currentState is! UserTicketLoaded) {
      emit(const UserTicketError("Cannot purchase before tickets are loaded."));
      return;
    }

    emit(UserTicketPurchaseInProgress(existingTickets: currentState.tickets));

    final result = await purchaseTicket(
      ticketId: event.ticketId,
      ticketQuantity: event.ticketQuantity,
    );

    result.fold(
      (failure) {
        if (failure.message == "This ticket is sold out.") {
          emit(
            UserTicketSoldOut(
              existingTickets: currentState.tickets,
              message:
                  "Sorry the tickets for this event is currently sold out.",
            ),
          );
        } else {
          emit(
            UserTicketPurchaseFailed(
              existingTickets: currentState.tickets,
              message: failure.message,
            ),
          );
        }
        emit(UserTicketLoaded(tickets: currentState.tickets));
      },
      (attendee) {
        emit(UserTicketPurchased(attendee: attendee));
      },
    );
  }
}
