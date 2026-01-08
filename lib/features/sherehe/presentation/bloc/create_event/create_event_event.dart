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
  final File? eventCardImage;
  final File? eventPosterImage;
  final File? eventBannerImage;
  final List<Ticket> tickets;
  final PaymentTypes? selectedPaymentType;
  final String? paybillNumber;
  final String? accountReference;
  final String? tillNumber;
  final String? sendMoneyPhoneNumber;

  const SubmitNewEvent({
    required this.eventName,
    required this.eventDescription,
    this.eventUrl,
    required this.eventLocation,
    required this.eventDate,
    required this.organizerId,
    required this.eventGenre,
    this.eventCardImage,
    this.eventPosterImage,
    this.eventBannerImage,
    required this.tickets,
    this.selectedPaymentType,
    this.paybillNumber,
    this.accountReference,
    this.tillNumber,
    this.sendMoneyPhoneNumber,
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
    selectedPaymentType,
    paybillNumber,
    accountReference,
    tillNumber,
    sendMoneyPhoneNumber,
  ];
}
