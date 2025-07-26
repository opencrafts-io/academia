import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetSpecificEvent {
  final ShereheRepository repository;

  GetSpecificEvent(this.repository);
  
  Future<Either<Failure, Event>> execute(String eventId) async {
    // Pass the eventId to the repository method
    return repository.getSpecificEvent(eventId);

  }
}