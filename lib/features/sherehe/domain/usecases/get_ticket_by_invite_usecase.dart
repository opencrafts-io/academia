import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetTicketByInviteUsecase {
  final ShereheRepository repository;

  GetTicketByInviteUsecase(this.repository);

  Future<Either<Failure, Ticket>> call({required String invite}) async {
    return repository.getTicketByInvite(invite: invite);
  }
}
