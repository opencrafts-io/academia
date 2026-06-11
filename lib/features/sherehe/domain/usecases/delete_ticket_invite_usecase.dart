import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class DeleteTicketInviteUsecase {
  final ShereheRepository repository;

  DeleteTicketInviteUsecase(this.repository);

  Future<Either<Failure, String>> call({required String inviteId}) async {
    return repository.deleteTicketInvite(inviteId: inviteId);
  }
}
