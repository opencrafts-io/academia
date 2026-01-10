import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class PurchaseTicketUseCase {
  final ShereheRepository repository;

  PurchaseTicketUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String ticketId,
    required int ticketQuantity,
    required String phoneNumber,
  }) async {
    return repository.purchaseTicket(
      ticketId: ticketId,
      ticketQuantity: ticketQuantity,
      phoneNumber: phoneNumber,
    );
  }
}
