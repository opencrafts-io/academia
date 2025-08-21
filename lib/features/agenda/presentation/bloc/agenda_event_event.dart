part of 'agenda_event_bloc.dart';

/// Abstract base class for all agenda event events
abstract class AgendaEventEvent extends Equatable {}

/// Event to fetch agenda events from remote source
class FetchAgendaEventsEvent extends AgendaEventEvent {
  final int page;
  final int pageSize;

  FetchAgendaEventsEvent({this.page = 1, this.pageSize = 100});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [page, pageSize];
}

/// Event to fetch cached agenda events from local storage
class FetchCachedAgendaEventsEvent extends AgendaEventEvent {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

/// Event to create a new agenda event
class CreateAgendaEventEvent extends AgendaEventEvent {
  final AgendaEvent agendaEvent;
  
  CreateAgendaEventEvent({required this.agendaEvent});

  @override
  List<Object?> get props => [agendaEvent];

  @override
  bool? get stringify => true;
}

/// Event to update an existing agenda event
class UpdateAgendaEventEvent extends AgendaEventEvent {
  final AgendaEvent agendaEvent;
  
  UpdateAgendaEventEvent({required this.agendaEvent});

  @override
  List<Object?> get props => [agendaEvent];

  @override
  bool? get stringify => true;
}

/// Event to delete an agenda event
class DeleteAgendaEventEvent extends AgendaEventEvent {
  final AgendaEvent agendaEvent;
  
  DeleteAgendaEventEvent({required this.agendaEvent});

  @override
  List<Object?> get props => [agendaEvent];

  @override
  bool? get stringify => true;
}
