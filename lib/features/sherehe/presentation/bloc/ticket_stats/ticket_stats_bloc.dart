import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_stats_event.dart';
part 'ticket_stats_state.dart';

class TicketStatsBloc extends Bloc<TicketStatsEvent, TicketStatsState> {
  final GetDashboardTicketStatsUsecase getDashboardTicketStats;

  TicketStatsBloc({required this.getDashboardTicketStats})
    : super(StatsInitialState()) {
    on<GetTicketStats>(_onGetTicketStats);
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
}
