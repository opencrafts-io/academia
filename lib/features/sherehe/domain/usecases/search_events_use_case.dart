import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SearchEventsUseCase {
  final ShereheRepository repository;

  SearchEventsUseCase(this.repository);

  Future<Either<Failure, List<Event>>> call({required String query}) {
    return repository.searchEvents(query: query);
  }
}
