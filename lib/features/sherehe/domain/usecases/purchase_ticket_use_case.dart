import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class PurchaseTicketUseCase {
  final ShereheRepository repository;

  PurchaseTicketUseCase(this.repository);

  Future<Either<Failure, Attendee>> call({
    required String ticketId,
    required int ticketQuantity,
  }) async {
    return repository.purchaseTicket(
      ticketId: ticketId,
      ticketQuantity: ticketQuantity,
    );
  }
}
