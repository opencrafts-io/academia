import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/data/models/purchase_ticket_result_model.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class PurchaseTicketUseCase {
  final ShereheRepository repository;

  PurchaseTicketUseCase(this.repository);

  Future<Either<Failure, PurchaseTicketResult>> call({
    required String ticketId,
    required int ticketQuantity,
    required String? phoneNumber,
  }) async {
    return repository.purchaseTicket(
      ticketId: ticketId,
      ticketQuantity: ticketQuantity,
      phoneNumber: phoneNumber,
    );
  }
}
