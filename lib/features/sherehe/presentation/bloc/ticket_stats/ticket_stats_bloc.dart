import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_stats_event.dart';
part 'ticket_stats_state.dart';

class TicketStatsBloc extends Bloc<TicketStatsEvent, TicketStatsState> {
  final GetDashboardTicketStatsUsecase getDashboardTicketStats;
  final UpdateTicketUsecase updateTicket;
  final CreateTicketUsecase createTicket;

  TicketStatsBloc({
    required this.getDashboardTicketStats,
    required this.updateTicket,
    required this.createTicket,
  }) : super(StatsInitialState()) {
    on<GetTicketStats>(_onGetTicketStats);
    on<UpdateTicketQuantity>(_onUpdateTicket);
    on<CreateTicket>(_onAddTicket);
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

  Future<void> _onAddTicket(
    CreateTicket event,
    Emitter<TicketStatsState> emit,
  ) async {
    emit(AddTicketLoading());

    final result = await createTicket(
      eventId: event.eventId,
      ticketName: event.ticketName,
      ticketFor: event.ticketFor,
      ticketPrice: event.ticketPrice,
      ticketQuantity: event.ticketQuantity,
      scope: event.scope,
      startDate: event.startDate,
      endDate: event.endDate,
      institutions: event.institutions,
    );

    result.fold(
      (failure) => emit(AddTicketError(message: failure.message)),
      (ticket) => emit(AddTicketSuccess(ticket: ticket)),
    );
  }
}
