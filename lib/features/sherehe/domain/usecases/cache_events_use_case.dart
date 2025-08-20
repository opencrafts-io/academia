import 'package:academia/core/error/failures.dart';
import 'package:academia/features/sherehe/domain/entities/paginated_events.dart';
import 'package:academia/features/sherehe/domain/repository/sherehe_repository.dart';
import 'package:dartz/dartz.dart';

class CacheEventsUseCase {
  final ShereheRepository repository;

  CacheEventsUseCase(this.repository);

  Future<Either<Failure, PaginatedEvents>> call({
    required int page,
    required int limit,
  }) {
    return repository.getAllEvents(page: page, limit: limit);
  }
}
