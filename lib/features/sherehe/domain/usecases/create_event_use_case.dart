import 'dart:io';
import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class CreateEventUseCase  {
  final ShereheRepository repository;

  const CreateEventUseCase(this.repository);
  Future<Either<Failure, Unit>> call(Event event, File imageFile) async {
    return await repository.createEvent(event, imageFile);
  }

  List<Object> get props => [repository];
}