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
  final String eventStartDate;
  final String eventEndDate;
  final String organizerId;
  final List<String> eventGenre;
  final File? eventCardImage;
  final File? eventPosterImage;
  final File? eventBannerImage;
  final List<Ticket> tickets;
  final List<String> institutions;
  final String scope;
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
    required this.eventStartDate,
    required this.eventEndDate,
    required this.organizerId,
    required this.eventGenre,
    this.eventCardImage,
    this.eventPosterImage,
    this.eventBannerImage,
    required this.tickets,
    required this.institutions,
    required this.scope,
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
    eventStartDate,
    eventEndDate,
    organizerId,
    eventGenre,
    eventCardImage,
    eventPosterImage,
    eventBannerImage,
    tickets,
    institutions,
    scope,
    selectedPaymentType,
    paybillNumber,
    accountReference,
    tillNumber,
    sendMoneyPhoneNumber,
  ];
}
