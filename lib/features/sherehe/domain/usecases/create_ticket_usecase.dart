import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class CreateTicketUsecase {
  final ShereheRepository repository;

  CreateTicketUsecase(this.repository);

  Future<Either<Failure, Ticket>> call({
    required String eventId,
    required String ticketName,
    required int ticketPrice,
    required int ticketFor,
    required int ticketQuantity,
    required String scope,
    required List<int>? institutions,
    required String startDate,
    required String endDate,
  }) async {
    return repository.createTicket(
      eventId: eventId,
      ticketName: ticketName,
      ticketPrice: ticketPrice,
      ticketFor: ticketFor,
      ticketQuantity: ticketQuantity,
      scope: scope,
      institutions: institutions,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
