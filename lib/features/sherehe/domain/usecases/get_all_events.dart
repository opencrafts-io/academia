import 'package:academia/features/sherehe/domain/entities/paginated_events.dart';
import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';
//
class GetEvent{
  final ShereheRepository repository;

  GetEvent(this.repository);

  Future<Either<Failure, PaginatedEvents>> execute({
    required int page,
    required int limit,
  }) async {
    return repository.getAllEvents(page: page, limit: limit);
  }
}