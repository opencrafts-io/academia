import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class UpdateTicketInviteUsecase {
  final ShereheRepository repository;

  UpdateTicketInviteUsecase(this.repository);

  Future<Either<Failure, Invite>> call({
    required String inviteId,
    int? maxUses,
    String? expiresAt,
  }) async {
    return repository.updateTicketInvite(
      inviteId: inviteId,
      maxUses: maxUses,
      expiresAt: expiresAt,
    );
  }
}
