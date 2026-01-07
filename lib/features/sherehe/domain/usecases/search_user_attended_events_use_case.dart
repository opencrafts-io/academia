import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SearchUserAttendedEventsUseCase {
  final ShereheRepository repository;

  SearchUserAttendedEventsUseCase(this.repository);

  Future<Either<Failure, List<Attendee>>> call({required String query}) {
    return repository.searchUserAttendedEvents(query: query);
  }
}
