import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class DeleteEventScannerUsecase {
  final ShereheRepository repository;

  DeleteEventScannerUsecase(this.repository);

  Future<Either<Failure, void>> call({required String scannerId}) async {
    return repository.deleteEventScanner(scannerId: scannerId);
  }
}
