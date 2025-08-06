part of 'create_event_bloc.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object?> get props => [];
}

class SubmitNewEvent extends CreateEventEvent {
  final Event event;
  final File? imageFile;

  const SubmitNewEvent({required this.event, this.imageFile});

  @override
  List<Object?> get props => [event, imageFile];
}
