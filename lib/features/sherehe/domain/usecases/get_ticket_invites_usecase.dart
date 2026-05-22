import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetTicketInvitesUsecase {
  final ShereheRepository repository;

  GetTicketInvitesUsecase(this.repository);

  Future<Either<Failure, List<Invite>>> call(String ticketId) async {
    return repository.getTicketInvites(ticketId);
  }
}
