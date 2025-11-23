import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetTicketsByEventIdUseCase {
  final ShereheRepository repository;

  GetTicketsByEventIdUseCase(this.repository);

  Future<Either<Failure, List<Ticket>>> call({required String eventID}) async {
    return repository.getTicketByEventId(eventID);
  }
}
