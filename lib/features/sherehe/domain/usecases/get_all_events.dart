import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';
//
class GetEvent{
  final ShereheRepository repository;

  GetEvent(this.repository);

  Future<Either<Failure, List<Event>>> execute({
    required int page,
    required int limit,
  }) async {
    return repository.getAllEvents(page: page, limit: limit);
  }
}