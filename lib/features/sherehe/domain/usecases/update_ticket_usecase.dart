import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateTicketUsecase {
  final ShereheRepository repository;

  UpdateTicketUsecase(this.repository);

  Future<Either<Failure, Ticket>> call({
    required String ticketId,
    required int ticketQuantity,
  }) {
    return repository.updateTicket(
      ticketId: ticketId,
      ticketQuantity: ticketQuantity,
    );
  }
}
