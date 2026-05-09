import 'dart:io';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class CreateEventUseCase {
  final ShereheRepository repository;

  const CreateEventUseCase(this.repository);

  Future<Either<Failure, Event>> call({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventStartDate,
    required String eventEndDate,
    required String organizerId,
    required List<String> eventGenre,
    File? eventCardImage,
    File? eventPosterImage,
    File? eventBannerImage,
    required List<Ticket> tickets,
    List<int>? institutions,
    required String scope,
    PaymentTypes? selectedPaymentType,
    String? paybillNumber,
    String? accountReference,
    String? tillNumber,
    String? sendMoneyPhoneNumber,
  }) async {
    return await repository.createEvent(
      eventName: eventName,
      eventDescription: eventDescription,
      eventLocation: eventLocation,
      eventStartDate: eventStartDate,
      eventEndDate: eventEndDate,
      organizerId: organizerId,
      eventGenre: eventGenre,
      eventCardImage: eventCardImage,
      eventPosterImage: eventPosterImage,
      eventBannerImage: eventBannerImage,
      tickets: tickets,
      institutions: institutions,
      scope: scope,
      selectedPaymentType: selectedPaymentType,
      paybillNumber: paybillNumber,
      accountReference: accountReference,
      tillNumber: tillNumber,
      sendMoneyPhoneNumber: sendMoneyPhoneNumber,
    );
  }
}
