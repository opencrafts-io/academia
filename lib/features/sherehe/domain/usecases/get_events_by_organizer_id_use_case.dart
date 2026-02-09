import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetEventsByOrganizerIdUseCase {
  final ShereheRepository repository;

  GetEventsByOrganizerIdUseCase(this.repository);

  Future<Either<Failure, List<Event>>> call({required String organizerId}) {
    return repository.getEventByOrganizerId(organizerId: organizerId);
  }
}
