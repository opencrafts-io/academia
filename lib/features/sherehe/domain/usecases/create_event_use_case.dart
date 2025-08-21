import 'dart:io';
import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class CreateEventUseCase {
  final ShereheRepository repository;

  const CreateEventUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      Event event,
      File imageFile,
      File bannerImageFile,
      File cardImageFile,
      ) async {
    return await repository.createEvent(
      event,
      imageFile, // Poster
      bannerImageFile: bannerImageFile, // Banner
      cardImageFile: cardImageFile, // Card Image
    );
  }

  @override
  List<Object> get props => [repository];
}