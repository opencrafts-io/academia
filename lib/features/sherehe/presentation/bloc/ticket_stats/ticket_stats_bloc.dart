import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_stats_event.dart';
part 'ticket_stats_state.dart';

class TicketStatsBloc extends Bloc<TicketStatsEvent, TicketStatsState> {
  final GetDashboardTicketStatsUsecase getDashboardTicketStats;
  final UpdateTicketUsecase updateTicket;

  TicketStatsBloc({
    required this.getDashboardTicketStats,
    required this.updateTicket,
  }) : super(StatsInitialState()) {
    on<GetTicketStats>(_onGetTicketStats);
    on<UpdateTicketQuantity>(_onUpdateTicket);
  }

  Future<void> _onGetTicketStats(
    GetTicketStats event,
    Emitter<TicketStatsState> emit,
  ) async {
    emit(StatsLoadingState());

    final result = await getDashboardTicketStats(eventId: event.eventId);

    result.fold(
      (failure) => emit(StatsErrorState(message: failure.message)),
      (stats) => emit(StatsLoadedState(stats: stats)),
    );
  }

  Future<void> _onUpdateTicket(
    UpdateTicketQuantity event,
    Emitter<TicketStatsState> emit,
  ) async {
    emit(UpdateTicketLoading());

    final result = await updateTicket(
      ticketId: event.ticketId,
      ticketQuantity: event.ticketQuantity,
    );

    result.fold(
      (failure) => emit(UpdateTicketError(message: failure.message)),
      (ticket) => emit(UpdateTicketSuccess(ticket: ticket)),
    );
  }
}
