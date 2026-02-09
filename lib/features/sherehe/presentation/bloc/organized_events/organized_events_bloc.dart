import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'organized_events_event.dart';
part 'organized_events_state.dart';

class OrganizedEventsBloc
    extends Bloc<OrganizedEventsEvent, OrganizedEventsState> {
  final GetEventsByOrganizerIdUseCase getEventsByOrganizerIdUseCase;

  OrganizedEventsBloc({required this.getEventsByOrganizerIdUseCase})
    : super(OrganizedEventsInitial()) {
    on<FetchOrganizedEvents>(_onFetchOrganizedEvents);
  }

  Future<void> _onFetchOrganizedEvents(
    FetchOrganizedEvents event,
    Emitter<OrganizedEventsState> emit,
  ) async {
    emit(OrganizedEventsLoading());
    final result = await getEventsByOrganizerIdUseCase(
      organizerId: event.organizerId,
    );
    result.fold(
      (failure) {
        emit(OrganizedEventsError(message: failure.message));
      },
      (events) {
        emit(OrganizedEventsLoaded(events: events));
      },
    );
  }
}
