import 'dart:io';
import 'package:academia/features/sherehe/domain/domain.dart';
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
    required String eventDate,
    required String organizerId,
    required List<String> eventGenre,
    File? eventCardImage,
    File? eventPosterImage,
    File? eventBannerImage,
    required List<Ticket> tickets,
  }) async {
    return await repository.createEvent(
      eventName: eventName,
      eventDescription: eventDescription,
      eventLocation: eventLocation,
      eventDate: eventDate,
      organizerId: organizerId,
      eventGenre: eventGenre,
      eventCardImage: eventCardImage,
      eventPosterImage: eventPosterImage,
      eventBannerImage: eventBannerImage,
      tickets: tickets,
    );
  }
}
