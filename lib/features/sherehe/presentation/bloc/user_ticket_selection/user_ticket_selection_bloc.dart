import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_ticket_selection_event.dart';
part 'user_ticket_selection_state.dart';

class UserTicketSelectionBloc
    extends Bloc<UserTicketSelectionEvent, UserTicketSelectionState> {
  final GetTicketsByEventIdUseCase getTicketsByEventId;
  final GetTicketByInviteUsecase getTicketsByInvite;

  UserTicketSelectionBloc({
    required this.getTicketsByEventId,
    required this.getTicketsByInvite,
  }) : super(UserTicketInitial()) {
    on<FetchTickets>(_onFetchTickets);
  }

  Future<void> _onFetchTickets(
    FetchTickets event,
    Emitter<UserTicketSelectionState> emit,
  ) async {
    emit(UserTicketLoading());

    if (event.invite != null) {
      final result = await getTicketsByInvite(invite: event.invite!);

      result.fold(
        (failure) => emit(UserTicketError(failure.message)),
        (ticket) => emit(UserTicketLoaded(tickets: [ticket])),
      );
    }

    // if invite is null, then we try to fetch the tickets by event id. This is the case when the user accesses the page via the sherehe details page

    final ticketsResult = await getTicketsByEventId(
      eventID: event.eventId ?? '',
    );

    ticketsResult.fold(
      (failure) => emit(UserTicketError(failure.message)),
      (tickets) => emit(UserTicketLoaded(tickets: tickets)),
    );
  }
}
