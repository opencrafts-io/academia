import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_ticket_selection_event.dart';
part 'user_ticket_selection_state.dart';

class UserTicketSelectionBloc
    extends Bloc<UserTicketSelectionEvent, UserTicketSelectionState> {
  final GetTicketsByEventIdUseCase getTicketsByEventId;

  UserTicketSelectionBloc({required this.getTicketsByEventId})
    : super(UserTicketInitial()) {
    on<FetchTicketsByEventId>(_onFetchTicketsByEventId);
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
}
