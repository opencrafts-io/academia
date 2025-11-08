import 'package:academia/core/core.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'agenda_event_state.dart';
part 'agenda_event_event.dart';

/// BLoC for managing agenda events
/// Handles CRUD operations for agenda events with proper state management
class AgendaEventBloc extends Bloc<AgendaEventEvent, AgendaEventState> {
  final GetCachedAgendaEventsUsecase getCachedAgendaEventsUsecase;
  final RefreshAgendaEventsUsecase refreshAgendaEventsUsecase;
  final CreateAgendaEventUsecase createAgendaEventUsecase;
  final UpdateAgendaEventUsecase updateAgendaEventUsecase;
  final DeleteAgendaEventUsecase deleteAgendaEventUsecase;

  AgendaEventBloc({
    required this.getCachedAgendaEventsUsecase,
    required this.refreshAgendaEventsUsecase,
    required this.createAgendaEventUsecase,
    required this.updateAgendaEventUsecase,
    required this.deleteAgendaEventUsecase,
  }) : super(AgendaEventInitialState()) {
    // Handle fetching cached agenda events
    on<FetchCachedAgendaEventsEvent>((event, emit) {
      final agendaEventsStream = getCachedAgendaEventsUsecase(NoParams());
      emit(AgendaEventLoadedState(agendaEventsStream: agendaEventsStream));
    });

    // Handle refreshing agenda events from remote
    on<FetchAgendaEventsEvent>((event, emit) async {
      final result = await refreshAgendaEventsUsecase(
        RefreshAgendaEventsParams(page: event.page, pageSize: event.pageSize),
      );
      return result.fold(
        (failure) {
          return emit(AgendaEventErrorState(error: failure.message));
        },
        (stream) {
          add(FetchCachedAgendaEventsEvent());
        },
      );
    });

    // Handle creating new agenda events
    on<CreateAgendaEventEvent>((event, emit) async {
      final result = await createAgendaEventUsecase(event.agendaEvent);
      return result.fold(
        (failure) {
          return emit(AgendaEventErrorState(error: failure.message));
        },
        (agendaEvent) {
          // Refresh the cached events to show the new event
          add(FetchCachedAgendaEventsEvent());
        },
      );
    });

    // Handle updating existing agenda events
    on<UpdateAgendaEventEvent>((event, emit) async {
      final result = await updateAgendaEventUsecase(event.agendaEvent);
      return result.fold(
        (failure) {
          return emit(AgendaEventErrorState(error: failure.message));
        },
        (agendaEvent) async {
          // Refresh the cached events to show the updated event
          add(FetchCachedAgendaEventsEvent());
        },
      );
    });

    // Handle deleting agenda events
    on<DeleteAgendaEventEvent>((event, emit) async {
      final result = await deleteAgendaEventUsecase(event.agendaEvent);
      return result.fold(
        (failure) {
          return emit(AgendaEventErrorState(error: failure.message));
        },
        (agendaEvent) async {
          // Refresh the cached events to reflect the deletion
          add(FetchCachedAgendaEventsEvent());
        },
      );
    });
  }
}
