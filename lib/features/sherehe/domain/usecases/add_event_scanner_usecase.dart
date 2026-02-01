import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class AddEventScannerUsecase {
  final ShereheRepository repository;

  AddEventScannerUsecase(this.repository);

  Future<Either<Failure, Scanner>> call({
    required String eventId,
    required String userId,
  }) async {
    return repository.addEventScanner(eventId: eventId, userId: userId);
  }
}
