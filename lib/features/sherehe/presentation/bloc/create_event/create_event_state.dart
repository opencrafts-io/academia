part of 'create_event_bloc.dart';

abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {
  final Event event;
  const CreateEventSuccess({required this.event});

  @override
  List<Object> get props => [event];
}

class CreateEventFailure extends CreateEventState {
  final String message;
  const CreateEventFailure({required this.message});

  @override
  List<Object> get props => [message];
}
