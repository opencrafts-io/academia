import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/agenda_event.dart';
import '../../domain/usecases/create_agenda_event.dart';
import '../../domain/usecases/delete_agenda_event.dart';
import '../../domain/usecases/list_agenda_events.dart';
import '../../domain/usecases/update_agenda_event.dart';
import 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  AgendaCubit({
    required ListAgendaEvents listAgendaEvents,
    required CreateAgendaEvent createAgendaEvent,
    required UpdateAgendaEvent updateAgendaEvent,
    required DeleteAgendaEvent deleteAgendaEvent,
  }) : _listAgendaEvents = listAgendaEvents,
       _createAgendaEvent = createAgendaEvent,
       _updateAgendaEvent = updateAgendaEvent,
       _deleteAgendaEvent = deleteAgendaEvent,
       super(const AgendaState());

  final ListAgendaEvents _listAgendaEvents;
  final CreateAgendaEvent _createAgendaEvent;
  final UpdateAgendaEvent _updateAgendaEvent;
  final DeleteAgendaEvent _deleteAgendaEvent;

  Future<void> loadRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _load(
      page: 1,
      startDate: startDate,
      endDate: endDate,
      replaceEvents: true,
    );
  }

  Future<void> reload() {
    return _load(
      page: state.page,
      startDate: state.startDate,
      endDate: state.endDate,
      replaceEvents: true,
    );
  }

  Future<void> loadNextPage() {
    if (!state.hasNextPage || state.isLoading || state.isLoadingPage) {
      return Future.value();
    }
    return _load(
      page: state.page + 1,
      startDate: state.startDate,
      endDate: state.endDate,
      appendEvents: true,
    );
  }

  Future<void> loadPreviousPage() {
    if (!state.hasPreviousPage || state.isLoading || state.isLoadingPage) {
      return Future.value();
    }
    return _load(
      page: state.page - 1,
      startDate: state.startDate,
      endDate: state.endDate,
      replaceEvents: true,
    );
  }

  Future<bool> create(AgendaEventDraft draft) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    final result = await _createAgendaEvent(draft);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, error: failure.message));
        return false;
      },
      (event) {
        emit(
          state.copyWith(
            isSaving: false,
            events: [event, ...state.events],
            clearError: true,
          ),
        );
        unawaited(reload());
        return true;
      },
    );
  }

  Future<bool> update(String id, AgendaEventDraft draft) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    final result = await _updateAgendaEvent(
      UpdateAgendaEventParams(id: id, draft: draft),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, error: failure.message));
        return false;
      },
      (event) {
        emit(
          state.copyWith(
            isSaving: false,
            events: state.events
                .map((current) => current.id == id ? event : current)
                .toList(),
            clearError: true,
          ),
        );
        unawaited(reload());
        return true;
      },
    );
  }

  Future<bool> delete(String id) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    final result = await _deleteAgendaEvent(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, error: failure.message));
        return false;
      },
      (_) {
        emit(
          state.copyWith(
            isSaving: false,
            events: state.events.where((event) => event.id != id).toList(),
            count: state.count > 0 ? state.count - 1 : 0,
            clearError: true,
          ),
        );
        unawaited(reload());
        return true;
      },
    );
  }

  Future<void> _load({
    required int page,
    required DateTime? startDate,
    required DateTime? endDate,
    bool appendEvents = false,
    bool replaceEvents = false,
  }) async {
    final isFirstPageLoad = page == 1;
    emit(
      state.copyWith(
        isLoading: isFirstPageLoad,
        isLoadingPage: !isFirstPageLoad,
        events: replaceEvents ? const [] : null,
        page: page,
        startDate: startDate,
        endDate: endDate,
        clearDates: startDate == null && endDate == null,
        clearNext: replaceEvents,
        clearPrevious: replaceEvents,
        clearError: true,
      ),
    );

    final result = await _listAgendaEvents(
      ListAgendaEventsParams(
        page: page,
        pageSize: state.pageSize,
        startDate: startDate,
        endDate: endDate,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isLoadingPage: false,
          error: failure.message,
        ),
      ),
      (agendaPage) {
        final events = appendEvents
            ? _mergeEvents(state.events, agendaPage.results)
            : agendaPage.results;
        emit(
          state.copyWith(
            events: events,
            count: agendaPage.count,
            page: page,
            next: agendaPage.next,
            previous: agendaPage.previous,
            isLoading: false,
            isLoadingPage: false,
            clearError: true,
          ),
        );
      },
    );
  }

  List<AgendaEvent> _mergeEvents(
    List<AgendaEvent> current,
    List<AgendaEvent> incoming,
  ) {
    final eventsById = {for (final event in current) event.id: event};
    for (final event in incoming) {
      eventsById[event.id] = event;
    }
    return eventsById.values.toList()..sort((a, b) {
      final aStart = a.startTime;
      final bStart = b.startTime;
      if (aStart == null) return 1;
      if (bStart == null) return -1;
      return aStart.compareTo(bStart);
    });
  }
}
