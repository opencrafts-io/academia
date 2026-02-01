import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetAllEventScannersUsecase {
  final ShereheRepository repository;

  GetAllEventScannersUsecase(this.repository);

  Future<Either<Failure, PaginatedResult<Scanner>>> call({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    return repository.getEventScanners(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
