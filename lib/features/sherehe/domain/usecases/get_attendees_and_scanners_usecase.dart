import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetAttendeesAndScannersUsecase {
  final ShereheRepository repository;

  GetAttendeesAndScannersUsecase(this.repository);

  Future<Either<Failure, DashboardStats>> call({
    required String eventId,
  }) async {
    return repository.getAttendeesAndScanners(eventId: eventId);
  }
}
