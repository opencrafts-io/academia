import 'package:academia/features/institution/domain/usecases/get_all_cached_institutions_usecase.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_ticket_selection_event.dart';
part 'user_ticket_selection_state.dart';

class UserTicketSelectionBloc
    extends Bloc<UserTicketSelectionEvent, UserTicketSelectionState> {
  final GetTicketsByEventIdUseCase getTicketsByEventId;
  final GetAllCachedInstitutionsUsecase getAllCachedInstitutions;

  UserTicketSelectionBloc({
    required this.getTicketsByEventId,
    required this.getAllCachedInstitutions,
  }) : super(UserTicketInitial()) {
    on<FetchTicketsByEventId>(_onFetchTicketsByEventId);
  }

  Future<void> _onFetchTicketsByEventId(
    FetchTicketsByEventId event,
    Emitter<UserTicketSelectionState> emit,
  ) async {
    emit(UserTicketLoading());

    final ticketsResult = await getTicketsByEventId(eventID: event.eventId);

    final institutionsResult = await getAllCachedInstitutions(event.accountId);

    institutionsResult.fold(
      (failure) => emit(UserTicketError(failure.message)),
      (userInstitutions) {
        final userInstitutionIds = userInstitutions
            .map((e) => e.institutionId)
            .toSet();

        print("Institutions: $userInstitutionIds");

        ticketsResult.fold(
          (failure) => emit(UserTicketError(failure.message)),
          (tickets) {
            final filteredTickets = tickets.where((ticket) {
              final visibility = ticket.institutionIds;

              if (visibility == null || visibility.isEmpty) return true;

              return visibility.any(userInstitutionIds.contains);
            }).toList();

            emit(UserTicketLoaded(tickets: filteredTickets));
          },
        );
      },
    );
  }
}
