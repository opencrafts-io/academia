import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetEventScannerByUserId {
  final ShereheRepository repository;

  GetEventScannerByUserId(this.repository);

  Future<Either<Failure, String>> call({required String eventId}) async {
    return repository.getEventScannerByUserId(eventId: eventId);
  }
}
