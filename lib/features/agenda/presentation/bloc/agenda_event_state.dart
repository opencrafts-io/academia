part of 'agenda_event_bloc.dart';

/// Abstract base class for all agenda event states
abstract class AgendaEventState extends Equatable {}

/// Initial state when the BLoC is first created
class AgendaEventInitialState extends AgendaEventState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

/// State when an error occurs during agenda event operations
class AgendaEventErrorState extends AgendaEventState {
  final String error;
  
  AgendaEventErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

/// State when agenda events are successfully loaded
/// Contains a stream of agenda events for real-time updates
class AgendaEventLoadedState implements AgendaEventState {
  final Stream<List<AgendaEvent>> agendaEventsStream;
  
  AgendaEventLoadedState({required this.agendaEventsStream});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [agendaEventsStream];
}
