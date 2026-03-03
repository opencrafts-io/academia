import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetEventScannerByUserIdUsecase {
  final ShereheRepository repository;

  GetEventScannerByUserIdUsecase(this.repository);

  Future<Either<Failure, String>> call({required String eventId}) async {
    return repository.getEventScannerByUserId(eventId: eventId);
  }
}
