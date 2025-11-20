part of 'create_event_bloc.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object?> get props => [];
}

class SubmitNewEvent extends CreateEventEvent {
  final String eventName;
  final String eventDescription;
  final String? eventUrl;
  final String eventLocation;
  final String eventDate;
  final String organizerId;
  final List<String> eventGenre;
  final File eventCardImage;
  final File eventPosterImage;
  final File eventBannerImage;
  final List<Ticket> tickets;

  const SubmitNewEvent({
    required this.eventName,
    required this.eventDescription,
    this.eventUrl,
    required this.eventLocation,
    required this.eventDate,
    required this.organizerId,
    required this.eventGenre,
    required this.eventCardImage,
    required this.eventPosterImage,
    required this.eventBannerImage,
    required this.tickets,
  });

  @override
  List<Object?> get props => [
    eventName,
    eventDescription,
    eventUrl,
    eventLocation,
    eventDate,
    organizerId,
    eventGenre,
    eventCardImage,
    eventPosterImage,
    eventBannerImage,
    tickets,
  ];
}
