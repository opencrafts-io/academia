part of 'ticket_stats_bloc.dart';

abstract class TicketStatsState extends Equatable {
  const TicketStatsState();

  @override
  List<Object?> get props => [];
}

class StatsInitialState extends TicketStatsState {}

class StatsLoadingState extends TicketStatsState {}

class StatsLoadedState extends TicketStatsState {
  final List<TicketStats> stats;

  const StatsLoadedState({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class StatsErrorState extends TicketStatsState {
  final String message;

  const StatsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateTicketLoading extends TicketStatsState {}

class UpdateTicketSuccess extends TicketStatsState {
  final Ticket ticket;

  const UpdateTicketSuccess({required this.ticket});

  @override
  List<Object?> get props => [ticket];
}

class UpdateTicketError extends TicketStatsState {
  final String message;

  const UpdateTicketError({required this.message});

  @override
  List<Object?> get props => [message];
}
