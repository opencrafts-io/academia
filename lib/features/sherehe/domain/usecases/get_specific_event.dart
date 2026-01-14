import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetSpecificEvent {
  final ShereheRepository repository;

  GetSpecificEvent(this.repository);
  
  Future<Either<Failure, Event>> execute({required String eventId}) async {
    return repository.getEventById(eventId: eventId);
  }
}