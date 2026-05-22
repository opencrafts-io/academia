import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class CreateTicketInviteUsecase {
  final ShereheRepository repository;

  CreateTicketInviteUsecase(this.repository);

  Future<Either<Failure, String>> call({
    required String ticketId,
    required int maxUses,
    required String expiresAt,
  }) async {
    return repository.createTicketInvite(
      ticketId: ticketId,
      maxUses: maxUses,
      expiresAt: expiresAt,
    );
  }
}
